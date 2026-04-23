/// 工具首页（底部Tab导航）
library;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_page.dart';
import 'video_tools_page.dart';

class ToolTabsPage extends StatefulWidget {
  const ToolTabsPage({super.key});

  @override
  State<ToolTabsPage> createState() => _ToolTabsPageState();
}

class _ToolTabsPageState extends State<ToolTabsPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [VideoToolsPage(), SettingsPage()];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bg = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E32)
        : const Color(0xFFEDE7F6);

    return Scaffold(
      backgroundColor: bg,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: const Icon(Icons.grid_view_outlined), activeIcon: const Icon(Icons.grid_view), label: l10n.tabAll),
          BottomNavigationBarItem(icon: const Icon(Icons.settings_outlined), activeIcon: const Icon(Icons.settings), label: l10n.tabSettings),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
