/// 设置页面
library;

import 'package:flutter/material.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';
// ignore_for_file: use_build_context_synchronously
import 'privacy_policy_page.dart';
import 'sdk_list_page.dart';
import 'iap_description_page.dart';
import '../theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: AppTheme.bg(context),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // 标题
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: AppTheme.primaryGradient),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.settings, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Text('ToolKit', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textPrimary(context), letterSpacing: -0.5)),
                  const Spacer(),
                  AppTheme.buildLanguageButton(context),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // 主题切换卡片
            _buildSectionCard(context, icon: Icons.dark_mode_outlined, title: l10n.appearance, children: [
              _buildThemeSwitch(context),
            ]),
            const SizedBox(height: 12),

            _buildSectionCard(context, icon: Icons.info_outline_rounded, title: l10n.aboutApp, children: [
              _buildInfoRow(context, l10n.appNameLabel, 'ToolKit'),
              _buildInfoRow(context, l10n.versionLabel, '1.0.0'),
              _buildInfoRow(context, l10n.developerLabel, 'xinyoushanhai888@gmail.com'),
              const SizedBox(height: 12), _buildOpenSourceNotice(context),
            ]),
            const SizedBox(height: 12),

            _buildNavigateCard(context, icon: Icons.privacy_tip_outlined, title: l10n.privacyPolicy, subtitle: l10n.viewPrivacyTerms,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()))),
            const SizedBox(height: 10),

            _buildNavigateCard(context, icon: Icons.extension_outlined, title: l10n.sdkList, subtitle: l10n.viewThirdPartyServices,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SdkListPage()))),
            const SizedBox(height: 10),

            _buildNavigateCard(context, icon: Icons.shop_outlined, title: l10n.iapDescription, subtitle: l10n.viewIapDetails,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const IapDescriptionPage()))),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSwitch(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appTheme = AppTheme();
    final isDark = appTheme.isDark;
    
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.iconBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () { appTheme.setMode(ThemeMode.light); },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !isDark ? AppTheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.light_mode_outlined, size: 18, color: !isDark ? Colors.white : AppTheme.textSecondary(context)),
                    const SizedBox(width: 6),
                    Text(l10n.lightMode, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: !isDark ? Colors.white : AppTheme.textSecondary(context))),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () { appTheme.setMode(ThemeMode.dark); },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dark_mode_outlined, size: 18, color: isDark ? Colors.white : AppTheme.textSecondary(context)),
                    const SizedBox(width: 6),
                    Text(l10n.darkMode, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isDark ? Colors.white : AppTheme.textSecondary(context))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(BuildContext ctx, {required IconData icon, required String title, required List<Widget> children}) => Container(
    decoration: BoxDecoration(
      color: AppTheme.cardBg(ctx),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppTheme.borderColor(ctx), width: 0.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: Theme.of(ctx).brightness == Brightness.dark ? 0.2 : 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppTheme.primaryGradient),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Text(title, style: TextStyle(color: AppTheme.textPrimary(ctx), fontSize: 17, fontWeight: FontWeight.w600)),
      ]),
      const SizedBox(height: 16), ...children,
    ])));

  Widget _buildInfoRow(BuildContext ctx, String label, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(width: 80, child: Text(label, style: TextStyle(color: AppTheme.textSecondary(ctx), fontSize: 14))),
    Expanded(child: Text(value, style: TextStyle(color: AppTheme.textPrimary(ctx), fontSize: 14, fontWeight: FontWeight.w500))),
  ]));

  Widget _buildOpenSourceNotice(BuildContext ctx) {
    final l10n = AppLocalizations.of(ctx)!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor(ctx),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor(ctx)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.code, color: AppTheme.primaryLight, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(l10n.openSourceNotice, style: TextStyle(color: AppTheme.textSecondary(ctx), fontSize: 12, height: 1.5))),
    ]));
  }

  Widget _buildNavigateCard(BuildContext ctx, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) => Material(
    color: AppTheme.cardBg(ctx), borderRadius: BorderRadius.circular(16),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor(ctx), width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: Theme.of(ctx).brightness == Brightness.dark ? 0.2 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppTheme.primaryGradient),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: AppTheme.textPrimary(ctx), fontSize: 16, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 3), Text(subtitle, style: TextStyle(color: AppTheme.textSecondary(ctx), fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
          ])),
          Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary(ctx).withValues(alpha: 0.4)),
        ]),
      ),
    ));
}
