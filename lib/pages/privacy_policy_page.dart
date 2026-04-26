/// 隐私政策页面
///
/// 展示应用完整的隐私保护条款
library;

import 'package:flutter/material.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const _bg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1E3A5F), Color(0xFF3D5A80), Color(0xFF98C1D9)],
    stops: [0.0, 0.4, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _bg),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(l10n, context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildSection(l10n.updateDate, l10n.privacyDate),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section1Title),
                    _buildParagraph(l10n.section1Content),
                    _buildBulletItem(l10n.section1Item1),
                    _buildBulletItem(l10n.section1Item2),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section2Title),
                    _buildParagraph(l10n.section2Content),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section3Title),
                    _buildParagraph(l10n.section3Content),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section4Title),
                    _buildParagraph(l10n.section4Content),
                    _buildBulletItem(l10n.section4Item1),
                    _buildBulletItem(l10n.section4Item2),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section5Title),
                    _buildParagraph(l10n.section5Content),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section6Title),
                    _buildParagraph(l10n.section6Content),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section7Title),
                    _buildParagraph(l10n.section7Content),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section8Title),
                    _buildParagraph(l10n.section8Content),
                    const SizedBox(height: 16),

                    _buildSectionTitle(l10n.section9Title),
                    _buildParagraph(l10n.section9Content),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(AppLocalizations l10n, BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(ctx),
          ),
          Expanded(
            child: Text(
              l10n.privacyTitle,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSection(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14)),
          const SizedBox(width: 12),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 14, height: 1.6)),
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 14)),
          Expanded(child: Text(text, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 14, height: 1.5))),
        ],
      ),
    );
  }
}
