# xixi_media_tool

基于 Flutter 开发的多平台媒体工具应用，集成 FFmpeg 实现本地视频/音频处理，无需上传文件即可在设备端完成所有操作。

## 功能概览

### 视频工具（已实现）

| 功能 | 说明 | 页面文件 |
|------|------|----------|
| 合并视频 | 将多个视频文件按顺序合并为一个视频 | `lib/pages/merge_video_page.dart` |
| 视频截取 | 通过时间轴滑块截取视频片段，支持精确到秒 | `lib/pages/cut_video_page.dart` |
| 视频压缩 | 降低视频码率/分辨率以减小文件大小 | `lib/pages/compress_video_page.dart` |
| 视频比例 | 调整视频宽高比（16:9、9:16、1:1 等） | `lib/pages/ratio_video_page.dart` |
| 视频消音 | 去除视频中的音频轨道 | `lib/pages/mute_video_page.dart` |
| 视频配音 | 为视频添加外部音频文件 | `lib/pages/dubbing_video_page.dart` |
| 提取图片 | 按时间范围和帧率从视频中提取图片，可保存到相册 | `lib/pages/extract_image_page.dart` |
| 视频分割 | 按时间点将视频分割为多个片段，全部保存到相册 | `lib/pages/split_video_page.dart` |
| 音视频分离 | 将视频的画面和音频分离，同时输出 M4A 和 MP3 格式，支持音频播放预览 | `lib/pages/separate_av_page.dart` |
| 视频裁剪 | 在视频画面上手势框选裁剪区域，支持四角/四边拖拽、三分法网格 | `lib/pages/crop_video_page.dart` |
| 格式转换 | 将视频转换为 MP4/MOV/AVI/MKV 等格式 | `lib/pages/convert_format_page.dart` |

### 音频工具（开发中）

| 功能 | 说明 |
|------|------|
| 音频提取 | 从视频中提取音频 |
| 音频转换 | 转换音频格式 |
| 音频变速 | 调整音频播放速度 |
| 音频调节 | 调整音量大小 |
| 音频合并 | 合并多个音频文件 |
| 音频截取 | 截取音频片段 |

### 其他页面

| 页面 | 说明 | 文件 |
|------|------|------|
| 首页 Tab 容器 | 视频/音频双 Tab 切换 | `lib/pages/tool_tabs_page.dart` |
| SDK 信息 | 查看 FFmpeg SDK 信息 | `lib/pages/sdk_list_page.dart` |
| 设置 | 应用设置 | `lib/pages/settings_page.dart` |
| 隐私政策 | 隐私政策说明 | `lib/pages/privacy_policy_page.dart` |

## 项目结构

```
lib/
├── main.dart                          # 应用入口
├── pages/
│   ├── tool_tabs_page.dart            # 首页 Tab 容器
│   ├── video_tools_page.dart          # 视频工具入口
│   ├── audio_tools_page.dart          # 音频工具入口
│   ├── merge_video_page.dart          # 合并视频
│   ├── cut_video_page.dart            # 视频截取
│   ├── compress_video_page.dart       # 视频压缩
│   ├── ratio_video_page.dart          # 视频比例
│   ├── mute_video_page.dart           # 视频消音
│   ├── dubbing_video_page.dart        # 视频配音
│   ├── extract_image_page.dart        # 提取图片
│   ├── split_video_page.dart          # 视频分割
│   ├── separate_av_page.dart          # 音视频分离
│   ├── crop_video_page.dart           # 视频裁剪
│   ├── convert_format_page.dart       # 格式转换
│   ├── sdk_list_page.dart             # SDK 信息
│   ├── settings_page.dart             # 设置
│   └── privacy_policy_page.dart       # 隐私政策
├── utils/
│   ├── top_notify.dart                # 顶部通知（替代 SnackBar）
│   ├── native_file_helper.dart        # 原生文件操作
│   ├── temp_dir_helper.dart           # 临时目录管理
│   ├── permission_helper.dart         # 权限请求封装
│   ├── gallery_saver_helper.dart      # 相册保存封装
│   └── video_player_web_helper.dart   # Web 视频播放辅助
└── platform/
    ├── os.dart                        # 平台检测（条件导出）
    ├── os_io.dart                     # 原生平台检测
    └── os_stub.dart                   # Web 平台桩
```

## 技术特性

- **本地处理**：所有视频/音频处理均通过 FFmpeg 在设备本地完成，无需上传到服务器
- **顶部通知**：使用 Overlay 实现顶部通知提示，避免底部 SnackBar 遮挡操作按钮
- **视频预览**：选择视频后自动播放预览，带进度条和播放控制
- **手势裁剪**：视频裁剪支持在画面上直接框选，四角/四边拖拽，三分法网格辅助
- **FFmpeg 容错**：关键操作均有 fallback 策略（copy 模式失败自动降级为转码模式）
- **条件导入**：Web/原生平台通过条件导入隔离 `dart:io`，确保 Web 构建正常

## 依赖

| 包名 | 用途 |
|------|------|
| `video_player` | 视频播放预览 |
| `file_picker` | 文件选择 |
| `ffmpeg_kit_flutter_new` | FFmpeg 视频处理 |
| `audioplayers` | 音频播放预览 |
| `image_gallery_saver_plus` | 保存到系统相册 |
| `permission_handler` | 运行时权限管理 |
| `path_provider` | 目录路径获取 |
| `provider` | 状态管理 |

## 支持平台

| 平台 | 状态 | 说明 |
|------|------|------|
| Android | ✅ 已支持 | minSdk=24, Java 17 |
| iOS | ✅ 已支持 | platform :ios, '12.0' |
| Web | ⚠️ 预留 | 保留入口，FFmpeg WASM 未集成 |
| HarmonyOS | ⚠️ 占位 | 显示"鸿蒙版正在开发中" |

## 快速开始

```bash
# 安装依赖
flutter pub get

# Android 运行
flutter run -d android

# iOS 运行（需先安装 Pods）
cd ios && pod install && cd ..
flutter run -d ios

# Web 运行
flutter run -d chrome
```

## Android 配置

- **minSdk**: 24
- **targetSdk**: 跟随 Flutter 默认
- **NDK**: 27.0.12077973
- **Java**: 17
- **Kotlin**: 2.0.21

## iOS 配置

- **平台版本**: 12.0
- 安装 Pods:

```bash
cd ios
LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pod install
```
