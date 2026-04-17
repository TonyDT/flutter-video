/// 音频工具入口页（容器页）
///
/// 约定：
/// - 所有"音频类"功能入口（按钮/卡片）集中放在这里；
/// - 具体功能逻辑后续建议放在 `providers/`（例如 `AudioProvider`）里，通过 Provider 调用，
///   这里仅负责展示与交互触发。
library;

import 'package:flutter/material.dart';

/// 音频工具入口页面
///
/// 展示所有可用的音频处理功能入口卡片
///
/// 当前状态：示例页面，后续将添加实际的音频处理功能
///
/// 使用 [ListView] 实现简单列表布局
class AudioToolsPage extends StatelessWidget {
  const AudioToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 页面标题
        Text(
          '音频工具',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        const Text('后续你的音频相关功能入口（按钮/卡片）放在这里。'),
        const SizedBox(height: 16),
        // 示例功能入口卡片
        Card(
          child: ListTile(
            leading: const Icon(Icons.add),
            title: const Text('示例：添加一个音频功能入口'),
            subtitle: const Text('等你实现 FFmpeg 功能后，把入口放这里'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('这里将跳转/触发某个音频功能')),
              );
            },
          ),
        ),
      ],
    );
  }
}

