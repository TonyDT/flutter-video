/// 全局主题管理
library;

import 'package:flutter/material.dart';

/// 全局主题状态，支持浅色/深色切换和语言切换
class AppTheme extends ChangeNotifier {
  static final AppTheme _instance = AppTheme._internal();
  factory AppTheme() => _instance;
  AppTheme._internal();

  ThemeMode _mode = ThemeMode.light;
  Locale _locale = const Locale('zh');

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;
  Locale get locale => _locale;

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

  /// 切换语言
  void setLocale(Locale l) {
    if (_locale != l) {
      _locale = l;
      notifyListeners();
    }
  }

  /// 切换中英文
  void toggleLocale() {
    _locale = _locale.languageCode == 'zh' ? const Locale('en') : const Locale('zh');
    notifyListeners();
  }

  // --- 颜色常量 ---

  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFFA78BFA);

  // 深色系
  static const Color darkBg = Color(0xFF1E1E32);
  static const Color darkCardBg = Color(0xFF2D2D48);
  static const Color darkIconBg = Color(0xFF3A3A58);
  static const Color darkBorder = Color(0xFF3F3F5A);

  // 浅色系
  static const Color lightBg = Color(0xFFEDE7F6);
  static const Color lightCardBg = Colors.white;
  static const Color lightIconBg = Color(0xFFE8D5FF);
  static const Color lightBorder = Color(0xFFD4C4E8);

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
