/// 相册保存统一工具 - 所有保存到相册的操作走这里
/// 流程：已购买→直接保存 | 未购买→弹窗提示购买→跳转商店页
library;

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/iap_provider.dart';
import '../pages/shop_page.dart';
import 'gallery_saver_helper.dart'
    if (dart.library.io) 'gallery_saver_helper.dart'
    if (dart.library.html) 'gallery_saver_helper_web.dart';
import 'permission_helper.dart'
    if (dart.library.io) 'permission_helper.dart'
    if (dart.library.html) 'permission_helper_web.dart';
import 'top_notify.dart';

class SaveToGallery {
  /// 检查是否已购买高级版
  static bool _isPremium(BuildContext context) {
    final iap = context.read<IAPProvider>();
    log('SaveToGallery._isPremium => hasPurchased=${iap.hasPurchased}');
    return iap.hasPurchased;
  }

  /// 未购买时弹窗提示购买
  static Future<bool> _showPurchaseDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.workspace_premium, color: Colors.amber[700], size: 28),
            const SizedBox(width: 10),
            const Text('升级高级版', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: const Text('保存到相册需要购买高级版，一次性购买后可无限使用所有功能。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('前往购买'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// 保存单个文件到相册
  ///
  /// 统一封装：购买检查 → 权限检查 → 保存 → 结果提示
  static Future<bool> save(
    String path,
    BuildContext context, {
    String successMsg = '已保存到相册',
    String errorMsg = '保存失败',
  }) async {
    try {
      final isPremium = _isPremium(context);
      log('SaveToGallery.save => isPremium=$isPremium');

      // 1. 未购买→弹窗提示购买
      if (!isPremium) {
        log('SaveToGallery.save => showing purchase dialog');
        final goPurchase = await _showPurchaseDialog(context);
        if (goPurchase && context.mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopPage()));
        }
        return false;
      }

      // 2. 已购买，直接保存
      return _doSave(path, context, successMsg: successMsg, errorMsg: errorMsg);
    } catch (e) {
      if (context.mounted) TopNotify.error(context, '$errorMsg: $e');
      return false;
    }
  }

  /// 批量保存多个文件到相册
  static Future<int> saveAll(
    List<String> paths,
    BuildContext context, {
    String unit = '个',
  }) async {
    try {
      final isPremium = _isPremium(context);
      log('SaveToGallery.saveAll => isPremium=$isPremium');

      // 1. 未购买→弹窗提示购买
      if (!isPremium) {
        log('SaveToGallery.saveAll => showing purchase dialog');
        final goPurchase = await _showPurchaseDialog(context);
        if (goPurchase && context.mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopPage()));
        }
        return 0;
      }

      // 2. 已购买，直接保存
      return _doSaveAll(paths, context, unit: unit);
    } catch (e) {
      if (context.mounted) TopNotify.error(context, '保存出错: $e');
      return 0;
    }
  }

  /// 实际保存单个文件
  static Future<bool> _doSave(
    String path,
    BuildContext context, {
    String successMsg = '已保存到相册',
    String errorMsg = '保存失败',
  }) async {
    try {
      final ok = await PermissionHelper.requestPhotos();
      if (ok != true) {
        if (context.mounted) TopNotify.error(context, '需要相册权限');
        return false;
      }
      final result = await GallerySaverHelper.saveFile(path);
      if (result == true) {
        if (context.mounted) TopNotify.success(context, successMsg);
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

  /// 实际批量保存
  static Future<int> _doSaveAll(
    List<String> paths,
    BuildContext context, {
    String unit = '个',
  }) async {
    try {
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
      if (context.mounted && saved > 0) {
        TopNotify.success(context, '已保存 $saved $unit到相册');
      } else if (context.mounted && saved == 0) {
        TopNotify.error(context, '保存失败');
      }
      return saved;
    } catch (e) {
      if (context.mounted) TopNotify.error(context, '保存出错: $e');
      return 0;
    }
  }
}
