# xixi_media_tool

一个多平台媒体工具（Flutter）工程骨架，用于后续接入本地/端侧媒体处理能力（计划使用 FFmpeg 系列方案）。

## 功能入口结构（音频 / 视频 Tab）

当前首页已按“视频 / 音频”拆分为两个 Tab，方便后续按领域扩展工具列表：

- **首页 Tab 容器**：`lib/pages/tool_tabs_page.dart`
- **视频工具入口页**：`lib/pages/video_tools_page.dart`
- **音频工具入口页**：`lib/pages/audio_tools_page.dart`
- **App 入口配置**：`lib/main.dart`（非鸿蒙平台时 `home` 指向 `ToolTabsPage`）

后续新增功能时：

- 视频类入口（按钮/卡片）优先加在 `VideoToolsPage`
- 音频类入口（按钮/卡片）优先加在 `AudioToolsPage`
- 具体处理逻辑建议放到 `lib/providers/`（用 `ChangeNotifier` 管理进度/状态），页面只负责触发与展示

## 支持平台

- **Android**：已配置 `minSdk=24`
- **iOS**：已配置 `platform :ios, '12.0'`
- **Web**：保留 Web 入口与 WASM 接入说明（暂不实际集成 `ffmpeg.wasm`）
- **HarmonyOS（鸿蒙）**：当前为占位提示页（“鸿蒙版正在开发中”），原生能力后续手动接入

说明：本仓库已移除 **Windows** / **macOS** 平台目录。

## 依赖

当前已加入（`pubspec.yaml`）：

- `provider`
- `path_provider`

## 快速开始

在项目根目录执行：

```bash
flutter pub get
flutter run
```

## 平台配置要点（已落实到代码）

### Android

文件：`android/app/build.gradle`

- **minSdkVersion**：已改为 `24`

### iOS

文件：`ios/Podfile`

- **平台版本**：已确保为 `platform :ios, '12.0'`

安装 Pods（建议 UTF-8 终端）：

```bash
cd ios
LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pod install
```

### HarmonyOS（鸿蒙）

当前策略：由于 `ffmpeg_kit_flutter` 尚未官方支持鸿蒙，Flutter 层先做占位提示，避免用户误以为功能可用。

- **占位入口**：`lib/main.dart`（检测到 `ohos/harmonyos` 时展示“鸿蒙版正在开发中”）
- **平台检测封装**：`lib/platform/os.dart`（使用条件导出，确保 Web 构建不直接引入 `dart:io`）

### Web（WASM 预留）

- **说明注释**：`web/index.html` 中已添加 `ffmpeg.wasm` 的预留说明（仅注释，不做实际集成）

后续如需接入 FFmpeg WASM，通常做法是将 `ffmpeg.wasm` 与对应 JS glue/worker 放到 `web/` 静态资源或通过 `assets` 暴露，然后在 Web 侧用 JS/interop 加载。

## 已知问题（与你当前 Flutter SDK 相关）

你当前使用的 Flutter SDK 为 OHOS fork（`Flutter 3.27.5-ohos-1.0.4`）。在该 SDK 下我本机验证时出现：

- **`flutter build web --wasm`**：触发 SDK/引擎侧报错（`cpuinfo_macos.cc: unreachable code`）
- **`pod install`**：在 post_install 阶段提示 iOS 引擎产物缺失（需要 `Flutter.xcframework`）。尝试 `flutter precache --ios` 同样会触发上述 SDK 侧报错

因此：**README 中提供了命令与配置，但 iOS pods / Web WASM 的“实际跑通”需要你后续在可用的 SDK/环境下完成验证。**

## 常用命令

```bash
# Android 运行
flutter run -d android

# iOS 运行（需先 pod install）
flutter run -d ios

# Web（非 WASM）
flutter run -d chrome
```
# flutter-video
