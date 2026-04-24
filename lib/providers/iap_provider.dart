// iap_provider.dart
// 应用内购买管理 - 启动验证 + 购买/恢复/交付

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../services/storage_service.dart';

class IAPProvider extends ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final StorageService _storage = StorageService();

  bool _isAvailable = false;
  bool _hasPurchased = false;
  bool _isPurchasing = false;
  String? _error;
  bool _isInitialized = false;

  bool get isAvailable => _isAvailable;
  bool get hasPurchased => _hasPurchased;
  bool get isPurchasing => _isPurchasing;
  String? get error => _error;
  bool get isInitialized => _isInitialized;

  /// 商品ID（需与商店配置一致）
  static const String _premiumProductId = 'premium_unlock';

  /// 初始化
  Future<void> init() async {
    // 1. 先从本地加密存储读取购买状态
    _hasPurchased = await _storage.isPremiumUnlocked();
    log('Loaded from secure storage: hasPurchased=$_hasPurchased');
    notifyListeners();

    // 2. 检查商店是否可用
    final isAvailable = await _inAppPurchase.isAvailable();
    _isAvailable = isAvailable;
    if (!isAvailable) {
      log('In-App Purchase is not available');
      _isInitialized = true;
      notifyListeners();
      return;
    }

    // 3. 监听购买流（必须在 restorePurchases 之前设置）
    _inAppPurchase.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => log('Purchase stream done'),
      onError: (e) => log('Purchase stream error: $e'),
    );

    // 4. 查询商品信息（验证商品配置是否正确）
    final response = await _inAppPurchase.queryProductDetails({_premiumProductId});
    if (response.notFoundIDs.isNotEmpty) {
      log('Product not found: ${response.notFoundIDs}');
    }

    // 5. 启动时静默验证购买状态（等同于 queryPurchasesAsync）
    //    restorePurchases 会将已有购买通过 purchaseStream 回调到 _onPurchaseUpdate
    await _verifyPurchasesOnStartup();

    _isInitialized = true;
    notifyListeners();
  }

  /// 启动时静默验证购买状态
  Future<void> _verifyPurchasesOnStartup() async {
    try {
      log('Verifying purchases on startup...');
      await _inAppPurchase.restorePurchases();
      // restorePurchases 的结果会通过 purchaseStream 异步回调
      // _onPurchaseUpdate 会处理 PurchaseStatus.restored 状态
    } catch (e) {
      log('Verify purchases error: $e');
      // 验证失败不影响本地缓存的购买状态
    }
  }

  /// 购买流更新
  void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _isPurchasing = true;
          notifyListeners();
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _deliverProduct(purchase);
          break;
        case PurchaseStatus.error:
          _error = purchase.error?.message ?? '购买失败';
          _isPurchasing = false;
          log('Purchase error: ${purchase.error}');
          notifyListeners();
          break;
        case PurchaseStatus.canceled:
          _isPurchasing = false;
          notifyListeners();
          break;
        default:
          break;
      }
      // 确认交易完成
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  /// 交付商品
  void _deliverProduct(PurchaseDetails purchaseDetails) {
    if (purchaseDetails.productID == _premiumProductId) {
      _hasPurchased = true;
      _isPurchasing = false;
      _storage.setPremiumUnlocked(true);
      log('Purchased saved to secure storage');
    }
    notifyListeners();
  }

  /// 发起购买
  Future<void> purchasePremium() async {
    if (!_isAvailable) {
      _error = '商店不可用';
      notifyListeners();
      return;
    }
    _isPurchasing = true;
    _error = null;
    notifyListeners();

    final response = await _inAppPurchase.queryProductDetails({_premiumProductId});
    if (response.productDetails.isEmpty) {
      _error = '商品未找到';
      _isPurchasing = false;
      notifyListeners();
      return;
    }

    final productDetails = response.productDetails.first;
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// 恢复购买（用户手动触发）
  Future<void> restorePurchases() async {
    if (!_isAvailable) {
      _error = '商店不可用';
      notifyListeners();
      return;
    }
    log('Restoring purchases...');
    _isPurchasing = true;
    _error = null;
    notifyListeners();
    await _inAppPurchase.restorePurchases();
  }
}
