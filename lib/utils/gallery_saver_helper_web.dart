// gallery_saver_helper_web.dart
//
// ## 模块说明
// 相册保存辅助类（Web 平台实现）
//
// ## 功能
// - Web 平台不支持保存到相册

/// 相册保存辅助类（Web 平台）
class GallerySaverHelper {
  /// Web 平台不支持保存到相册
  static Future<bool> saveFile(String path) async {
    return false;
  }
}
