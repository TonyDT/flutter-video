/// 内购说明页面
library;

import 'package:flutter/material.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class IapDescriptionPage extends StatelessWidget {
  const IapDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppTheme.bg(context), AppTheme.bg(context).withValues(alpha: 0.95)])),
        child: SafeArea(child: Column(children: [
          _buildAppBar(context, l10n.iapDescription),
          Expanded(child: ListView(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), children: [
            _buildSection(context, l10n.iapSection1Title, l10n.iapSection1Content),
            const SizedBox(height: 16),
            _buildSection(context, l10n.iapSection2Title, l10n.iapSection2Content),
            const SizedBox(height: 16),
            _buildSection(context, l10n.iapSection3Title, l10n.iapSection3Content),
            const SizedBox(height: 16),
            _buildSection(context, l10n.iapSection4Title, l10n.iapSection4Content),
            const SizedBox(height: 16),
            _buildSection(context, l10n.iapSection5Title, l10n.iapSection5Content),
            const SizedBox(height: 40),
          ])),
        ])),
      ),
    );
  }

  Widget _buildAppBar(BuildContext ctx, String title) => Container(
    padding: const EdgeInsets.only(left: 4, right: 16, top: 8, bottom: 8),
    child: Row(children: [
      IconButton(icon: Icon(Icons.arrow_back, color: AppTheme.textPrimary(ctx)), onPressed: () => Navigator.pop(ctx)),
      Expanded(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textPrimary(ctx)))),
    ]),
  );

  Widget _buildSection(BuildContext ctx, String title, String content) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppTheme.cardBg(ctx), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.borderColor(ctx), width: 0.5)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.primaryLight)),
      const SizedBox(height: 10),
      Text(content, style: TextStyle(fontSize: 14, color: AppTheme.textSecondary(ctx), height: 1.6)),
    ]),
  );
}
