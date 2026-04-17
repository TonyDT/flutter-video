/// 希希音视频工具 - Flutter 媒体处理应用
///
/// 本应用是一个跨平台的音视频处理工具集，支持以下功能模块：
/// - 视频工具：合并、截取、压缩、格式转换等
/// - 音频工具：音频处理相关功能（开发中）
///
/// 应用架构：
/// - 使用 Provider 进行状态管理
/// - 底部 Tab 导航切换不同工具模块
/// - 平台特定代码通过条件导入区分
library;

import 'package:flutter/material.dart';

import 'platform/os.dart';
import 'pages/tool_tabs_page.dart';

/// 应用入口函数
///
/// 在此初始化全局配置，如主题、语言等
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final os = currentOperatingSystem().toLowerCase();
    final isHarmony = os == 'ohos' || os == 'harmonyos';

    return MaterialApp(
      title: '希希音视频工具',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isHarmony
          ? const HarmonyDevelopingPage()
          : const ToolTabsPage(),
    );
  }
}

/// 鸿蒙系统开发中提示页面
///
/// 当检测到运行在鸿蒙系统时，显示此页面提示用户功能正在开发中
class HarmonyDevelopingPage extends StatelessWidget {
  const HarmonyDevelopingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 建设中的图标
                const Icon(Icons.construction, size: 48),
                const SizedBox(height: 16),
                // 提示文本
                const Text(
                  '鸿蒙版正在开发中',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
