/// 相册保存统一工具 - 所有保存到相册的操作走这里
/// 流程：已购买→无限使用 | 未购买→检查免费次数→提示剩余→保存→扣减→次数为0跳转商店
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/iap_provider.dart';
import '../services/storage_service.dart';
import '../pages/shop_page.dart';
import 'gallery_saver_helper.dart'
    if (dart.library.io) 'gallery_saver_helper.dart'
    if (dart.library.html) 'gallery_saver_helper_web.dart';
import 'permission_helper.dart'
    if (dart.library.io) 'permission_helper.dart'
    if (dart.library.html) 'permission_helper_web.dart';
import 'top_notify.dart';

class SaveToGallery {
  static final StorageService _storage = StorageService();

  /// 检查是否已购买高级版
  static bool _isPremium(BuildContext context) {
    final iap = context.read<IAPProvider>();
    return iap.hasPurchased;
  }

  /// 次数不足时跳转商店页
  static void _navigateToShop(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopPage()));
  }

  /// 保存单个文件到相册
  ///
  /// 统一封装：购买检查 → 次数检查 → 权限检查 → 保存 → 结果提示
  static Future<bool> save(
    String path,
    BuildContext context, {
    String successMsg = '已保存到相册',
    String errorMsg = '保存失败',
  }) async {
    // 1. 已购买高级版，无限使用
    if (_isPremium(context)) {
      return _doSave(path, context, successMsg: successMsg, errorMsg: errorMsg);
    }

    // 2. 免费用户检查次数
    final count = await _storage.getFreeCount();
    if (count <= 0) {
      TopNotify.error(context, '免费次数已用完，请升级高级版');
      _navigateToShop(context);
      return false;
    }

    // 3. 提示当前剩余次数
    TopNotify.info(context, '免费次数剩余 $count 次');

    // 4. 保存
    final ok = await _doSave(path, context, successMsg: successMsg, errorMsg: errorMsg);
    if (ok) {
      final remaining = await _storage.decrementFreeCount();
      if (context.mounted) TopNotify.success(context, '$successMsg（剩余 $remaining 次）');
    }
    return ok;
  }

  /// 批量保存多个文件到相册
  static Future<int> saveAll(
    List<String> paths,
    BuildContext context, {
    String unit = '个',
  }) async {
    // 1. 已购买高级版，无限使用
    if (_isPremium(context)) {
      return _doSaveAll(paths, context, unit: unit);
    }

    // 2. 免费用户检查次数
    final count = await _storage.getFreeCount();
    if (count <= 0) {
      TopNotify.error(context, '免费次数已用完，请升级高级版');
      _navigateToShop(context);
      return 0;
    }

    // 3. 提示当前剩余次数
    TopNotify.info(context, '免费次数剩余 $count 次');

    // 4. 保存
    final saved = await _doSaveAll(paths, context, unit: unit);
    if (saved > 0) {
      final remaining = await _storage.decrementFreeCount();
      if (context.mounted) TopNotify.success(context, '已保存 $saved $unit到相册（剩余 $remaining 次）');
    }
    return saved;
  }

  /// 实际保存单个文件（无次数逻辑）
  static Future<bool> _doSave(
    String path,
    BuildContext context, {
    String successMsg = '已保存到相册',
    String errorMsg = '保存失败',
  }) async {
    final ok = await PermissionHelper.requestPhotos();
    if (ok != true) {
      if (context.mounted) TopNotify.error(context, '需要相册权限');
      return false;
    }
    try {
      final result = await GallerySaverHelper.saveFile(path);
      if (result == true) {
        if (context.mounted && !_isPremium(context)) TopNotify.success(context, successMsg);
        return true;
      } else {
        if (context.mounted) TopNotify.error(context, errorMsg);
        return false;
      }
    } catch (e) {
      if (context.mounted) TopNotify.error(context, '保存出错: $e');
      return false;
    }
  }

  /// 实际批量保存（无次数逻辑）
  static Future<int> _doSaveAll(
    List<String> paths,
    BuildContext context, {
    String unit = '个',
  }) async {
    final ok = await PermissionHelper.requestPhotos();
    if (ok != true) {
      if (context.mounted) TopNotify.error(context, '需要相册权限');
      return 0;
    }
    int saved = 0;
    for (final p in paths) {
      try {
        final r = await GallerySaverHelper.saveFile(p);
        if (r == true) saved++;
      } catch (_) {}
    }
    if (context.mounted && saved > 0 && !_isPremium(context)) {
      TopNotify.success(context, '已保存 $saved $unit到相册');
    } else if (context.mounted && saved == 0) {
      TopNotify.error(context, '保存失败');
    }
    return saved;
  }
}
