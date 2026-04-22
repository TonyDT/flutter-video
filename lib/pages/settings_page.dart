/// 设置页面
library;

import 'package:flutter/material.dart';
// ignore_for_file: use_build_context_synchronously
import 'privacy_policy_page.dart';
import 'sdk_list_page.dart';
import '../theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: AppTheme.bg(context), child: SafeArea(child: ListView(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), children: [
      Container(padding: const EdgeInsets.only(left: 4, top: 8, bottom: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Video ToolKit', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.primaryLight, letterSpacing: -0.5)),
        const SizedBox(height: 4), Text('设置与关于', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary(context))),
      ])),
      const SizedBox(height: 8),

      // 主题切换卡片
      _buildSectionCard(context, icon: Icons.dark_mode_outlined, title: '外观设置', children: [
        _buildThemeSwitch(context),
      ]),
      const SizedBox(height: 16),

      _buildSectionCard(context, icon: Icons.info_outline_rounded, title: '关于应用', children: [
        _buildInfoRow(context, '应用名称', 'Video ToolKit'),
        _buildInfoRow(context, '版本号', '1.0.0'),
        _buildInfoRow(context, '开发者', 'xinyoushanhai888@gmail.com'),
        const SizedBox(height: 12), _buildOpenSourceNotice(context),
      ]),
      const SizedBox(height: 16),

      _buildNavigateCard(context, icon: Icons.privacy_tip_outlined, title: '隐私政策', subtitle: '查看隐私保护条款',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()))),
      const SizedBox(height: 12),

      _buildNavigateCard(context, icon: Icons.extension_outlined, title: '第三方SDK列表', subtitle: '查看第三方服务',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SdkListPage()))),
      const SizedBox(height: 40),
    ])));
  }

  Widget _buildThemeSwitch(BuildContext context) {
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
              onTap: () { if (isDark) appTheme.toggle(); },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.transparent : AppTheme.accentColor(context),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.light_mode_outlined, size: 18, color: isDark ? AppTheme.textSecondary(context) : Colors.white),
                    const SizedBox(width: 6),
                    Text('浅色模式', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isDark ? AppTheme.textSecondary(context) : Colors.white)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () { if (!isDark) appTheme.toggle(); },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.accentColor(context) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dark_mode_outlined, size: 18, color: isDark ? Colors.white : AppTheme.textSecondary(context)),
                    const SizedBox(width: 6),
                    Text('深色模式', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isDark ? Colors.white : AppTheme.textSecondary(context))),
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
    decoration: BoxDecoration(color: AppTheme.cardBg(ctx), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.borderColor(ctx), width: 0.5)),
    child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.accentColor(ctx).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppTheme.primaryLight, size: 20)),
        const SizedBox(width: 12), Text(title, style: TextStyle(color: AppTheme.textPrimary(ctx), fontSize: 17, fontWeight: FontWeight.w600)),
      ]),
      const SizedBox(height: 16), ...children,
    ])));

  Widget _buildInfoRow(BuildContext ctx, String label, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(width: 80, child: Text(label, style: TextStyle(color: AppTheme.textSecondary(ctx), fontSize: 14))),
    Expanded(child: Text(value, style: TextStyle(color: AppTheme.textPrimary(ctx), fontSize: 14, fontWeight: FontWeight.w500))),
  ]));

  Widget _buildOpenSourceNotice(BuildContext ctx) => Container(
    padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.accentColor(ctx).withValues(alpha: 0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.accentColor(ctx).withValues(alpha: 0.08))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.code, color: AppTheme.primaryLight, size: 18),
      const SizedBox(width: 8),
      Expanded(child: Text('基于 FFmpeg、Flutter 等开源技术构建，感谢开源社区贡献。', style: TextStyle(color: AppTheme.textSecondary(ctx), fontSize: 12, height: 1.5))),
    ]));

  Widget _buildNavigateCard(BuildContext ctx, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) => Material(
    color: AppTheme.cardBg(ctx), borderRadius: BorderRadius.circular(16),
    child: InkWell(borderRadius: BorderRadius.circular(16), onTap: onTap, child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.borderColor(ctx), width: 0.5)), child: Row(children: [
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.accentColor(ctx).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: AppTheme.primaryLight, size: 22)),
      const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: AppTheme.textPrimary(ctx), fontSize: 16, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 3), Text(subtitle, style: TextStyle(color: AppTheme.textSecondary(ctx), fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
      ])),
      Icon(Icons.chevron_right, color: AppTheme.textSecondary(ctx).withValues(alpha: 0.5)),
    ]))));
}
