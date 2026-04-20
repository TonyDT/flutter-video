/// 视频工具入口页（容器页）
///
/// 约定：
/// - 所有"视频类"功能入口（按钮/卡片）集中放在这里；
/// - 具体功能逻辑后续建议放在 `providers/`（例如 `VideoProvider`）里，通过 Provider 调用，
///   这里仅负责展示与交互触发。
library;

import 'package:flutter/material.dart';
import '../utils/top_notify.dart';
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

/// 视频工具入口页面
///
/// 展示所有可用的视频处理功能入口卡片，包括：
/// - 大卡片区域：合并视频、视频截取
/// - 小卡片区域：压缩、比例调整、消音、配音、提取图片、分割、分离、裁剪、格式转换
///
/// 使用 [CustomScrollView] + [SliverGrid] 实现可滚动网格布局
class VideoToolsPage extends StatelessWidget {
  const VideoToolsPage({super.key});

  /// 渐变背景 - 顶部深蓝到底部浅蓝
  static const LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E3A5F), // 深蓝色
      Color(0xFF3D5A80), // 中蓝色
      Color(0xFF98C1D9), // 浅蓝色
    ],
    stops: [0.0, 0.4, 1.0],
  );

  /// 卡片渐变色 - 大卡片用柔和渐变
  static const LinearGradient _largeCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF), // 纯白
      Color(0xFFF0F4F8), // 带蓝调的白色
    ],
  );

  /// 小卡片颜色列表 - 每个功能一个主题色
  static const List<List<Color>> _smallCardGradients = [
    // 视频压缩 - 橙色系
    [Color(0xFFFF9A56), Color(0xFFFF6B35)],
    // 视频比例 - 绿色系
    [Color(0xFF56C59A), Color(0xFF3DB87A)],
    // 视频消音 - 紫色系
    [Color(0xFF9B7ED9), Color(0xFF7B5FCC)],
    // 视频配音 - 粉色系
    [Color(0xFFFF7EB3), Color(0xFFFF5C8A)],
    // 提取图片 - 青色系
    [Color(0xFF4ECDC4), Color(0xFF36B3A8)],
    // 视频分割 - 蓝色系
    [Color(0xFF5B9FFF), Color(0xFF3D7EFF)],
    // 音视频分离 - 青色深色系
    [Color(0xFF45B7D1), Color(0xFF2980B9)],
    // 视频裁剪 - 红色系
    [Color(0xFFFF6B6B), Color(0xFFEE5A5A)],
    // 格式转换 - 靛蓝系
    [Color(0xFF667EEA), Color(0xFF5A67D8)],
  ];

  /// 大卡片图标颜色
  static const List<Color> _largeCardIconColors = [
    Color(0xFF4CAF50), // 绿色 - 合并
    Color(0xFFFF9800), // 橙色 - 截取
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: _backgroundGradient),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 顶部间距
          const SliverPadding(padding: EdgeInsets.only(top: kToolbarHeight)),

          // 前两个大的卡片（一排两个）- 更大的卡片
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildListDelegate([
                _buildLargeCard(
                  context,
                  Icons.merge_type,
                  '合并视频',
                  '将多个视频文件合并成一个',
                  _largeCardIconColors[0],
                  'merge',
                ),
                _buildLargeCard(
                  context,
                  Icons.content_cut,
                  '视频截取',
                  '从视频中截取指定时间段',
                  _largeCardIconColors[1],
                  'cut',
                ),
              ]),
            ),
          ),

          // 间隔区域
          const SliverPadding(padding: EdgeInsets.only(top: 16)),

          // 小标题
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '更多工具',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // 后面的小卡片（自适应列数）
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.crossAxisExtent >= 480 ? 4 : constraints.crossAxisExtent >= 360 ? 3 : 2;
                return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: crossAxisCount <= 2 ? 1.0 : 0.9,
              ),
              delegate: SliverChildListDelegate([
                _buildSmallCard(
                  context,
                  Icons.compress,
                  '视频压缩',
                  '减小视频大小',
                  _smallCardGradients[0],
                  'compress',
                ),
                _buildSmallCard(
                  context,
                  Icons.aspect_ratio,
                  '视频比例',
                  '调整宽高比',
                  _smallCardGradients[1],
                  'ratio',
                ),
                _buildSmallCard(
                  context,
                  Icons.volume_off,
                  '视频消音',
                  '去除音频',
                  _smallCardGradients[2],
                  'mute',
                ),
                _buildSmallCard(
                  context,
                  Icons.record_voice_over,
                  '视频配音',
                  '添加音频',
                  _smallCardGradients[3],
                  'dubbing',
                ),
                _buildSmallCard(
                  context,
                  Icons.image,
                  '提取图片',
                  '提取帧图片',
                  _smallCardGradients[4],
                  'extract',
                ),
                _buildSmallCard(
                  context,
                  Icons.call_split,
                  '视频分割',
                  '分割片段',
                  _smallCardGradients[5],
                  'split',
                ),
                _buildSmallCard(
                  context,
                  Icons.layers_clear,
                  '音视频分离',
                  '分离轨道',
                  _smallCardGradients[6],
                  'separate',
                ),
                _buildSmallCard(
                  context,
                  Icons.crop,
                  '视频裁剪',
                  '裁剪画面',
                  _smallCardGradients[7],
                  'crop',
                ),
                _buildSmallCard(
                  context,
                  Icons.autorenew,
                  '格式转换',
                  '转换格式',
                  _smallCardGradients[8],
                  'convert',
                ),
              ]),
                );
              },
            ),
          ),

          // 底部填充
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }

  /// 构建大尺寸功能卡片
  Widget _buildLargeCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color iconColor,
    String toolId,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: _largeCardGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.3),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _onToolTap(context, toolId, title),
          child: _buildCardContent(icon, title, description, iconColor, true),
        ),
      ),
    );
  }

  /// 工具点击事件
  void _onToolTap(BuildContext context, String toolId, String title) {
    switch (toolId) {
      case 'merge':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MergeVideoPage()));
        break;
      case 'cut':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CutVideoPage()));
        break;
      case 'compress':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CompressVideoPage()));
        break;
      case 'ratio':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RatioVideoPage()));
        break;
      case 'mute':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MuteVideoPage()));
        break;
      case 'dubbing':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DubbingVideoPage()));
        break;
      case 'extract':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ExtractImagePage()));
        break;
      case 'split':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SplitVideoPage()));
        break;
      case 'separate':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SeparateAVPage()));
        break;
      case 'crop':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CropVideoPage()));
        break;
      case 'convert':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConvertFormatPage()));
        break;
      default:
        TopNotify.info(context, '开始执行 $title 功能');
    }
  }

  /// 构建卡片内容
  Widget _buildCardContent(
    IconData icon,
    String title,
    String description,
    Color iconColor,
    bool isLarge,
  ) {
    final iconSize = isLarge ? 36.0 : 28.0;
    final padding = isLarge ? 18.0 : 10.0;
    final titleSize = isLarge ? 17.0 : 14.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLarge)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: iconSize, color: iconColor),
            )
          else
            Icon(icon, size: iconSize, color: Colors.white),
          SizedBox(height: isLarge ? 14 : 8),
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: isLarge ? FontWeight.bold : FontWeight.w600,
                fontSize: titleSize,
                color: isLarge ? const Color(0xFF2D3748) : Colors.white,
                letterSpacing: isLarge ? 0.3 : 0.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: isLarge ? 6 : 2),
          Flexible(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isLarge ? Colors.grey[600] : Colors.white.withValues(alpha: 0.85),
                fontSize: isLarge ? 12 : 11,
                height: isLarge ? 1.3 : 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建小尺寸功能卡片
  Widget _buildSmallCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    List<Color> gradientColors,
    String toolId,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientColors[0],
            gradientColors[1],
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _onToolTap(context, toolId, title),
          child: Center(
            child: _buildCardContent(icon, title, description, gradientColors[0], false),
          ),
        ),
      ),
    );
  }
}
