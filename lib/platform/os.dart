/// 平台检测入口文件
///
/// 使用条件导入根据运行平台选择正确的实现：
/// - Web 环境：使用 [os_stub.dart]（返回 'web'）
/// - 其他平台：使用 [os_io.dart]（调用 Platform API）
///
/// 使用方式：
/// ```dart
/// import 'platform/os.dart';
/// final os = currentOperatingSystem();
/// ```
library;

// 条件导入：根据是否引入 dart:io 库选择对应实现
export 'os_stub.dart' if (dart.library.io) 'os_io.dart';
