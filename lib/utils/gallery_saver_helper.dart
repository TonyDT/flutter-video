// gallery_saver_helper.dart
//
// ## 模块说明
// 相册保存辅助类（原生平台实现）
//
// ## 功能
// - 提供保存文件到相册方法
// - 原生平台使用 image_gallery_saver_plus

import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

/// 相册保存辅助类（原生平台）
class GallerySaverHelper {
  /// 保存文件到相册
  static Future<bool> saveFile(String path) async {
    final result = await ImageGallerySaverPlus.saveFile(path);
    return result['isSuccess'] == true;
  }
}
