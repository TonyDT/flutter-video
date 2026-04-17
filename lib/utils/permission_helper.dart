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
  /// 请求相册权限
  static Future<bool> requestPhotos() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }
}
