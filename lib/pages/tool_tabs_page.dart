/// 工具首页（底部Tab导航）
///
/// 使用底部导航栏切换视频工具和音频工具两个模块
///
/// 功能：
/// - 视频工具：合并、截取、压缩等视频处理功能
/// - 音频工具：音频处理相关功能（开发中）
library;

import 'package:flutter/material.dart';

import 'audio_tools_page.dart';
import 'settings_page.dart';
import 'video_tools_page.dart';

/// 应用主页面，包含底部导航栏
///
/// 使用 [BottomNavigationBar] 实现视频/音频工具的 Tab 切换
class ToolTabsPage extends StatefulWidget {
  const ToolTabsPage({super.key});

  @override
  State<ToolTabsPage> createState() => _ToolTabsPageState();
}

class _ToolTabsPageState extends State<ToolTabsPage> {
  /// 当前选中的 Tab 索引
  /// 0: 视频工具
  /// 1: 音频工具
  /// 2: 设置
  int _selectedIndex = 0;

  /// 页面列表
  ///
  /// 每个元素对应一个 Tab 页面的内容
  /// 使用 const 声明确保列表不可变，提升性能
  static const List<Widget> _pages = [
    // 视频相关工具入口容器
    VideoToolsPage(),
    // 音频相关工具入口容器
    AudioToolsPage(),
    // 设置页面
    SettingsPage(),
  ];

  /// Tab 被选中时的回调
  ///
  /// [index] 被选中的 Tab 索引
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 根据选中索引显示对应页面
      body: Center(
        child: _pages[_selectedIndex],
      ),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            activeIcon: Icon(Icons.video_library, color: Colors.orange),
            label: '视频',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack),
            activeIcon: Icon(Icons.audiotrack, color: Colors.orange),
            label: '音频',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings, color: Colors.orange),
            label: '设置',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
