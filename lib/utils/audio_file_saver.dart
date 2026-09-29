import 'dart:io';

import 'package:flutter/services.dart';

import 'gallery_saver_helper.dart';

class AudioFileSaver {
  static const MethodChannel _channel =
      MethodChannel('xixi_media_tool/media_saver');

  static Future<bool> saveAudioFile(String path, {String? name}) async {
    if (!Platform.isAndroid) {
      return GallerySaverHelper.saveFile(path);
    }

    final result = await _channel.invokeMethod<bool>('saveAudioFile', {
      'path': path,
      'name': name,
      'mimeType': _mimeTypeFor(path),
    });
    return result == true;
  }

  static String _mimeTypeFor(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.mp3')) return 'audio/mpeg';
    if (lower.endsWith('.m4a')) return 'audio/mp4';
    if (lower.endsWith('.aac')) return 'audio/aac';
    if (lower.endsWith('.wav')) return 'audio/wav';
    return 'audio/*';
  }
}
