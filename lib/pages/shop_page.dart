// shop_page.dart
// 商店页面 - 高级版购买 / 恢复购买

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/iap_provider.dart';
import '../theme/app_theme.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.bg(context),
      appBar: AppBar(
        title: Text(l10n.premiumVersion),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<IAPProvider>(
        builder: (context, iap, _) {
          if (iap.hasPurchased) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, size: 72, color: Colors.green),
                  const SizedBox(height: 20),
                  Text(l10n.alreadyPremium, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary(context))),
                  const SizedBox(height: 8),
                  Text(l10n.alreadyPremiumDesc, style: TextStyle(fontSize: 14, color: AppTheme.textSecondary(context))),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // 图标
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFFA78BFA)]),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(Icons.workspace_premium, size: 52, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(l10n.unlockPremium, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textPrimary(context))),
                const SizedBox(height: 8),
                Text(l10n.unlockPremiumDesc, style: TextStyle(fontSize: 15, color: AppTheme.textSecondary(context))),
                const SizedBox(height: 36),
                // 功能列表
                _buildFeatureItem(context, Icons.all_inclusive, l10n.featureUnlimitedSave),
                _buildFeatureItem(context, Icons.speed, l10n.featureUnlimitedTools),
                _buildFeatureItem(context, Icons.update, l10n.featureFreeUpdates),
                _buildFeatureItem(context, Icons.block, l10n.featureNoAds),
                const SizedBox(height: 40),
                // 购买按钮
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: iap.isPurchasing ? null : () => iap.purchasePremium(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 2,
                    ),
                    child: iap.isPurchasing
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                        : Text(l10n.unlockNow, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 16),
                // 恢复购买
                TextButton(
                  onPressed: iap.isPurchasing ? null : () => iap.restorePurchases(),
                  child: Text(l10n.restorePurchases, style: TextStyle(color: AppTheme.textSecondary(context), fontSize: 14)),
                ),
                // 错误提示
                if (iap.error != null) ...[
                  const SizedBox(height: 12),
                  Text(iap.error!, style: const TextStyle(color: Colors.red, fontSize: 13), textAlign: TextAlign.center),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppTheme.iconBg(context), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 22, color: AppTheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: TextStyle(fontSize: 15, color: AppTheme.textPrimary(context)))),
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }
}
