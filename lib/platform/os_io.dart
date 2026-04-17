/// 平台检测实现 - Native 平台
///
/// 当应用运行在原生平台（iOS/Android/Desktop）时使用此实现
///
/// 通过 [Platform.operatingSystem] 获取操作系统名称
library;

import 'dart:io';

/// 获取当前操作系统名称
///
/// 返回值：
/// - 'android'：Android 系统
/// - 'ios'：iOS 系统
/// - 'macos'：macOS 系统
/// - 'windows'：Windows 系统
/// - 'linux'：Linux 系统
///
/// 注意：鸿蒙系统可能返回 'ohos' 或 'harmonyos'，具体取决于平台适配
String currentOperatingSystem() => Platform.operatingSystem;
