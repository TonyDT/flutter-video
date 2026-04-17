// native_file_helper.dart
//
// ## 模块说明
// 原生平台文件操作辅助类
//
// ## 功能
// - 提供平台兼容的文件创建方法
// - 在原生平台上返回 File 对象
//
// ## 使用说明
// 此文件仅在原生平台（Android/iOS）上编译
// Web 平台使用 VideoPlayerController.data() 方式

import 'dart:io';

/// 原生平台文件辅助类
///
/// 提供原生平台文件创建方法
class NativeFileHelper {
  /// 根据路径创建 File 对象
  ///
  /// [path] - 文件系统路径
  /// 返回 File 对象
  static dynamic getFile(String path) {
    return File(path);
  }
}
