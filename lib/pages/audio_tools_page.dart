// audio_tools_page.dart
// 音频工具入口页

import 'package:flutter/material.dart';
import '../utils/top_notify.dart';

class AudioToolsPage extends StatelessWidget {
  const AudioToolsPage({super.key});

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF1E3A5F), Color(0xFF3D5A80), Color(0xFF98C1D9)],
    stops: [0.0, 0.4, 1.0],
  );

  static const _tools = [
    (Icons.volume_up, '音频提取', '从视频中提取音频', [Color(0xFF4ECDC4), Color(0xFF36B3A8)]),
    (Icons.graphic_eq, '音频转换', '转换音频格式', [Color(0xFFFF9A56), Color(0xFFFF6B35)]),
    (Icons.speed, '音频变速', '调整音频播放速度', [Color(0xFF9B7ED9), Color(0xFF7B5FCC)]),
    (Icons.volume_down, '音频调节', '调整音量大小', [Color(0xFF5B9FFF), Color(0xFF3D7EFF)]),
    (Icons.merge_type, '音频合并', '合并多个音频文件', [Color(0xFF56C59A), Color(0xFF3DB87A)]),
    (Icons.content_cut, '音频截取', '截取音频片段', [Color(0xFFFF7EB3), Color(0xFFFF5C8A)]),
  ];

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(gradient: _bg),
    child: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverPadding(padding: EdgeInsets.only(top: kToolbarHeight)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text('音频工具', style: TextStyle(color: Colors.white.withValues(alpha:0.9), fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.crossAxisExtent >= 480 ? 4 : constraints.crossAxisExtent >= 360 ? 3 : 2;
              return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: crossAxisCount <= 2 ? 1.0 : 0.9),
            delegate: SliverChildListDelegate(_tools.map((t) => _buildCard(context, t.$1, t.$2, t.$3, t.$4)).toList()),
              );
            },
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
      ],
    ),
  );

  Widget _buildCard(BuildContext context, IconData icon, String title, String desc, List<Color> colors) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: colors[0].withValues(alpha:0.4), blurRadius: 12, offset: const Offset(0, 4))],
    ),
    child: Material(color: Colors.transparent, child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => TopNotify.info(context, '$title 功能开发中...'),
      child: Padding(padding: const EdgeInsets.all(10), child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Colors.white),
          const SizedBox(height: 8),
          Flexible(child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis)),
          const SizedBox(height: 2),
          Flexible(child: Text(desc, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withValues(alpha:0.85), fontSize: 11, height: 1.2), maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      )),
    )),
  );
}
