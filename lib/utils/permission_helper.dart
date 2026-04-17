// permission_helper.dart
//
// ## 模块说明
// 权限辅助类（原生平台实现）
//
// ## 功能
// - 提供权限请求方法
// - 原生平台使用 permission_handler

import 'package:permission_handler/permission_handler.dart';

/// 权限辅助类（原生平台）
class PermissionHelper {
  /// 请求相册/存储权限
  static Future<bool> requestPhotos() async {
    // Android 13+ 使用细粒度媒体权限，Android 12 及以下使用存储权限
    if (await Permission.photos.isGranted) return true;

    final status = await Permission.photos.request();
    if (status.isGranted) return true;

    // Android 12 及以下回退到 storage 权限
    if (await Permission.storage.isDenied) {
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) return true;
    }

    // 权限被永久拒绝，引导用户去设置
    if (await Permission.photos.isPermanentlyDenied || await Permission.storage.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return false;
  }
}
