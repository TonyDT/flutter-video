/// 视频工具入口页
library;

import 'package:flutter/material.dart';
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

  static const List<_Tool> _tools = [
    _Tool(Icons.merge_type, '合并视频', '将多个视频文件合并成一个', 'merge'),
    _Tool(Icons.content_cut, '视频截取', '从视频中截取指定时间段', 'cut'),
    _Tool(Icons.compress, '视频压缩', '减小视频文件大小', 'compress'),
    _Tool(Icons.aspect_ratio, '视频比例', '调整画面宽高比', 'ratio'),
    _Tool(Icons.volume_off, '视频消音', '去除视频中音频轨道', 'mute'),
    _Tool(Icons.record_voice_over, '视频配音', '为视频添加背景音乐', 'dubbing'),
    _Tool(Icons.image, '提取图片', '从视频中提取帧图片', 'extract'),
    _Tool(Icons.call_split, '视频分割', '将视频分割成多段', 'split'),
    _Tool(Icons.layers_clear, '音视频分离', '分离音视频轨道', 'separate'),
    _Tool(Icons.crop, '视频裁剪', '裁剪视频画面区域', 'crop'),
    _Tool(Icons.autorenew, '格式转换', '转换视频文件格式', 'convert'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(color: AppTheme.bg(context), child: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
      SliverToBoxAdapter(child: _buildHeader(context)),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), child: Row(children: [
        Icon(Icons.inventory_2_outlined, size: 18, color: AppTheme.textSecondary(context)),
        const SizedBox(width: 6),
        Text('${_tools.length} 款 · 全部', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary(context))),
      ]))),
      SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 16), sliver: SliverLayoutBuilder(builder: (sliverCtx, constraints) {
        final count = constraints.crossAxisExtent >= 480 ? 4 : constraints.crossAxisExtent >= 360 ? 3 : 2;
        return SliverGrid(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: count <= 2 ? 1.0 : 0.82),
          delegate: SliverChildListDelegate(_tools.map((t) => _buildCard(context, t)).toList()));
      })),
      const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
    ]));
  }

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
    if (routes.containsKey(id)) Navigator.push(ctx, MaterialPageRoute(builder: (_) => routes[id]!())); else TopNotify.info(ctx, '$name 功能开发中');
  }
}

class _Tool { final IconData icon; final String title; final String description; final String id; const _Tool(this.icon, this.title, this.description, this.id); }
