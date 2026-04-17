/// 视频工具入口页（容器页）
///
/// 约定：
/// - 所有"视频类"功能入口（按钮/卡片）集中放在这里；
/// - 具体功能逻辑后续建议放在 `providers/`（例如 `VideoProvider`）里，通过 Provider 调用，
///   这里仅负责展示与交互触发。
library;

import 'package:flutter/material.dart';

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

          // 后面的小卡片（一排三个）
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
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
    // 根据 toolId 处理不同的功能
    switch (toolId) {
      case 'merge':
        // 合并视频
        _showFeatureDialog(context, title, '正在打开合并视频功能...');
        break;
      case 'cut':
        // 视频截取
        _showFeatureDialog(context, title, '正在打开视频截取功能...');
        break;
      case 'compress':
        // 视频压缩
        _showFeatureDialog(context, title, '正在打开视频压缩功能...');
        break;
      case 'ratio':
        // 视频比例
        _showFeatureDialog(context, title, '正在打开视频比例调整功能...');
        break;
      case 'mute':
        // 视频消音
        _showFeatureDialog(context, title, '正在打开视频消音功能...');
        break;
      case 'dubbing':
        // 视频配音
        _showFeatureDialog(context, title, '正在打开视频配音功能...');
        break;
      case 'extract':
        // 提取图片
        _showFeatureDialog(context, title, '正在打开提取图片功能...');
        break;
      case 'split':
        // 视频分割
        _showFeatureDialog(context, title, '正在打开视频分割功能...');
        break;
      case 'separate':
        // 音视频分离
        _showFeatureDialog(context, title, '正在打开音视频分离功能...');
        break;
      case 'crop':
        // 视频裁剪
        _showFeatureDialog(context, title, '正在打开视频裁剪功能...');
        break;
      case 'convert':
        // 格式转换
        _showFeatureDialog(context, title, '正在打开格式转换功能...');
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('开始执行 $title 功能'),
            backgroundColor: const Color(0xFF3D5A80),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
    }
  }

  /// 显示功能对话框
  void _showFeatureDialog(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF3D5A80),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
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
    final titleSize = isLarge ? 17.0 : 13.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isLarge ? FontWeight.bold : FontWeight.w600,
              fontSize: titleSize,
              color: isLarge ? const Color(0xFF2D3748) : Colors.white,
              letterSpacing: isLarge ? 0.3 : 0.2,
            ),
          ),
          SizedBox(height: isLarge ? 6 : 2),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isLarge ? Colors.grey[600] : Colors.white.withValues(alpha: 0.85),
              fontSize: isLarge ? 12 : 10,
              height: isLarge ? 1.3 : 1.2,
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
