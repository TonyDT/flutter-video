// permission_helper.dart
//
// ## 模块说明
// 权限辅助类（Android 平台实现）
//
// ## 功能
// - 提供权限请求方法
// - Android 使用 permission_handler

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// 权限辅助类
class PermissionHelper {
  /// 请求相册/存储权限
  ///
  /// Android 13+: 使用 photos 权限
  /// Android 12-: 使用 storage 权限
  static Future<bool> requestPhotos() async {
    try {
      // 1. Android 13+ 使用 photos 权限（READ_MEDIA_IMAGES/VIDEO）
      if (await Permission.photos.isGranted) return true;
      final status = await Permission.photos.request();
      if (status.isGranted) return true;

      // 2. Android 12 及以下回退到 storage 权限
      if (await Permission.storage.isDenied) {
        final storageStatus = await Permission.storage.request();
        if (storageStatus.isGranted) return true;
      } else if (await Permission.storage.isGranted) {
        return true;
      }

      // 3. 权限被永久拒绝，引导用户去设置
      if (await Permission.photos.isPermanentlyDenied ||
          await Permission.storage.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }

      return false;
    } catch (e) {
      debugPrint('PermissionHelper.requestPhotos error: $e');
      return false;
    }
  }

  /// 请求音频/存储权限。
  ///
  /// Android 10+ 保存到 MediaStore 通常不需要写权限；这里主要兼容
  /// Android 9 及以下，以及部分 ROM 对媒体库访问的额外要求。
  static Future<bool> requestAudio() async {
    try {
      if (await Permission.audio.isGranted) return true;
      final audioStatus = await Permission.audio.request();
      if (audioStatus.isGranted) return true;

      if (await Permission.storage.isGranted) return true;
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) return true;

      if (await Permission.audio.isPermanentlyDenied ||
          await Permission.storage.isPermanentlyDenied) {
        await openAppSettings();
      }

      return false;
    } catch (e) {
      debugPrint('PermissionHelper.requestAudio error: $e');
      return false;
    }
  }
}
