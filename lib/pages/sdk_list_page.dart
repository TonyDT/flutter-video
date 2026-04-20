/// 第三方SDK列表页面
///
/// 展示应用使用的所有第三方SDK及其用途说明
library;

import 'package:flutter/material.dart';

class SdkListPage extends StatelessWidget {
  const SdkListPage({super.key});

  static const _bg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1E3A5F), Color(0xFF3D5A80), Color(0xFF98C1D9)],
    stops: [0.0, 0.4, 1.0],
  );

  static const _sdks = [
    _SdkInfo(
      name: 'Flutter',
      version: '3.x',
      description: '跨平台应用开发框架，用于构建应用界面与交互逻辑',
      license: 'BSD 3-Clause',
    ),
    _SdkInfo(
      name: 'FFmpeg',
      version: '4.1',
      description: '音视频处理核心库，用于视频裁剪、压缩、格式转换等功能',
      license: 'LGPL 2.1',
    ),
    _SdkInfo(
      name: 'video_player',
      version: '2.9.3',
      description: '视频播放组件，用于视频预览功能',
      license: 'BSD 3-Clause',
    ),
    _SdkInfo(
      name: 'file_picker',
      version: '8.1.6',
      description: '文件选择器，用于选择本地视频和音频文件',
      license: 'MIT',
    ),
    _SdkInfo(
      name: 'image_gallery_saver_plus',
      version: '3.0.5',
      description: '相册保存工具，用于将处理后的文件保存到系统相册',
      license: 'MIT',
    ),
    _SdkInfo(
      name: 'permission_handler',
      version: '11.3.1',
      description: '权限管理组件，用于请求存储、相册等系统权限',
      license: 'MIT',
    ),
    _SdkInfo(
      name: 'path_provider',
      version: '2.1.2',
      description: '路径提供者，用于获取临时目录和文档目录',
      license: 'BSD 3-Clause',
    ),
    _SdkInfo(
      name: 'provider',
      version: '6.1.2',
      description: '状态管理库，用于应用内状态共享与管理',
      license: 'MIT',
    ),
  ];

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _bg),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _sdks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _buildSdkCard(_sdks[index], _cardGradients[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Text(
              '第三方SDK列表',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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

  Widget _buildSdkCard(_SdkInfo sdk, List<Color> gradient) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  sdk.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'v${sdk.version}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            sdk.description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.gavel, size: 14, color: Colors.white.withValues(alpha: 0.7)),
              const SizedBox(width: 4),
              Text(
                '许可证: ${sdk.license}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
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

  const _SdkInfo({
    required this.name,
    required this.version,
    required this.description,
    required this.license,
  });
}
