/// 第三方SDK列表页面
///
/// 展示应用使用的所有第三方SDK及其用途说明
library;

import 'package:flutter/material.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';

class SdkListPage extends StatelessWidget {
  const SdkListPage({super.key});

  static const _bg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1E3A5F), Color(0xFF3D5A80), Color(0xFFE0E7FF)],
    stops: [0.0, 0.4, 1.0],
  );

  // 每个SDK卡片的渐变色
  static const _cardGradients = [
    [Color(0xFF4ECDC4), Color(0xFF36B3A8)],
    [Color(0xFFFF9A56), Color(0xFFFF6B35)],
    [Color(0xFF9B7ED9), Color(0xFF7B5FCC)],
    [Color(0xFF5B9FFF), Color(0xFF3D7EFF)],
    [Color(0xFF56C59A), Color(0xFF3DB87A)],
    [Color(0xFFFF7EB3), Color(0xFFFF5C8A)],
    [Color(0xFF45B7D1), Color(0xFF2980B9)],
    [Color(0xFF667EEA), Color(0xFF5A67D8)],
    [Color(0xFFF093FB), Color(0xFFF5576C)],
    [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    [Color(0xFF43E97B), Color(0xFF38F9D7)],
    [Color(0xFFFA709A), Color(0xFFFEE140)],
    [Color(0xFFA18CD1), Color(0xFFDBC7A8)],
  ];

  List<_SdkInfo> _getSdks(AppLocalizations l10n) => [
    _SdkInfo(name: 'Flutter', version: '3.x', description: l10n.sdkFlutterDesc, license: 'BSD 3-Clause'),
    _SdkInfo(name: 'FFmpeg', version: '4.1', description: l10n.sdkFfmpegDesc, license: 'LGPL 2.1'),
    _SdkInfo(name: 'video_player', version: '2.9.3', description: l10n.sdkVideoPlayerDesc, license: 'BSD 3-Clause'),
    _SdkInfo(name: 'file_picker', version: '8.1.6', description: l10n.sdkFilePickerDesc, license: 'MIT'),
    _SdkInfo(name: 'image_gallery_saver_plus', version: '3.0.5', description: l10n.sdkGallerySaverDesc, license: 'MIT'),
    _SdkInfo(name: 'permission_handler', version: '11.3.1', description: l10n.sdkPermissionDesc, license: 'MIT'),
    _SdkInfo(name: 'path_provider', version: '2.1.2', description: l10n.sdkPathProviderDesc, license: 'BSD 3-Clause'),
    _SdkInfo(name: 'provider', version: '6.1.2', description: l10n.sdkProviderDesc, license: 'MIT'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sdks = _getSdks(l10n);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _bg),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(l10n, context),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: sdks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => _buildSdkCard(sdks[index], _cardGradients[index % _cardGradients.length], l10n),
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
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(ctx)),
          Expanded(child: Text(l10n.sdkList, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSdkCard(_SdkInfo sdk, List<Color> gradient, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: gradient),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: gradient[0].withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(sdk.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                child: Text('v${sdk.version}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(sdk.description, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13, height: 1.4)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.gavel, size: 14, color: Colors.white.withValues(alpha: 0.7)),
              const SizedBox(width: 4),
              Text(l10n.licenseLabel(sdk.license), style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SdkInfo {
  final String name;
  final String version;
  final String description;
  final String license;

  const _SdkInfo({required this.name, required this.version, required this.description, required this.license});
}
