/// ToolKit - 音视频处理工具集
library;

import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'platform/os.dart';
import 'pages/tool_tabs_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final os = currentOperatingSystem().toLowerCase();
    final isHarmony = os == 'ohos' || os == 'harmonyos';

    return ListenableBuilder(
      listenable: AppTheme(),
      builder: (context, child) {
        final theme = AppTheme();
        return MaterialApp(
          title: 'ToolKit',
          debugShowCheckedModeBanner: false,
          themeMode: theme.mode,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          home: isHarmony
              ? const HarmonyDevelopingPage()
              : const ToolTabsPage(),
        );
      },
    );
  }

  static ThemeData _buildLightTheme() => ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF7C3AED),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F9FC),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF8F9FC),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      foregroundColor: Color(0xFF1A1A2E),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF7C3AED),
      unselectedItemColor: Color(0xFF6B7280),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
      ),
    ),
  );

  static ThemeData _buildDarkTheme() => ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF7C3AED),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F0F1A),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F0F1A),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1A1A2E),
      selectedItemColor: Color(0xFF7C3AED),
      unselectedItemColor: Color(0xFF6B7280),
      type: BottomNavigationBarType.fixed,
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF1A1A2E),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: const Color(0xFF2A2A3E), width: 0.5),
      ),
    ),
  );
}

class HarmonyDevelopingPage extends StatelessWidget {
  const HarmonyDevelopingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.construction, size: 48),
                const SizedBox(height: 16),
                const Text('鸿蒙版正在开发中', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
