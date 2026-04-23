/// 视频工具入口页
library;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/top_notify.dart';
import '../theme/app_theme.dart';
import 'merge_video_page.dart';
import 'cut_video_page.dart';
import 'compress_video_page.dart';
import 'ratio_video_page.dart';
import 'mute_video_page.dart';
import 'dubbing_video_page.dart';
import 'extract_image_page.dart';
import 'split_video_page.dart';
import 'separate_av_page.dart';
import 'crop_video_page.dart';
import 'convert_format_page.dart';

class VideoToolsPage extends StatelessWidget {
  const VideoToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tools = _buildTools(l10n);

    return Container(color: AppTheme.bg(context), child: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
      SliverToBoxAdapter(child: _buildHeader(context)),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), child: Row(children: [
        Icon(Icons.inventory_2_outlined, size: 18, color: AppTheme.textSecondary(context)),
        const SizedBox(width: 6),
        Text(l10n.toolCountAll(tools.length), style: TextStyle(fontSize: 13, color: AppTheme.textSecondary(context))),
      ]))),
      SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 16), sliver: SliverLayoutBuilder(builder: (sliverCtx, constraints) {
        final count = constraints.crossAxisExtent >= 480 ? 4 : constraints.crossAxisExtent >= 360 ? 3 : 2;
        return SliverGrid(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: count <= 2 ? 1.0 : 0.82),
          delegate: SliverChildListDelegate(tools.map((t) => _buildCard(context, t)).toList()));
      })),
      const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
    ]));
  }

  List<_Tool> _buildTools(AppLocalizations l10n) => [
    _Tool(Icons.merge_type, l10n.toolMerge, l10n.toolMergeDesc, 'merge'),
    _Tool(Icons.content_cut, l10n.toolCut, l10n.toolCutDesc, 'cut'),
    _Tool(Icons.compress, l10n.toolCompress, l10n.toolCompressDesc, 'compress'),
    _Tool(Icons.aspect_ratio, l10n.toolRatio, l10n.toolRatioDesc, 'ratio'),
    _Tool(Icons.volume_off, l10n.toolMute, l10n.toolMuteDesc, 'mute'),
    _Tool(Icons.record_voice_over, l10n.toolDubbing, l10n.toolDubbingDesc, 'dubbing'),
    _Tool(Icons.image, l10n.toolExtract, l10n.toolExtractDesc, 'extract'),
    _Tool(Icons.call_split, l10n.toolSplit, l10n.toolSplitDesc, 'split'),
    _Tool(Icons.layers_clear, l10n.toolSeparate, l10n.toolSeparateDesc, 'separate'),
    _Tool(Icons.crop, l10n.toolCrop, l10n.toolCropDesc, 'crop'),
    _Tool(Icons.autorenew, l10n.toolConvert, l10n.toolConvertDesc, 'convert'),
  ];

  Widget _buildHeader(BuildContext ctx) => Container(
    padding: const EdgeInsets.only(left: 20, right: 20, top: kToolbarHeight + 4, bottom: 16),
    child: Row(children: [
      Text('ToolKit', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primaryLight, letterSpacing: -0.5)),
    ]),
  );

  Widget _buildCard(BuildContext context, _Tool tool) {
    return Container(decoration: BoxDecoration(color: AppTheme.cardBg(context), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.borderColor(context), width: 0.5)), child: Material(color: Colors.transparent, child: InkWell(borderRadius: BorderRadius.circular(16), onTap: () => _navigate(context, tool.id, tool.title), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 48, height: 48, decoration: BoxDecoration(color: AppTheme.iconBg(context), borderRadius: BorderRadius.circular(14)), child: Icon(tool.icon, size: 24, color: AppTheme.primaryLight)),
      const Spacer(flex: 2),
      Text(tool.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textPrimary(context)), maxLines: 1, overflow: TextOverflow.ellipsis),
      const SizedBox(height: 4),
      Text(tool.description, style: TextStyle(fontSize: 12, color: AppTheme.textSecondary(context), height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
    ])))));
  }

  void _navigate(BuildContext ctx, String id, String name) {
    final l10n = AppLocalizations.of(ctx)!;
    final routes = <String, Widget Function()>{
      'merge': () => const MergeVideoPage(),
      'cut': () => const CutVideoPage(),
      'compress': () => const CompressVideoPage(),
      'ratio': () => const RatioVideoPage(),
      'mute': () => const MuteVideoPage(),
      'dubbing': () => const DubbingVideoPage(),
      'extract': () => const ExtractImagePage(),
      'split': () => const SplitVideoPage(),
      'separate': () => const SeparateAVPage(),
      'crop': () => const CropVideoPage(),
      'convert': () => const ConvertFormatPage(),
    };
    if (routes.containsKey(id)) Navigator.push(ctx, MaterialPageRoute(builder: (_) => routes[id]!())); else TopNotify.info(ctx, l10n.featureDeveloping(name));
  }
}

class _Tool { final IconData icon; final String title; final String description; final String id; const _Tool(this.icon, this.title, this.description, this.id); }
