// video_player_web_helper_stub.dart
//
// ## 模块说明
// Web 平台视频播放器辅助类（原生平台存根）
//
// ## 功能
// - 原生平台不需要此功能，返回默认值
//
// ## 使用说明
// 此文件在 Android/iOS 平台上被使用

/// Web 平台视频播放器辅助类（原生平台存根）
class VideoPlayerWebHelper {
  /// 原生平台不支持，返回空字符串
  static String bytesToBlobUrl(dynamic bytes, {String mimeType = 'video/mp4'}) {
    return '';
  }

  /// 原生平台不需要释放操作
  static void revokeBlobUrl(String url) {}
}
