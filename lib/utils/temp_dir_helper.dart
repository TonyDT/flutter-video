// temp_dir_helper.dart
//
// ## 模块说明
// 临时目录辅助类（原生平台实现）
//
// ## 功能
// - 提供 getTemporaryDirectory 方法
// - 原生平台使用 path_provider

import 'package:path_provider/path_provider.dart' as pp;

/// 临时目录辅助类（原生平台）
class TempDirHelper {
  /// 获取临时目录
  static Future<dynamic> getTemporaryDirectory() async {
    final tempDir = await pp.getTemporaryDirectory();
    return tempDir;
  }
}
