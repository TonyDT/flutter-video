/// 全局主题管理
library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 支持的语言列表
const List<Locale> kSupportedLocales = [
  Locale('en'),
  Locale('zh'),
  Locale('ja'),
  Locale('es'),
  Locale('de'),
  Locale('fr'),
  Locale('pt'),
  Locale('ar'),
  Locale('ru'),
];

/// 语言显示名称映射
const Map<String, String> kLocaleNames = {
  'en': 'English',
  'zh': '中文',
  'ja': '日本語',
  'es': 'Español',
  'de': 'Deutsch',
  'fr': 'Français',
  'pt': 'Português',
  'ar': 'العربية',
  'ru': 'Русский',
};

/// 语言按钮短标签（右上角显示用）
const Map<String, String> kLocaleShortLabels = {
  'en': 'EN',
  'zh': '中',
  'ja': '日',
  'es': 'ES',
  'de': 'DE',
  'fr': 'FR',
  'pt': 'PT',
  'ar': 'AR',
  'ru': 'RU',
};

/// 语言旗帜emoji
const Map<String, String> kLocaleFlags = {
  'en': '🇺🇸',
  'zh': '🇨🇳',
  'ja': '🇯🇵',
  'es': '🇪🇸',
  'de': '🇩🇪',
  'fr': '🇫🇷',
  'pt': '🇧🇷',
  'ar': '🇸🇦',
  'ru': '🇷🇺',
};

/// 全局主题状态，支持浅色/深色/自动切换和语言切换
class AppTheme extends ChangeNotifier {
  static final AppTheme _instance = AppTheme._internal();
  factory AppTheme() => _instance;
  AppTheme._internal();

  static const String _keyThemeMode = 'app_theme_mode';
  static const String _keyLocale = 'app_locale';
  static const int _switchHour = 17; // 17:00 为分界点

  /// 根据时间判断应该使用哪种主题
  static ThemeMode _getTimeBasedThemeMode() {
    final hour = DateTime.now().hour;
    // 17:00 之前显示 Dark Mode，17:00 及之后显示 Light Mode
    return hour < _switchHour ? ThemeMode.dark : ThemeMode.light;
  }

  /// 判断当前是否应该使用深色主题（考虑自动模式）
  bool _shouldUseDarkMode() {
    if (_mode == ThemeMode.system) {
      return _getTimeBasedThemeMode() == ThemeMode.dark;
    }
    return _mode == ThemeMode.dark;
  }

  /// 获取实际生效的主题模式（解析 system 模式）
  ThemeMode get effectiveMode {
    if (_mode == ThemeMode.system) {
      return _getTimeBasedThemeMode();
    }
    return _mode;
  }

  ThemeMode _mode = ThemeMode.system; // 默认使用自动模式
  Locale _locale = const Locale('en');
  Timer? _themeTimer; // 定时器用于自动切换

  ThemeMode get mode => _mode;
  bool get isDark => _shouldUseDarkMode();
  Locale get locale => _locale;

  /// 初始化定时器，检测是否需要自动切换主题
  void _startThemeTimer() {
    _themeTimer?.cancel();
    // 每分钟检查一次
    _themeTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (_mode == ThemeMode.system) {
        notifyListeners();
      }
    });
  }

  /// 从本地存储加载偏好设置
  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt(_keyThemeMode);
    if (modeIndex != null && modeIndex >= 0 && modeIndex < ThemeMode.values.length) {
      _mode = ThemeMode.values[modeIndex];
    }
    // 如果没有保存过，默认使用自动模式
    if (prefs.getInt(_keyThemeMode) == null) {
      _mode = ThemeMode.system;
    }
    final localeCode = prefs.getString(_keyLocale);
    if (localeCode != null && kSupportedLocales.any((l) => l.languageCode == localeCode)) {
      _locale = Locale(localeCode);
    }
    _startThemeTimer();
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

  // --- 新配色方案 ---

  // 主色：优雅靛蓝
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);

  // 渐变色
  static const List<Color> primaryGradient = [Color(0xFF4F46E5), Color(0xFF7C3AED)];
  static const List<Color> accentGradient = [Color(0xFF6366F1), Color(0xFF8B5CF6)];

  // 深色系
  static const Color darkBg = Color(0xFF0F0F1A);
  static const Color darkCardBg = Color(0xFF1A1A2E);
  static const Color darkIconBg = Color(0xFF252542);
  static const Color darkBorder = Color(0xFF2A2A45);
  static const Color darkSurface = Color(0xFF16162B);

  // 浅色系
  static const Color lightBg = Color(0xFFF5F5FA);
  static const Color lightCardBg = Colors.white;
  static const Color lightIconBg = Color(0xFFEEF0FF);
  static const Color lightBorder = Color(0xFFE5E7F0);
  static const Color lightSurface = Color(0xFFFAFAFF);

  // 功能色
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);

  // 工具卡片专属渐变（11个工具，11组色）
  static const List<List<Color>> toolGradients = [
    [Color(0xFF6366F1), Color(0xFF8B5CF6)], // merge - 靛蓝紫
    [Color(0xFF3B82F6), Color(0xFF6366F1)], // cut - 蓝紫
    [Color(0xFF0EA5E9), Color(0xFF3B82F6)], // compress - 天蓝
    [Color(0xFF14B8A6), Color(0xFF0EA5E9)], // ratio - 青蓝
    [Color(0xFF10B981), Color(0xFF14B8A6)], // mute - 翠绿
    [Color(0xFFF59E0B), Color(0xFFF97316)], // dubbing - 暖橙
    [Color(0xFFEC4899), Color(0xFFF43F5E)], // extract - 玫粉
    [Color(0xFF8B5CF6), Color(0xFFEC4899)], // split - 紫粉
    [Color(0xFF6366F1), Color(0xFF06B6D4)], // separate - 靛青
    [Color(0xFFF97316), Color(0xFFEF4444)], // crop - 橙红
    [Color(0xFF8B5CF6), Color(0xFF3B82F6)], // convert - 紫蓝
  ];

  /// 根据当前模式获取颜色
  static Color bg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBg : lightBg;
  static Color cardBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCardBg : lightCardBg;
  static Color iconBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkIconBg : lightIconBg;
  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBorder : lightBorder;
  static Color surfaceColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkSurface : lightSurface;

  /// 获取文字颜色
  static Color textPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFFF0F0F8)
          : const Color(0xFF1A1A2E);
  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF9090B0)
          : const Color(0xFF6B7280);

  /// 获取主色调（不随明暗变化）
  static Color accentColor(BuildContext context) => primary;

  /// 构建右上角多语言按钮
  static Widget buildLanguageButton(BuildContext context) {
    final appTheme = AppTheme();
    final currentCode = appTheme.locale.languageCode;
    return GestureDetector(
      onTap: () => showLanguagePicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: primaryGradient),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.translate, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text(
              kLocaleShortLabels[currentCode] ?? currentCode.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 弹出语言选择面板
  static void showLanguagePicker(BuildContext context) {
    final appTheme = AppTheme();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetCtx).size.height * 0.55,
          ),
          decoration: BoxDecoration(
            color: cardBg(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 拖拽条
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 36, height: 4,
                decoration: BoxDecoration(
                  color: textSecondary(context).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // 标题
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: primaryGradient),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.translate, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Language',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 0.5),
              // 语言列表
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: kSupportedLocales.length,
                  itemBuilder: (_, index) {
                    final locale = kSupportedLocales[index];
                    final code = locale.languageCode;
                    final isSelected = appTheme.locale.languageCode == code;
                    return _buildLanguageOption(context, locale, isSelected, appTheme);
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildLanguageOption(BuildContext context, Locale locale, bool isSelected, AppTheme appTheme) {
    final code = locale.languageCode;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          appTheme.setLocale(locale);
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? primary.withValues(alpha: 0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: isSelected
                ? Border.all(color: primary.withValues(alpha: 0.3), width: 1.5)
                : Border.all(color: Colors.transparent, width: 1.5),
          ),
          child: Row(
            children: [
              // 旗帜圆圈
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? primary.withValues(alpha: 0.12) : iconBg(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    kLocaleFlags[code] ?? '🌐',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // 语言名
              Expanded(
                child: Text(
                  kLocaleNames[code] ?? code,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? primary : textPrimary(context),
                  ),
                ),
              ),
              // 选中标记
              if (isSelected)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: primaryGradient),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
