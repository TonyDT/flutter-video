/// 工具首页（底部Tab导航）
library;

import 'package:flutter/material.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/iap_provider.dart';
import '../theme/app_theme.dart';
import 'settings_page.dart';
import 'video_tools_page.dart';
import 'shop_page.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkFirstLaunch());
  }

  Future<void> _checkFirstLaunch() async {
    final iap = context.read<IAPProvider>();
    if (iap.hasPurchased) return;
    if (iap.firstLaunchShown) return;
    if (!mounted) return;
    _showWelcomeDialog(iap);
  }

  void _showWelcomeDialog(IAPProvider iap) {
    final l10n = AppLocalizations.of(context)!;
    final freeCount = iap.freeCount;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: AppTheme.primaryGradient),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.play_circle_filled, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(l10n.welcomeTitle, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary(context))),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.card_giftcard, size: 20, color: AppTheme.primary),
                    const SizedBox(width: 8),
                    Flexible(child: Text(l10n.welcomeFreeCount(freeCount), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.textPrimary(context)), textAlign: TextAlign.center)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Flexible(child: Text(l10n.welcomeUpgradeHint, style: TextStyle(fontSize: 13, color: AppTheme.textSecondary(context)), textAlign: TextAlign.center)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    iap.markFirstLaunchShown();
                    Navigator.pop(dialogCtx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text(l10n.welcomeGotIt, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    iap.markFirstLaunchShown();
                    Navigator.pop(dialogCtx);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopPage()));
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(l10n.welcomeUpgrade, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.bg(context),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBg(context),
          border: Border(top: BorderSide(color: AppTheme.borderColor(context), width: 0.5)),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: const Icon(Icons.grid_view_outlined), activeIcon: const Icon(Icons.grid_view), label: l10n.tabAll),
            BottomNavigationBarItem(icon: const Icon(Icons.settings_outlined), activeIcon: const Icon(Icons.settings), label: l10n.tabSettings),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.textSecondary(context),
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),
    );
  }
}
