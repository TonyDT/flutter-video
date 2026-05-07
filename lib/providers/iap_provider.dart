// iap_provider.dart
// 应用内购买管理 - 启动验证 + 购买/恢复/交付

import 'dart:async';
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
  int _freeCount = 0;
  bool _firstLaunchShown = false;
  ProductDetails? _productDetails;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool get isAvailable => _isAvailable;
  bool get hasPurchased => _hasPurchased;
  bool get isPurchasing => _isPurchasing;
  String? get error => _error;
  bool get isInitialized => _isInitialized;
  int get freeCount => _freeCount;
  bool get firstLaunchShown => _firstLaunchShown;
  ProductDetails? get productDetails => _productDetails;

  /// 商品标题（来自商店后台）
  String? get productTitle => _productDetails?.title;

  /// 商品描述（来自商店后台）
  String? get productDescription => _productDetails?.description;

  /// 商品价格（来自商店后台，含货币符号）
  String? get productPrice => _productDetails?.price;

  /// 商品原价（如有折扣则显示原价对比）
  String? get productRawPrice => _productDetails != null
      ? '${_productDetails!.currencySymbol}${_productDetails!.rawPrice}'
      : null;

  /// 商品ID（需与商店配置一致）
  static const String _premiumProductId = 'com.dt.videotoolkit.premium';

  /// 获取商品ID（供调试和UI使用）
  String get premiumProductId => _premiumProductId;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  /// 初始化
  Future<void> init() async {
    // 1. 先从本地加密存储读取购买状态
    _hasPurchased = await _storage.isPremiumUnlocked();
    log('Loaded from secure storage: hasPurchased=$_hasPurchased');

    // 2. 读取免费次数
    _freeCount = await _storage.getFreeCount();
    log('Free count: $_freeCount');

    // 3. 读取首次启动标记
    _firstLaunchShown = await _storage.isFirstLaunchShown();
    log('First launch shown: $_firstLaunchShown');
    notifyListeners();

    // 4. 检查商店是否可用
    final isAvailable = await _inAppPurchase.isAvailable();
    _isAvailable = isAvailable;
    log('In-App Purchase available: $isAvailable');
    if (!isAvailable) {
      log('In-App Purchase is not available — 请确认：1)设备安装了商店 2)Android添加了BILLING权限 3)商店账号已登录');
      _isInitialized = true;
      notifyListeners();
      return;
    }

    // 5. 监听购买流（必须在 restorePurchases 之前设置）
    _subscription = _inAppPurchase.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => log('Purchase stream done'),
      onError: (e) => log('Purchase stream error: $e'),
    );

    // 6. 查询商品信息（验证商品配置是否正确）并缓存
    log('Querying product details for: $_premiumProductId');
    final response = await _inAppPurchase.queryProductDetails({_premiumProductId});
    log('queryProductDetails result — notFoundIDs: ${response.notFoundIDs}, productCount: ${response.productDetails.length}');
    if (response.notFoundIDs.isNotEmpty) {
      log('⚠️ Product not found: ${response.notFoundIDs}');
      log('⚠️ 请检查商店后台：1)商品ID是否完全一致 2)商品状态是否Active 3)应用是否已上传到商店');
    }
    if (response.productDetails.isNotEmpty) {
      _productDetails = response.productDetails.first;
      log('✅ Product loaded: ${_productDetails?.title}, price: ${_productDetails?.price}, id: ${_productDetails?.id}');
    } else {
      log('⚠️ No product details returned — 商品未找到');
    }

    // 7. 启动时静默验证购买状态（等同于 queryPurchasesAsync）
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
      // 等待 purchaseStream 回调处理完毕（新设备首次启动需要从商店恢复购买状态）
      for (int i = 0; i < 30; i++) {
        if (_hasPurchased) break;
        await Future.delayed(const Duration(milliseconds: 100));
      }
      log('Startup verification done: hasPurchased=$_hasPurchased');
    } catch (e) {
      log('Verify purchases error: $e');
      // 验证失败不影响本地缓存的购买状态
    }
  }

  /// 购买流更新
  void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    // 逐个处理购买，确保交付完成后再确认交易
    _processPurchases(purchases);
  }

  /// 异步处理购买更新，确保交付完成后再确认交易
  Future<void> _processPurchases(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _isPurchasing = true;
          notifyListeners();
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _deliverProduct(purchase);
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
      // 确认交易完成（必须在交付成功后）
      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  /// 交付商品（async 确保持久化完成）
  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == _premiumProductId) {
      _hasPurchased = true;
      _isPurchasing = false;
      // 必须等待存储写入完成，防止 app 异常退出导致购买状态丢失
      await _storage.setPremiumUnlocked(true);
      log('Purchased saved to secure storage');
    }
    notifyListeners();
  }

  /// 发起购买
  Future<void> purchasePremium() async {
    if (!_isAvailable) {
      _error = '商店不可用，请确认设备已安装商店并登录账号';
      notifyListeners();
      return;
    }
    _isPurchasing = true;
    _error = null;
    notifyListeners();

    // 优先使用缓存的商品详情，避免重复查询
    ProductDetails? details = _productDetails;
    if (details == null) {
      log('缓存无商品详情，重新查询: $_premiumProductId');
      final response = await _inAppPurchase.queryProductDetails({_premiumProductId});
      log('重新查询结果 — notFoundIDs: ${response.notFoundIDs}, productCount: ${response.productDetails.length}');
      if (response.productDetails.isEmpty) {
        _error = '商品未找到 (ID: $_premiumProductId)，请检查商店后台配置';
        _isPurchasing = false;
        notifyListeners();
        return;
      }
      details = response.productDetails.first;
      _productDetails = details;
    }

    final purchaseParam = PurchaseParam(productDetails: details);
    log('发起购买: ${details.id}, price: ${details.price}');
    final launched = await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    if (!launched) {
      // 购买流未能启动（可能商店异常），重置状态避免卡死
      log('buyNonConsumable returned false — 购买流未启动');
      _error = '无法发起购买，请稍后重试';
      _isPurchasing = false;
      notifyListeners();
    }
  }

  /// 恢复购买（用户手动触发）
  Future<void> restorePurchases() async {
    if (!_isAvailable) {
      _error = '商店不可用';
      _isPurchasing = false;
      notifyListeners();
      return;
    }
    log('Restoring purchases...');
    _isPurchasing = true;
    _error = null;
    notifyListeners();

    try {
      await _inAppPurchase.restorePurchases();
      // 等待 purchaseStream 回调处理完毕
      // 最多等 3 秒，给网络足够时间
      for (int i = 0; i < 30; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (_hasPurchased) break;
      }
    } catch (e) {
      log('Restore purchases error: $e');
    }

    if (!_hasPurchased) {
      _error = '未找到已购买的商品';
    } else {
      _error = null;
    }
    _isPurchasing = false;
    notifyListeners();
  }

  /// 消费1次免费次数，返回剩余次数
  Future<int> consumeFreeCount() async {
    if (_hasPurchased) return StorageService.initialFreeCount; // 已购买不扣减
    final remaining = await _storage.decrementFreeCount();
    _freeCount = remaining;
    notifyListeners();
    return remaining;
  }

  /// 标记首次启动欢迎弹窗已显示
  Future<void> markFirstLaunchShown() async {
    await _storage.setFirstLaunchShown();
    _firstLaunchShown = true;
    notifyListeners();
  }
}
