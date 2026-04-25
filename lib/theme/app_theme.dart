/// 全局主题管理
library;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 支持的语言列表
const List<Locale> kSupportedLocales = [
  Locale('zh'),
  Locale('en'),
  Locale('ja'),
  Locale('es'),
];

/// 语言显示名称映射
const Map<String, String> kLocaleNames = {
  'zh': '中文',
  'en': 'English',
  'ja': '日本語',
  'es': 'Español',
};

/// 全局主题状态，支持浅色/深色切换和语言切换
class AppTheme extends ChangeNotifier {
  static final AppTheme _instance = AppTheme._internal();
  factory AppTheme() => _instance;
  AppTheme._internal();

  static const String _keyThemeMode = 'app_theme_mode';
  static const String _keyLocale = 'app_locale';

  ThemeMode _mode = ThemeMode.light;
  Locale _locale = const Locale('zh');

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;
  Locale get locale => _locale;

  /// 从本地存储加载偏好设置
  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt(_keyThemeMode);
    if (modeIndex != null && modeIndex >= 0 && modeIndex < ThemeMode.values.length) {
      _mode = ThemeMode.values[modeIndex];
    }
    final localeCode = prefs.getString(_keyLocale);
    if (localeCode != null && kSupportedLocales.any((l) => l.languageCode == localeCode)) {
      _locale = Locale(localeCode);
    }
    notifyListeners();
  }

  /// 切换主题
  void toggle() {
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    _saveThemeMode();
    notifyListeners();
  }

  /// 设置主题
  void setMode(ThemeMode m) {
    if (_mode != m) {
      _mode = m;
      _saveThemeMode();
      notifyListeners();
    }
  }

  /// 切换语言
  void setLocale(Locale l) {
    if (_locale != l) {
      _locale = l;
      _saveLocale();
      notifyListeners();
    }
  }

  /// 切换中英文
  void toggleLocale() {
    _locale = _locale.languageCode == 'zh' ? const Locale('en') : const Locale('zh');
    _saveLocale();
    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeMode, _mode.index);
  }

  Future<void> _saveLocale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, _locale.languageCode);
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
