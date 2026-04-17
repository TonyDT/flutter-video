// merge_video_page.dart
//
// 视频合并功能页面 - 简化版（仅支持两个视频合并）

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
// 条件导入
import '../utils/native_file_helper.dart'
    if (dart.library.io) '../utils/native_file_helper.dart'
    if (dart.library.html) '../utils/native_file_helper_web.dart';
import '../utils/temp_dir_helper.dart'
    if (dart.library.io) '../utils/temp_dir_helper.dart'
    if (dart.library.html) '../utils/temp_dir_helper_web.dart';
import '../utils/permission_helper.dart'
    if (dart.library.io) '../utils/permission_helper.dart'
    if (dart.library.html) '../utils/permission_helper_web.dart';
import '../utils/gallery_saver_helper.dart'
    if (dart.library.io) '../utils/gallery_saver_helper.dart'
    if (dart.library.html) '../utils/gallery_saver_helper_web.dart';
import '../utils/video_player_web_helper.dart'
    if (dart.library.io) '../utils/video_player_web_helper_stub.dart'
    if (dart.library.html) '../utils/video_player_web_helper.dart';

class MergeVideoPage extends StatefulWidget {
  const MergeVideoPage({super.key});

  @override
  State<MergeVideoPage> createState() => _MergeVideoPageState();
}

class _MergeVideoPageState extends State<MergeVideoPage> {
  // 两个视频的路径和时长（不保存控制器）
  String? _path1;
  Uint8List? _bytes1;
  String? _webUrl1;
  Duration _duration1 = Duration.zero;
  Duration _start1 = Duration.zero;
  Duration _end1 = Duration.zero;

  String? _path2;
  Uint8List? _bytes2;
  String? _webUrl2;
  Duration _duration2 = Duration.zero;
  Duration _start2 = Duration.zero;
  Duration _end2 = Duration.zero;

  // 预览用控制器（按需创建，用完即释放）
  VideoPlayerController? _previewController;
  int _previewTarget = -1; // 0=视频1, 1=视频2, -1=合并结果

  // 状态
  bool _isMerging = false;
  bool _isLoadingVideo = false;
  String? _mergedVideoPath;

  static const LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFFE8EAF6)],
  );

  @override
  void dispose() {
    _previewController?.dispose();
    if (_webUrl1 != null) {
      try { VideoPlayerWebHelper.revokeBlobUrl(_webUrl1!); } catch (_) {}
    }
    if (_webUrl2 != null) {
      try { VideoPlayerWebHelper.revokeBlobUrl(_webUrl2!); } catch (_) {}
    }
    super.dispose();
  }

  Future<void> _pickVideo1() async {
    if (!mounted || _isLoadingVideo) return;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
        withData: kIsWeb, // 只在 Web 上读取字节数据，移动端只获取路径
      );

      if (!mounted || result == null || result.files.isEmpty) return;

      final file = result.files.first;

      // 释放预览控制器
      await _disposePreviewController();

      if (kIsWeb) {
        if (file.bytes != null) {
          _bytes1 = file.bytes;
          if (_webUrl1 != null) {
            try { VideoPlayerWebHelper.revokeBlobUrl(_webUrl1!); } catch (_) {}
          }
          _webUrl1 = VideoPlayerWebHelper.bytesToBlobUrl(file.bytes!);
          await _loadDuration1();
        }
      } else {
        if (file.path != null) {
          _path1 = file.path;
          await _loadDuration1();
        }
      }
    } catch (e) {
      if (mounted) _showError('选择视频失败');
    }
  }

  Future<void> _pickVideo2() async {
    if (!mounted || _isLoadingVideo) return;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
        withData: kIsWeb, // 只在 Web 上读取字节数据，移动端只获取路径
      );

      if (!mounted || result == null || result.files.isEmpty) return;

      final file = result.files.first;

      // 释放预览控制器
      await _disposePreviewController();

      if (kIsWeb) {
        if (file.bytes != null) {
          _bytes2 = file.bytes;
          if (_webUrl2 != null) {
            try { VideoPlayerWebHelper.revokeBlobUrl(_webUrl2!); } catch (_) {}
          }
          _webUrl2 = VideoPlayerWebHelper.bytesToBlobUrl(file.bytes!);
          await _loadDuration2();
        }
      } else {
        if (file.path != null) {
          _path2 = file.path;
          await _loadDuration2();
        }
      }
    } catch (e) {
      if (mounted) _showError('选择视频失败');
    }
  }

  /// 仅加载视频时长，不创建长时间存活的控制器
  Future<void> _loadDuration1() async {
    if (!mounted) return;

    setState(() => _isLoadingVideo = true);

    VideoPlayerController? tempController;

    try {
      if (kIsWeb && _webUrl1 != null) {
        tempController = VideoPlayerController.networkUrl(Uri.parse(_webUrl1!));
      } else if (_path1 != null) {
        final file = NativeFileHelper.getFile(_path1!);
        tempController = VideoPlayerController.file(file);
      } else {
        setState(() => _isLoadingVideo = false);
        return;
      }

      await tempController.initialize();

      if (!mounted) {
        tempController.dispose();
        return;
      }

      _duration1 = tempController.value.duration;
      _start1 = Duration.zero;
      _end1 = _duration1;

      setState(() {});
    } catch (e, stack) {
      debugPrint('Video1 load error: $e\n$stack');
      tempController?.dispose();
      if (mounted) _showError('视频1加载失败');
    } finally {
      tempController?.dispose();
      if (mounted) setState(() => _isLoadingVideo = false);
    }
  }

  Future<void> _loadDuration2() async {
    if (!mounted) return;

    setState(() => _isLoadingVideo = true);

    VideoPlayerController? tempController;

    try {
      if (kIsWeb && _webUrl2 != null) {
        tempController = VideoPlayerController.networkUrl(Uri.parse(_webUrl2!));
      } else if (_path2 != null) {
        final file = NativeFileHelper.getFile(_path2!);
        tempController = VideoPlayerController.file(file);
      } else {
        setState(() => _isLoadingVideo = false);
        return;
      }

      await tempController.initialize();

      if (!mounted) {
        tempController.dispose();
        return;
      }

      _duration2 = tempController.value.duration;
      _start2 = Duration.zero;
      _end2 = _duration2;

      setState(() {});
    } catch (e, stack) {
      debugPrint('Video2 load error: $e\n$stack');
      tempController?.dispose();
      if (mounted) _showError('视频2加载失败');
    } finally {
      tempController?.dispose();
      if (mounted) setState(() => _isLoadingVideo = false);
    }
  }

  Future<void> _disposePreviewController() async {
    if (_previewController != null) {
      try {
        _previewController!.pause();
        _previewController!.dispose();
      } catch (_) {}
      _previewController = null;
      _previewTarget = -1;
    }
  }

  /// 按需预览视频（用完立即释放）
  Future<void> _previewVideo(int index) async {
    if (!mounted) return;
    if (index == 0 && _path1 == null && _bytes1 == null) return;
    if (index == 1 && _path2 == null && _bytes2 == null) return;

    // 如果已经在预览同一个视频，不重复加载
    if (_previewTarget == index && _previewController != null) {
      // 切换播放/暂停
      if (_previewController!.value.isPlaying) {
        await _previewController!.pause();
      } else {
        await _previewController!.play();
      }
      if (mounted) setState(() {});
      return;
    }

    // 释放旧控制器
    await _disposePreviewController();

    VideoPlayerController? controller;

    try {
      if (index == 0) {
        if (kIsWeb && _webUrl1 != null) {
          controller = VideoPlayerController.networkUrl(Uri.parse(_webUrl1!));
        } else if (_path1 != null) {
          final file = NativeFileHelper.getFile(_path1!);
          controller = VideoPlayerController.file(file);
        }
      } else {
        if (kIsWeb && _webUrl2 != null) {
          controller = VideoPlayerController.networkUrl(Uri.parse(_webUrl2!));
        } else if (_path2 != null) {
          final file = NativeFileHelper.getFile(_path2!);
          controller = VideoPlayerController.file(file);
        }
      }

      if (controller == null) return;

      await controller.initialize();

      if (!controller.value.isInitialized) {
        controller.dispose();
        if (mounted) _showError('预览失败');
        return;
      }

      if (!mounted) {
        controller.dispose();
        return;
      }

      // 跳转到开始时间
      final startTime = index == 0 ? _start1 : _start2;
      await controller.seekTo(startTime);
      await controller.play();

      _previewController = controller;
      _previewTarget = index;

      setState(() {});
    } catch (e) {
      controller?.dispose();
      if (mounted) _showError('预览失败');
    }
  }

  Future<void> _mergeVideos() async {
    if (_path1 == null || _path2 == null) {
      _showError('请先选择两个视频');
      return;
    }

    if (kIsWeb) {
      _showError('Web 平台暂不支持合并');
      return;
    }

    await _disposePreviewController();
    setState(() => _isMerging = true);

    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final fileListPath = '${tempDir.path}/filelist.txt';
      final outputPath = '${tempDir.path}/merged_${DateTime.now().millisecondsSinceEpoch}.mp4';

      // 创建文件列表（注意转义单引号）
      final listContent = "file '${_path1!.replaceAll("'", r"'\''")}'\nfile '${_path2!.replaceAll("'", r"'\''")}'";
      await File(fileListPath).writeAsString(listContent);

      // 构建命令（快速合并，若失败可改用转码）
      final args = ['-f', 'concat', '-safe', '0', '-i', fileListPath, '-c', 'copy', outputPath, '-y'];

      // 执行合并
      await FFmpegKit.executeAsync(
        args.join(' '),
        (session) async {
          final returnCode = await session.getReturnCode();
          if (ReturnCode.isSuccess(returnCode)) {
            _mergedVideoPath = outputPath;
            _showSuccess('合并成功！');
            await _initPreview(outputPath);
          } else {
            final failMsg = await session.getFailStackTrace();
            _showError('合并失败：$failMsg');
          }
          setState(() => _isMerging = false);
        },
        (log) {
          debugPrint('FFmpeg log: ${log.getMessage()}');
        },
        (statistics) {
          // 进度回调
        },
      );
    } catch (e) {
      _showError('合并异常: $e');
      setState(() => _isMerging = false);
    }
  }

  Future<void> _initPreview(String path) async {
    try {
      _previewController?.dispose();
      final file = NativeFileHelper.getFile(path);
      _previewController = VideoPlayerController.file(file);
      await _previewController!.initialize();
      await _previewController!.setLooping(true);
      await _previewController!.play();
      _previewTarget = -1;
      if (mounted) setState(() {});
    } catch (e) {
      _showError('预览初始化失败');
    }
  }

  void _toggleMergePreview() {
    if (_previewController != null && _previewController!.value.isInitialized) {
      if (_previewController!.value.isPlaying) {
        _previewController!.pause();
      } else {
        _previewController!.play();
      }
      setState(() {});
    }
  }

  Future<void> _saveToGallery() async {
    if (_mergedVideoPath == null) return;
    if (kIsWeb) return;

    try {
      final status = await PermissionHelper.requestPhotos();
      if (status != true) {
        _showError('需要相册权限');
        return;
      }

      final result = await GallerySaverHelper.saveFile(_mergedVideoPath!);
      if (result == true) {
        _showSuccess('已保存到相册');
      } else {
        _showError('保存失败');
      }
    } catch (e) {
      _showError('保存出错');
    }
  }

  void _reset() {
    _previewController?.dispose();
    _previewController = null;
    _previewTarget = -1;
    setState(() {
      _mergedVideoPath = null;
    });
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.green),
    );
  }

  String _formatDuration(Duration d) {
    return '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: _mergedVideoPath != null ? _buildPreview() : _buildMergeSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
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
              '合并视频',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildMergeSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: const Row(
              children: [
                Icon(Icons.video_library, color: Colors.orange, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '选择两个视频进行合并',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildVideoCard1(),
          const SizedBox(height: 14),
          _buildVideoCard2(),
          const SizedBox(height: 28),
          _buildMergeButton(),
        ],
      ),
    );
  }

  Widget _buildVideoCard1() {
    final hasVideo = _path1 != null || _bytes1 != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: hasVideo ? _buildVideoInfo1() : _buildVideoEmpty1(),
    );
  }

  Widget _buildVideoEmpty1() {
    return InkWell(
      onTap: _isLoadingVideo ? null : _pickVideo1,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: _isLoadingVideo
                  ? SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue.shade400))
                  : Icon(Icons.video_call, size: 28, color: Colors.blue.shade400),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '选择视频 1',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _isLoadingVideo ? '加载中...' : '点击选择第一个视频',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo1() {
    final isPreviewing = _previewController != null && _previewController!.value.isInitialized && _previewTarget == 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 预览区域
        InkWell(
          onTap: () => _previewVideo(0),
          child: Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: Colors.black87,
                child: isPreviewing
                    ? AspectRatio(
                        aspectRatio: _previewController!.value.aspectRatio,
                        child: VideoPlayer(_previewController!),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_circle_outline, size: 48, color: Colors.white54),
                            const SizedBox(height: 8),
                            Text(
                              '点击预览',
                              style: TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
              ),
              if (isPreviewing)
                Positioned.fill(
                  child: Center(
                    child: Icon(
                      _previewController!.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      size: 56,
                      color: Colors.white70,
                    ),
                  ),
                ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
                  child: Text(_formatDuration(_duration1), style: const TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ),
            ],
          ),
        ),
        // 信息区域
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                    child: Text('视频 1', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _pickVideo1,
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('更换'),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildSlider('开始', _start1, _duration1, Colors.green, (v) => setState(() {
                _start1 = Duration(milliseconds: v.toInt());
                if (_start1 >= _end1) _end1 = _start1 + const Duration(seconds: 1);
                if (_end1 > _duration1) _end1 = _duration1;
              })),
              const SizedBox(height: 4),
              _buildSlider('结束', _end1, _duration1, Colors.orange, (v) => setState(() {
                _end1 = Duration(milliseconds: v.toInt());
                if (_end1 <= _start1) _start1 = _end1 - const Duration(seconds: 1);
                if (_start1 < Duration.zero) _start1 = Duration.zero;
              })),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCard2() {
    final hasVideo = _path2 != null || _bytes2 != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: hasVideo ? _buildVideoInfo2() : _buildVideoEmpty2(),
    );
  }

  Widget _buildVideoEmpty2() {
    return InkWell(
      onTap: _isLoadingVideo ? null : _pickVideo2,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
              child: _isLoadingVideo
                  ? SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange.shade400))
                  : Icon(Icons.video_call, size: 28, color: Colors.orange.shade400),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '选择视频 2',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _isLoadingVideo ? '加载中...' : '点击选择第二个视频',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo2() {
    final isPreviewing = _previewController != null && _previewController!.value.isInitialized && _previewTarget == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 预览区域
        InkWell(
          onTap: () => _previewVideo(1),
          child: Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: Colors.black87,
                child: isPreviewing
                    ? AspectRatio(
                        aspectRatio: _previewController!.value.aspectRatio,
                        child: VideoPlayer(_previewController!),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_circle_outline, size: 48, color: Colors.white54),
                            const SizedBox(height: 8),
                            Text(
                              '点击预览',
                              style: TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
              ),
              if (isPreviewing)
                Positioned.fill(
                  child: Center(
                    child: Icon(
                      _previewController!.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      size: 56,
                      color: Colors.white70,
                    ),
                  ),
                ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
                  child: Text(_formatDuration(_duration2), style: const TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ),
            ],
          ),
        ),
        // 信息区域
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
                    child: Text('视频 2', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _pickVideo2,
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('更换'),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildSlider('开始', _start2, _duration2, Colors.green, (v) => setState(() {
                _start2 = Duration(milliseconds: v.toInt());
                if (_start2 >= _end2) _end2 = _start2 + const Duration(seconds: 1);
                if (_end2 > _duration2) _end2 = _duration2;
              })),
              const SizedBox(height: 4),
              _buildSlider('结束', _end2, _duration2, Colors.orange, (v) => setState(() {
                _end2 = Duration(milliseconds: v.toInt());
                if (_end2 <= _start2) _start2 = _end2 - const Duration(seconds: 1);
                if (_start2 < Duration.zero) _start2 = Duration.zero;
              })),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(String label, Duration value, Duration max, Color color, ValueChanged<double> onChanged) {
    final double maxMs = max.inMilliseconds > 0 ? max.inMilliseconds.toDouble() : 1.0;
    final double valueMs = value.inMilliseconds.toDouble().clamp(0.0, maxMs);

    return Column(
      children: [
        Row(
          children: [
            Icon(label == '开始' ? Icons.play_arrow : Icons.stop, size: 16, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            const Spacer(),
            Text(_formatDuration(value), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey.shade800)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(activeTrackColor: color, inactiveTrackColor: color.withValues(alpha: 0.2)),
          child: Slider(
            value: valueMs,
            min: 0,
            max: maxMs,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildMergeButton() {
    final canMerge = _path1 != null && _path2 != null && !_isMerging;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: canMerge ? 0.4 : 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: canMerge ? _mergeVideos : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            elevation: 0,
          ),
          child: _isMerging
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
                    SizedBox(width: 12),
                    Text('合并中...', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.merge_type, size: 22),
                    ),
                    const SizedBox(width: 10),
                    const Text('开始合并', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    final isInitialized = _previewController != null && _previewController!.value.isInitialized;
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: isInitialized
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: _previewController!.value.aspectRatio,
                          child: VideoPlayer(_previewController!),
                        ),
                        IconButton(
                          onPressed: _toggleMergePreview,
                          icon: Icon(
                            _previewController!.value.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            size: 80,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveToGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.download),
                      SizedBox(width: 8),
                      Text('保存到相册'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.refresh),
                      SizedBox(width: 8),
                      Text('重新合并'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

