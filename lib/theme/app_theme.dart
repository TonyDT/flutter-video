/// 全局主题管理
library;

import 'package:flutter/material.dart';

/// 全局主题状态，支持浅色/深色切换
class AppTheme extends ChangeNotifier {
  static final AppTheme _instance = AppTheme._internal();
  factory AppTheme() => _instance;
  AppTheme._internal();

  ThemeMode _mode = ThemeMode.light;

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  /// 切换主题
  void toggle() {
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  /// 设置主题
  void setMode(ThemeMode m) {
    if (_mode != m) {
      _mode = m;
      notifyListeners();
    }
  }

  // --- 颜色常量 ---

  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFFA78BFA);

  // 深色系
  static const Color darkBg = Color(0xFF0F0F1A);
  static const Color darkCardBg = Color(0xFF2A2A45);
  static const Color darkIconBg = Color(0xFF353558);
  static const Color darkBorder = Color(0xFF3A3A55);

  // 浅色系
  static const Color lightBg = Color(0xFFF8F9FC);
  static const Color lightCardBg = Colors.white;
  static const Color lightIconBg = Color(0xFFF3E8FF);
  static const Color lightBorder = Color(0xFFE5E7EB);

  /// 根据当前模式获取颜色
  static Color bg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBg : lightBg;
  static Color cardBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCardBg : lightCardBg;
  static Color iconBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkIconBg : lightIconBg;
  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBorder : lightBorder;

  /// 获取文字颜色
  static Color textPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFFEAEAF0)
          : Theme.of(context).colorScheme.onSurface;
  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFFB0B0C8)
          : Theme.of(context).colorScheme.onSurfaceVariant;

  /// 获取主色调（不随明暗变化）
  static Color accentColor(BuildContext context) => primary;
}
