/// 平台检测实现 - Web 平台
///
/// 当应用运行在 Web 环境时使用此实现
///
/// 由于 Web 平台无法直接访问操作系统信息，统一返回 'web'
library;

/// 获取当前运行环境标识
///
/// Web 环境下统一返回 'web'
///
/// 注意：Web 环境下无法精确获取用户操作系统类型，
/// 如需更精确的判断可考虑使用 dart:js_interop 或其他 Web API
String currentOperatingSystem() => 'web';
