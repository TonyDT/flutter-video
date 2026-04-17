// video_player_web_helper.dart
//
// ## 模块说明
// Web 平台视频播放器辅助类
//
// ## 功能
// - 将视频字节数据转换为 Blob URL
// - 创建可用于 VideoPlayerController.networkUrl() 的 URL
//
// ## 使用说明
// 此文件仅在 Web 平台上使用

import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web 平台视频播放器辅助类
class VideoPlayerWebHelper {
  /// 将字节数据转换为 Blob URL
  ///
  /// [bytes] - 视频文件字节数据
  /// [mimeType] - MIME 类型，默认 video/mp4
  ///
  /// 返回可用于 video 标签的 Blob URL
  static String bytesToBlobUrl(Uint8List bytes, {String? mimeType}) {
    // 根据字节头自动检测 MIME 类型
    String detectedMime = _detectMimeType(bytes, mimeType);
    final blob = html.Blob([bytes], detectedMime);
    final url = html.Url.createObjectUrlFromBlob(blob);
    return url;
  }

  /// 根据文件字节头自动检测 MIME 类型
  static String _detectMimeType(Uint8List bytes, String? fallback) {
    if (bytes.length < 12) {
      return fallback ?? 'video/mp4';
    }

    // 检测 WebM (0x1A 0x45 0xDF 0xA3)
    if (bytes[0] == 0x1A && bytes[1] == 0x45 && bytes[2] == 0xDF && bytes[3] == 0xA3) {
      return 'video/webm';
    }

    // 检测 MP4/MOV (ftyp box at offset 4)
    if (bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70) {
      // 检查 brand at offset 8
      if (bytes[8] == 0x69 && bytes[9] == 0x73 && bytes[10] == 0x6F && bytes[11] == 0x6D) {
        return 'video/mp4'; // isom
      }
      if (bytes[8] == 0x6D && bytes[9] == 0x70 && bytes[10] == 0x34 && bytes[11] == 0x31) {
        return 'video/mp4'; // mp41
      }
      if (bytes[8] == 0x6D && bytes[9] == 0x6F && bytes[10] == 0x6F && bytes[11] == 0x76) {
        return 'video/quicktime'; // moov
      }
      return 'video/mp4';
    }

    return fallback ?? 'video/mp4';
  }

  /// 释放 Blob URL
  ///
  /// [url] - 需要释放的 Blob URL
  static void revokeBlobUrl(String url) {
    html.Url.revokeObjectUrl(url);
  }
}
