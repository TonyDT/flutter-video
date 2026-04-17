// native_file_helper_web.dart
//
// ## 模块说明
// Web 平台文件操作辅助类
//
// ## 功能
// - Web 平台空实现
// - 原生平台使用 native_file_helper.dart
//
// ## 使用说明
// 此文件仅在 Web 平台上编译
// Web 使用 VideoPlayerController.data() 方式加载视频

/// Web 平台文件辅助类
///
/// Web 平台不需要文件系统操作
class NativeFileHelper {
  /// Web 平台返回 null
  static dynamic getFile(String path) {
    return null;
  }
}
