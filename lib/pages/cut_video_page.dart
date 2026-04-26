// cut_video_page.dart
// 视频截取 - 从视频中截取指定时间段

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';
import '../utils/native_file_helper.dart'
    if (dart.library.io) '../utils/native_file_helper.dart'
    if (dart.library.html) '../utils/native_file_helper_web.dart';
import '../utils/top_notify.dart';
import '../utils/temp_dir_helper.dart'
    if (dart.library.io) '../utils/temp_dir_helper.dart'
    if (dart.library.html) '../utils/temp_dir_helper_web.dart';
import '../utils/save_to_gallery.dart';

class CutVideoPage extends StatefulWidget {
  const CutVideoPage({super.key});
  @override
  State<CutVideoPage> createState() => _CutVideoPageState();
}

class _CutVideoPageState extends State<CutVideoPage> {
  String? _videoPath;
  Duration _duration = Duration.zero;
  Duration _start = Duration.zero;
  Duration _end = Duration.zero;
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;
  bool _controllerError = false;
  String? _resultPath;

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF0D3B2E), Color(0xFF1B6B4F), Color(0xFFE8F5E9)],
  );

  @override
  void dispose() { _controller?.dispose(); super.dispose(); }

  Future<void> _pickVideo() async {
    if (!mounted || _isLoading) return;
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: false, withData: kIsWeb);
      if (!mounted || result == null || result.files.isEmpty) return;
      final file = result.files.first;
      if (file.path == null) return;

      _controller?.dispose(); _controller = null;
      setState(() { _isLoading = true; _resultPath = null; _videoPath = file.path; _controllerError = false; });

      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }

      setState(() {
        _controller = ctrl;
        _duration = ctrl.value.duration;
        _start = Duration.zero;
        _end = _duration;
        _isLoading = false;
        _controllerError = ctrl.value.hasError;
      });
      if (!ctrl.value.hasError) { await ctrl.play(); }
    } catch (e) {
      if (mounted) _showError(l10n.selectVideoFailedWithError(e.toString()));
      setState(() => _isLoading = false);
    }
  }

  Future<void> _cutVideo() async {
    if (_videoPath == null || kIsWeb) return;
    final l10n = AppLocalizations.of(context)!;
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final output = '${tempDir.path}/cut_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final startSec = (_start.inMilliseconds / 1000.0).toStringAsFixed(3);
      final durationSec = ((_end - _start).inMilliseconds / 1000.0).toStringAsFixed(3);

      final cmd = '-ss $startSec -i "$_videoPath" -t $durationSec -c copy "$output" -y';
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      if (ReturnCode.isSuccess(rc)) {
        _resultPath = output;
        _showSuccess(l10n.cutSuccess);
        if (mounted) {
          final oldCtrl = _controller;
          final newCtrl = VideoPlayerController.file(NativeFileHelper.getFile(output));
          try {
            await newCtrl.initialize();
            if (mounted) {
              setState(() { _controller = newCtrl; _controllerError = newCtrl.value.hasError; });
              if (!newCtrl.value.hasError) newCtrl.play();
            } else { newCtrl.dispose(); }
          } catch (e) {
            if (mounted) { setState(() { _controllerError = true; }); }
            newCtrl.dispose();
          }
          oldCtrl?.dispose();
        }
      } else {
        final cmd2 = '-ss $startSec -i "$_videoPath" -t $durationSec -c:v libx264 -c:a aac -pix_fmt yuv420p "$output" -y';
        final s2 = await FFmpegKit.execute(cmd2);
        final rc2 = await s2.getReturnCode();
        if (ReturnCode.isSuccess(rc2)) {
          _resultPath = output;
          _showSuccess(l10n.cutSuccess);
          if (mounted) {
            final oldCtrl = _controller;
            final newCtrl = VideoPlayerController.file(NativeFileHelper.getFile(output));
            try {
              await newCtrl.initialize();
              if (mounted) {
                setState(() { _controller = newCtrl; _controllerError = newCtrl.value.hasError; });
                if (!newCtrl.value.hasError) newCtrl.play();
              } else { newCtrl.dispose(); }
            } catch (e) {
              if (mounted) setState(() { _controllerError = true; });
              newCtrl.dispose();
            }
            oldCtrl?.dispose();
          }
        } else { _showError(l10n.cutFailed); }
      }
    } catch (e) { _showError(l10n.cutError(e.toString())); }
    if (mounted) setState(() => _isProcessing = false);
  }

  Future<void> _saveToGallery() async {
    if (_resultPath == null) return;
    await SaveToGallery.save(_resultPath!, context);
  }

  void _showError(String m) { if (mounted) TopNotify.error(context, m); }
  void _showSuccess(String m) { if (mounted) TopNotify.success(context, m); }
  String _fmt(Duration d) => '${d.inMinutes.toString().padLeft(2,'0')}:${(d.inSeconds%60).toString().padLeft(2,'0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
        _buildAppBar(l10n),
        Expanded(child: _videoPath == null ? _buildPickArea(l10n) : _buildWorkArea(l10n)),
      ])),
    ));
  }

  Widget _buildAppBar(AppLocalizations l10n) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Row(children: [
      IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      Expanded(child: Text(l10n.cutVideo, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis)),
      const SizedBox(width: 48),
    ]),
  );

  Widget _buildPickArea(AppLocalizations l10n) => Center(child: InkWell(
    onTap: _isLoading ? null : _pickVideo,
    child: Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.video_call, size: 64, color: Colors.white70),
        const SizedBox(height: 16),
        Text(_isLoading ? l10n.loading : l10n.tapToSelectVideo, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ]),
    ),
  ));

  Widget _buildVideoPreview(AppLocalizations l10n) {
    if (_controller == null || !_controller!.value.isInitialized || _controllerError) {
      return Container(
        height: 220, decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.videocam_off, size: 48, color: Colors.white54),
          const SizedBox(height: 8),
          Text(_resultPath != null ? l10n.cutCompletePreviewUnavailable : l10n.videoPreviewUnavailable, style: const TextStyle(color: Colors.white54, fontSize: 14)),
        ])),
      );
    }
    return Container(
      height: 220, decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(borderRadius: BorderRadius.circular(16), child: AspectRatio(aspectRatio: _controller!.value.aspectRatio > 0 ? _controller!.value.aspectRatio : 16 / 9, child: VideoPlayer(_controller!))),
    );
  }

  Widget _buildWorkArea(AppLocalizations l10n) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(children: [
      _buildVideoPreview(l10n),
      const SizedBox(height: 16),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Row(children: [const Icon(Icons.timer, color: Colors.blue), const SizedBox(width: 8), Expanded(child: Text(l10n.totalDuration(_fmt(_duration)), style: const TextStyle(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis))]),
          const SizedBox(height: 12),
          _buildSlider(l10n.start, _start, Colors.green, (v) {
            setState(() {
              _start = Duration(milliseconds: v.toInt());
              if (_start >= _end) { _end = _start + const Duration(seconds: 1); }
              if (_end > _duration) { _end = _duration; if (_start >= _end && _end > Duration.zero) { _start = _end - const Duration(seconds: 1); } }
            });
          }),
          const SizedBox(height: 4),
          _buildSlider(l10n.end, _end, Colors.orange, (v) {
            setState(() {
              _end = Duration(milliseconds: v.toInt());
              if (_end <= _start) { _start = _end - const Duration(seconds: 1); }
              if (_start < Duration.zero) { _start = Duration.zero; if (_end <= _start) { _end = _start + const Duration(seconds: 1); } }
            });
          }),
          const SizedBox(height: 8),
          Text(l10n.cutRange(_fmt(_start), _fmt(_end), _fmt(_end - _start)), style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
        ]),
      ),
      const SizedBox(height: 20),
      if (_resultPath == null) SizedBox(width: double.infinity, height: 52, child: ElevatedButton(
        onPressed: _isProcessing ? null : _cutVideo,
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)), elevation: 0),
        child: _isProcessing ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width:24,height:24,child: CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)), SizedBox(width:12), Text(l10n.cutting,style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))])
            : Text(l10n.startCut, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      )) else Row(children: [
        Expanded(child: ElevatedButton(onPressed: _saveToGallery, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.download), SizedBox(width:8), Flexible(child: Text(l10n.saveToAlbum, overflow: TextOverflow.ellipsis))]))),
        const SizedBox(width: 12),
        Expanded(child: ElevatedButton(onPressed: () { _controller?.dispose(); setState(() { _resultPath = null; _controller = null; _controllerError = false; }); _pickVideo(); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF43A047), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.refresh), SizedBox(width:8), Flexible(child: Text(l10n.reselect, overflow: TextOverflow.ellipsis))]))),
      ]),
      const SizedBox(height: 12),
      TextButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.swap_horiz, color: Colors.white70), label: Text(l10n.changeVideo, style: const TextStyle(color: Colors.white70))),
    ]),
  );

  Widget _buildSlider(String label, Duration value, Color color, ValueChanged<double> onChanged) {
    final maxMs = _duration.inMilliseconds > 0 ? _duration.inMilliseconds.toDouble() : 1.0;
    final valMs = value.inMilliseconds.toDouble().clamp(0.0, maxMs);
    return Column(children: [
      Row(children: [Icon(label == AppLocalizations.of(context)!.start ? Icons.play_arrow : Icons.stop, size: 16, color: color), const SizedBox(width:4), Text(label, style: TextStyle(fontSize:13,color:Colors.grey.shade600)), const Spacer(), Text(_fmt(value), style: TextStyle(fontSize:13,fontWeight:FontWeight.w600,color:Colors.grey.shade800), overflow: TextOverflow.ellipsis)]),
      SliderTheme(data: SliderThemeData(activeTrackColor: color, inactiveTrackColor: color.withValues(alpha:0.2)), child: Slider(value: valMs, min:0, max:maxMs, onChanged: onChanged)),
    ]);
  }
}
