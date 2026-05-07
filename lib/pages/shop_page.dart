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
        backgroundColor: AppTheme.cardBg(context),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Consumer<IAPProvider>(
        builder: (context, iap, _) {
          if (iap.hasPurchased) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: AppTheme.primaryGradient),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.check_circle, size: 44, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(l10n.alreadyPremium, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary(context))),
                  const SizedBox(height: 8),
                  Text(l10n.alreadyPremiumDesc, style: TextStyle(fontSize: 14, color: AppTheme.textSecondary(context))),
                ],
              ),
            );
          }

          final product = iap.productDetails;
          final displayTitle = product?.title ?? l10n.unlockPremium;
          final displayDesc = product?.description ?? l10n.unlockPremiumDesc;
          final displayPrice = product?.price;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: AppTheme.primaryGradient),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.workspace_premium, size: 52, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(displayTitle, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textPrimary(context)), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(displayDesc, style: TextStyle(fontSize: 15, color: AppTheme.textSecondary(context)), textAlign: TextAlign.center),
                const SizedBox(height: 36),
                // 功能列表
                _buildFeatureItem(context, Icons.all_inclusive, l10n.featureUnlimitedSave, 0),
                _buildFeatureItem(context, Icons.speed, l10n.featureUnlimitedTools, 1),
                _buildFeatureItem(context, Icons.update, l10n.featureFreeUpdates, 2),
                _buildFeatureItem(context, Icons.block, l10n.featureNoAds, 3),
                const SizedBox(height: 40),
                // 价格展示
                if (displayPrice != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_offer, size: 20, color: AppTheme.primary),
                        const SizedBox(width: 8),
                        Text(displayPrice, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: iap.isPurchasing ? null : () => iap.purchasePremium(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 0,
                    ),
                    child: iap.isPurchasing
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                        : Text(
                            displayPrice != null ? '${l10n.unlockNow} · $displayPrice' : l10n.unlockNow,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: iap.isPurchasing ? null : () => iap.restorePurchases(),
                  child: Text(l10n.restorePurchases, style: TextStyle(color: AppTheme.textSecondary(context), fontSize: 14)),
                ),
                if (iap.error != null) ...[
                  const SizedBox(height: 12),
                  Text(iap.error!, style: const TextStyle(color: AppTheme.errorColor, fontSize: 13), textAlign: TextAlign.center),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text, int gradientIndex) {
    final gradient = AppTheme.toolGradients[gradientIndex % AppTheme.toolGradients.length];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: TextStyle(fontSize: 15, color: AppTheme.textPrimary(context)))),
          const Icon(Icons.check_circle, color: AppTheme.successColor, size: 20),
        ],
      ),
    );
  }
}
