// permission_helper_web.dart
//
// ## 模块说明
// 权限辅助类（Web 平台实现）
//
// ## 功能
// - Web 平台权限请求（无操作）

/// 权限辅助类（Web 平台）
class PermissionHelper {
  /// Web 平台权限请求（无操作）
  static Future<bool> requestPhotos() async {
    return true; // Web 平台不需要权限
  }
}
