// merge_video_page.dart
//
// 视频合并功能页面 - 全面适配版
// 支持：RTL语言、响应式布局、不同屏幕尺寸

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';
import '../utils/top_notify.dart';
// 条件导入
import '../utils/native_file_helper.dart'
    if (dart.library.io) '../utils/native_file_helper.dart'
    if (dart.library.html) '../utils/native_file_helper_web.dart';
import '../utils/temp_dir_helper.dart'
    if (dart.library.io) '../utils/temp_dir_helper.dart'
    if (dart.library.html) '../utils/temp_dir_helper_web.dart';
import '../utils/save_to_gallery.dart';
import '../utils/video_player_web_helper.dart'
    if (dart.library.io) '../utils/video_player_web_helper_stub.dart'
    if (dart.library.html) '../utils/video_player_web_helper.dart';

class MergeVideoPage extends StatefulWidget {
  const MergeVideoPage({super.key});

  @override
  State<MergeVideoPage> createState() => _MergeVideoPageState();
}

class _MergeVideoPageState extends State<MergeVideoPage> {
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

  VideoPlayerController? _previewController;
  int _previewTarget = -1;

  bool _isMerging = false;
  bool _isLoadingVideo = false;
  String? _mergedVideoPath;

  static const LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF312E81), Color(0xFF4C1D95), Color(0xFFEDE9FE)],
  );

  @override
  void dispose() {
    _previewController?.dispose();
    if (_webUrl1 != null) { try { VideoPlayerWebHelper.revokeBlobUrl(_webUrl1!); } catch (_) {} }
    if (_webUrl2 != null) { try { VideoPlayerWebHelper.revokeBlobUrl(_webUrl2!); } catch (_) {} }
    super.dispose();
  }

  bool get _isRtl => Directionality.of(context) == TextDirection.rtl;

  Future<void> _pickVideo1() async {
    if (!mounted || _isLoadingVideo) return;
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: false, withData: kIsWeb);
      if (!mounted || result == null || result.files.isEmpty) return;
      final file = result.files.first;
      await _disposePreviewController();
      if (kIsWeb) {
        if (file.bytes != null) {
          _bytes1 = file.bytes;
          if (_webUrl1 != null) { try { VideoPlayerWebHelper.revokeBlobUrl(_webUrl1!); } catch (_) {} }
          _webUrl1 = VideoPlayerWebHelper.bytesToBlobUrl(file.bytes!);
          await _loadDuration1();
        }
      } else {
        if (file.path != null) { _path1 = file.path; await _loadDuration1(); }
      }
    } catch (e) {
      if (mounted) _showError(AppLocalizations.of(context)!.selectVideoFailed);
    }
  }

  Future<void> _pickVideo2() async {
    if (!mounted || _isLoadingVideo) return;
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: false, withData: kIsWeb);
      if (!mounted || result == null || result.files.isEmpty) return;
      final file = result.files.first;
      await _disposePreviewController();
      if (kIsWeb) {
        if (file.bytes != null) {
          _bytes2 = file.bytes;
          if (_webUrl2 != null) { try { VideoPlayerWebHelper.revokeBlobUrl(_webUrl2!); } catch (_) {} }
          _webUrl2 = VideoPlayerWebHelper.bytesToBlobUrl(file.bytes!);
          await _loadDuration2();
        }
      } else {
        if (file.path != null) { _path2 = file.path; await _loadDuration2(); }
      }
    } catch (e) {
      if (mounted) _showError(AppLocalizations.of(context)!.selectVideoFailed);
    }
  }

  Future<void> _loadDuration1() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoadingVideo = true);
    VideoPlayerController? tempController;
    try {
      if (kIsWeb && _webUrl1 != null) {
        tempController = VideoPlayerController.networkUrl(Uri.parse(_webUrl1!));
      } else if (_path1 != null) {
        final file = NativeFileHelper.getFile(_path1!);
        tempController = VideoPlayerController.file(file);
      } else { setState(() => _isLoadingVideo = false); return; }
      await tempController.initialize();
      if (!mounted) { tempController.dispose(); return; }
      _duration1 = tempController.value.duration;
      _start1 = Duration.zero;
      _end1 = _duration1;
      setState(() {});
    } catch (e, stack) {
      debugPrint('Video1 load error: $e\n$stack');
      tempController?.dispose();
      if (mounted) _showError(l10n.video1LoadFailed);
    } finally {
      tempController?.dispose();
      if (mounted) setState(() => _isLoadingVideo = false);
    }
  }

  Future<void> _loadDuration2() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoadingVideo = true);
    VideoPlayerController? tempController;
    try {
      if (kIsWeb && _webUrl2 != null) {
        tempController = VideoPlayerController.networkUrl(Uri.parse(_webUrl2!));
      } else if (_path2 != null) {
        final file = NativeFileHelper.getFile(_path2!);
        tempController = VideoPlayerController.file(file);
      } else { setState(() => _isLoadingVideo = false); return; }
      await tempController.initialize();
      if (!mounted) { tempController.dispose(); return; }
      _duration2 = tempController.value.duration;
      _start2 = Duration.zero;
      _end2 = _duration2;
      setState(() {});
    } catch (e, stack) {
      debugPrint('Video2 load error: $e\n$stack');
      tempController?.dispose();
      if (mounted) _showError(l10n.video2LoadFailed);
    } finally {
      tempController?.dispose();
      if (mounted) setState(() => _isLoadingVideo = false);
    }
  }

  Future<void> _disposePreviewController() async {
    if (_previewController != null) {
      try { _previewController!.pause(); _previewController!.dispose(); } catch (_) {}
      _previewController = null;
      _previewTarget = -1;
    }
  }

  Future<void> _previewVideo(int index) async {
    if (!mounted) return;
    if (index == 0 && _path1 == null && _bytes1 == null) return;
    if (index == 1 && _path2 == null && _bytes2 == null) return;
    final l10n = AppLocalizations.of(context)!;
    if (_previewTarget == index && _previewController != null) {
      if (_previewController!.value.isPlaying) { await _previewController!.pause(); }
      else { await _previewController!.play(); }
      if (mounted) setState(() {});
      return;
    }
    await _disposePreviewController();
    VideoPlayerController? controller;
    try {
      if (index == 0) {
        if (kIsWeb && _webUrl1 != null) { controller = VideoPlayerController.networkUrl(Uri.parse(_webUrl1!)); }
        else if (_path1 != null) { final file = NativeFileHelper.getFile(_path1!); controller = VideoPlayerController.file(file); }
      } else {
        if (kIsWeb && _webUrl2 != null) { controller = VideoPlayerController.networkUrl(Uri.parse(_webUrl2!)); }
        else if (_path2 != null) { final file = NativeFileHelper.getFile(_path2!); controller = VideoPlayerController.file(file); }
      }
      if (controller == null) return;
      await controller.initialize();
      if (!controller.value.isInitialized) { controller.dispose(); if (mounted) _showError(l10n.previewFailed); return; }
      if (!mounted) { controller.dispose(); return; }
      final startTime = index == 0 ? _start1 : _start2;
      await controller.seekTo(startTime);
      await controller.play();
      _previewController = controller;
      _previewTarget = index;
      setState(() {});
    } catch (e) {
      controller?.dispose();
      if (mounted) _showError(l10n.previewFailed);
    }
  }

  Future<void> _mergeVideos() async {
    final l10n = AppLocalizations.of(context)!;
    if (_path1 == null || _path2 == null) { _showError(l10n.pleaseSelectTwoVideos); return; }
    if (kIsWeb) { _showError(l10n.webNotSupportMerge); return; }

    await _disposePreviewController();
    setState(() => _isMerging = true);

    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final ts = DateTime.now().millisecondsSinceEpoch;
      final clip1Path = '${tempDir.path}/clip1_$ts.mp4';
      final clip2Path = '${tempDir.path}/clip2_$ts.mp4';
      final outputPath = '${tempDir.path}/merged_$ts.mp4';

      final ss1 = (_start1.inMilliseconds / 1000.0).toStringAsFixed(3);
      final to1 = (_end1.inMilliseconds / 1000.0).toStringAsFixed(3);
      final clip1Args = ['-i', _path1!, '-ss', ss1, '-to', to1, '-c:v', 'libx264', '-preset', 'fast', '-c:a', 'aac', '-ar', '44100', '-ac', '2', '-vf', 'scale=trunc(iw/2)*2:trunc(ih/2)*2', '-r', '30', '-pix_fmt', 'yuv420p', clip1Path, '-y'];
      debugPrint('FFmpeg clip1: ${clip1Args.join(' ')}');
      final session1 = await FFmpegKit.execute(clip1Args.join(' '));
      final rc1 = await session1.getReturnCode();
      if (!ReturnCode.isSuccess(rc1)) {
        if (mounted) _showError(l10n.video1CropFailed);
        setState(() => _isMerging = false);
        return;
      }

      String? resolution;
      final probeArgs = '-v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$clip1Path"';
      final probeSession = await FFmpegKit.execute(probeArgs);
      final probeOutput = await probeSession.getOutput();
      if (probeOutput != null) {
        final lines = probeOutput.split('\n').where((l) => l.contains('x')).toList();
        if (lines.isNotEmpty) { resolution = lines.first.trim(); debugPrint('Detected clip1 resolution: $resolution'); }
      }

      final ss2 = (_start2.inMilliseconds / 1000.0).toStringAsFixed(3);
      final to2 = (_end2.inMilliseconds / 1000.0).toStringAsFixed(3);
      final scaleFilter = resolution != null && resolution.contains('x')
          ? 'scale=trunc(${resolution.split('x')[0]}/2)*2:trunc(${resolution.split('x')[1]}/2)*2'
          : 'scale=trunc(iw/2)*2:trunc(ih/2)*2';
      final clip2Args = ['-i', _path2!, '-ss', ss2, '-to', to2, '-c:v', 'libx264', '-preset', 'fast', '-c:a', 'aac', '-ar', '44100', '-ac', '2', '-vf', scaleFilter, '-r', '30', '-pix_fmt', 'yuv420p', clip2Path, '-y'];
      debugPrint('FFmpeg clip2: ${clip2Args.join(' ')}');
      final session2 = await FFmpegKit.execute(clip2Args.join(' '));
      final rc2 = await session2.getReturnCode();
      if (!ReturnCode.isSuccess(rc2)) {
        if (mounted) _showError(l10n.video2CropFailed);
        setState(() => _isMerging = false);
        return;
      }

      final fileListPath = '${tempDir.path}/filelist_$ts.txt';
      final listContent = "file '$clip1Path'\nfile '$clip2Path'";
      await File(fileListPath).writeAsString(listContent);
      final mergeArgs = ['-f', 'concat', '-safe', '0', '-i', fileListPath, '-c', 'copy', '-movflags', '+faststart', outputPath, '-y'];
      debugPrint('FFmpeg merge: ${mergeArgs.join(' ')}');
      final session3 = await FFmpegKit.execute(mergeArgs.join(' '));
      final rc3 = await session3.getReturnCode();

      if (!mounted) { setState(() => _isMerging = false); return; }

      if (ReturnCode.isSuccess(rc3)) {
        _mergedVideoPath = outputPath;
        _showSuccess(l10n.mergeSuccess);
        await _initPreview(outputPath);
      } else { _showError(l10n.mergeFailed); }

      try { await File(clip1Path).delete(); await File(clip2Path).delete(); await File(fileListPath).delete(); } catch (_) {}
      setState(() => _isMerging = false);
    } catch (e) {
      debugPrint('Merge error: $e');
      if (mounted) _showError(l10n.mergeError(e.toString()));
      setState(() => _isMerging = false);
    }
  }

  Future<void> _initPreview(String path) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      _previewController?.dispose();
      final file = NativeFileHelper.getFile(path);
      final ctrl = VideoPlayerController.file(file);
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }
      _previewController = ctrl;
      await ctrl.setLooping(true);
      await ctrl.play();
      _previewTarget = -1;
      if (mounted) setState(() {});
    } catch (e) { _showError(l10n.previewInitFailed); }
  }

  void _toggleMergePreview() {
    if (_previewController != null && _previewController!.value.isInitialized) {
      if (_previewController!.value.isPlaying) { _previewController!.pause(); }
      else { _previewController!.play(); }
      setState(() {});
    }
  }

  Future<void> _saveToGallery() async {
    if (_mergedVideoPath == null || kIsWeb) return;
    await SaveToGallery.save(_mergedVideoPath!, context);
  }

  void _reset() {
    _previewController?.dispose();
    _previewController = null;
    _previewTarget = -1;
    setState(() { _mergedVideoPath = null; });
  }

  void _showError(String msg) { if (!mounted) return; TopNotify.error(context, msg); }
  void _showSuccess(String msg) { if (!mounted) return; TopNotify.success(context, msg); }

  String _formatDuration(Duration d) {
    return '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(l10n),
              Expanded(child: _mergedVideoPath != null ? _buildPreview(l10n, isWideScreen) : _buildMergeSection(l10n, isWideScreen)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(AppLocalizations l10n) {
    final rtl = _isRtl;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
          Flexible(child: FittedBox(fit: BoxFit.scaleDown, child: Text(l10n.mergeVideo, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), maxLines: 1))),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildMergeSection(AppLocalizations l10n, bool isWideScreen) {
    if (isWideScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(12), child: _buildVideoCard1(l10n))),
          const SizedBox(width: 8),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(12), child: _buildVideoCard2(l10n))),
        ],
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeaderCard(l10n),
          const SizedBox(height: 16),
          _buildVideoCard1(l10n),
          const SizedBox(height: 12),
          _buildVideoCard2(l10n),
          const SizedBox(height: 20),
          _buildMergeButton(l10n),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          const Icon(Icons.video_library, color: Color(0xFF2E7D32), size: 22),
          const SizedBox(width: 10),
          Expanded(child: Text(l10n.selectTwoVideosToMerge, style: const TextStyle(color: Colors.white, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _buildVideoCard1(AppLocalizations l10n) {
    final hasVideo = _path1 != null || _bytes1 != null;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: hasVideo ? _buildVideoInfo1(l10n) : _buildVideoEmpty1(l10n),
    );
  }

  Widget _buildVideoEmpty1(AppLocalizations l10n) {
    return InkWell(
      onTap: _isLoadingVideo ? null : _pickVideo1,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF2E7D32).withValues(alpha: 0.1), shape: BoxShape.circle),
              child: _isLoadingVideo
                  ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: const Color(0xFF2E7D32)))
                  : Icon(Icons.video_call, size: 24, color: const Color(0xFF2E7D32)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(l10n.selectVideo1, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(_isLoadingVideo ? l10n.loading : l10n.tapToSelectFirstVideo, style: TextStyle(color: Colors.grey.shade400, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
              ]),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo1(AppLocalizations l10n) {
    final isPreviewing = _previewController != null && _previewController!.value.isInitialized && _previewTarget == 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _previewVideo(0),
          child: Stack(
            children: [
              Container(
                height: 140, width: double.infinity, color: Colors.black87,
                child: isPreviewing
                    ? AspectRatio(aspectRatio: _previewController!.value.aspectRatio, child: VideoPlayer(_previewController!))
                    : Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.play_circle_outline, size: 44, color: Colors.white54),
                        const SizedBox(height: 6),
                        Text(l10n.tapToPreview, style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ])),
              ),
              if (isPreviewing)
                Positioned.fill(child: Center(child: Icon(_previewController!.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 50, color: Colors.white70))),
              Positioned(
                bottom: 6, right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
                  child: Text(_formatDuration(_duration1), style: const TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFF2E7D32).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: Text(l10n.video1, style: const TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.w600, fontSize: 12)),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _pickVideo1,
                    icon: const Icon(Icons.refresh, size: 14),
                    label: Text(l10n.change, style: const TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600, padding: const EdgeInsets.symmetric(horizontal: 8)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              _buildSlider(l10n.start, _start1, _duration1, Colors.green, (v) => setState(() {
                _start1 = Duration(milliseconds: v.toInt());
                if (_start1 >= _end1) _end1 = _start1 + const Duration(seconds: 1);
                if (_end1 > _duration1) _end1 = _duration1;
              })),
              const SizedBox(height: 2),
              _buildSlider(l10n.end, _end1, _duration1, Colors.orange, (v) => setState(() {
                _end1 = Duration(milliseconds: v.toInt());
                if (_end2 <= _start1) _start1 = _end1 - const Duration(seconds: 1);
                if (_start1 < Duration.zero) _start1 = Duration.zero;
              })),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCard2(AppLocalizations l10n) {
    final hasVideo = _path2 != null || _bytes2 != null;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: hasVideo ? _buildVideoInfo2(l10n) : _buildVideoEmpty2(l10n),
    );
  }

  Widget _buildVideoEmpty2(AppLocalizations l10n) {
    return InkWell(
      onTap: _isLoadingVideo ? null : _pickVideo2,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF43A047).withValues(alpha: 0.1), shape: BoxShape.circle),
              child: _isLoadingVideo
                  ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: const Color(0xFF43A047)))
                  : Icon(Icons.video_call, size: 24, color: const Color(0xFF43A047)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(l10n.selectVideo2, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(_isLoadingVideo ? l10n.loading : l10n.tapToSelectSecondVideo, style: TextStyle(color: Colors.grey.shade400, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
              ]),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo2(AppLocalizations l10n) {
    final isPreviewing = _previewController != null && _previewController!.value.isInitialized && _previewTarget == 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _previewVideo(1),
          child: Stack(
            children: [
              Container(
                height: 140, width: double.infinity, color: Colors.black87,
                child: isPreviewing
                    ? AspectRatio(aspectRatio: _previewController!.value.aspectRatio, child: VideoPlayer(_previewController!))
                    : Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.play_circle_outline, size: 44, color: Colors.white54),
                        const SizedBox(height: 6),
                        Text(l10n.tapToPreview, style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ])),
              ),
              if (isPreviewing)
                Positioned.fill(child: Center(child: Icon(_previewController!.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 50, color: Colors.white70))),
              Positioned(
                bottom: 6, right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
                  child: Text(_formatDuration(_duration2), style: const TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFF43A047).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: Text(l10n.video2, style: const TextStyle(color: Color(0xFF43A047), fontWeight: FontWeight.w600, fontSize: 12)),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _pickVideo2,
                    icon: const Icon(Icons.refresh, size: 14),
                    label: Text(l10n.change, style: const TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600, padding: const EdgeInsets.symmetric(horizontal: 8)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              _buildSlider(l10n.start, _start2, _duration2, Colors.green, (v) => setState(() {
                _start2 = Duration(milliseconds: v.toInt());
                if (_start2 >= _end2) _end2 = _start2 + const Duration(seconds: 1);
                if (_end2 > _duration2) _end2 = _duration2;
              })),
              const SizedBox(height: 2),
              _buildSlider(l10n.end, _end2, _duration2, Colors.orange, (v) => setState(() {
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Icon(label == l10n.start ? Icons.play_arrow : Icons.stop, size: 14, color: color),
            const SizedBox(width: 4),
            Expanded(child: Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade600), overflow: TextOverflow.ellipsis)),
            Text(_formatDuration(value), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey.shade800), overflow: TextOverflow.ellipsis),
          ],
        ),
        SliderTheme(data: SliderThemeData(activeTrackColor: color, inactiveTrackColor: color.withValues(alpha: 0.2)), child: Slider(value: valueMs, min: 0, max: maxMs, onChanged: onChanged)),
      ],
    );
  }

  Widget _buildMergeButton(AppLocalizations l10n) {
    final canMerge = _path1 != null && _path2 != null && !_isMerging;
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: const Color(0xFF2E7D32).withValues(alpha: canMerge ? 0.4 : 0.2), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: ElevatedButton(
        onPressed: canMerge ? _mergeVideos : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E7D32),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          elevation: 0,
        ),
        child: _isMerging
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
                const SizedBox(width: 10),
                Flexible(child: Text(l10n.merging, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
              ])
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle), child: const Icon(Icons.merge_type, size: 20)),
                const SizedBox(width: 8),
                Flexible(child: Text(l10n.startMerge, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
              ]),
      ),
    );
  }

  Widget _buildPreview(AppLocalizations l10n, bool isWideScreen) {
    final isInitialized = _previewController != null && _previewController!.value.isInitialized;
    final btnPadding = isWideScreen ? 14.0 : 12.0;

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(isWideScreen ? 16 : 12),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: isInitialized
                  ? Stack(alignment: Alignment.center, children: <Widget>[
                      AspectRatio(aspectRatio: _previewController!.value.aspectRatio, child: VideoPlayer(_previewController!)),
                      IconButton(
                        onPressed: _toggleMergePreview,
                        icon: Icon(_previewController!.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 70, color: Colors.white70),
                      ),
                    ])
                  : const Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(isWideScreen ? 16 : 12, 0, isWideScreen ? 16 : 12, isWideScreen ? 16 : 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveToGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: btnPadding),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Icon(Icons.download, size: 20), const SizedBox(width: 6), Flexible(child: Text(l10n.saveToAlbum, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis))]),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: btnPadding),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Icon(Icons.refresh, size: 20), const SizedBox(width: 6), Flexible(child: Text(l10n.reMerge, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis))]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
