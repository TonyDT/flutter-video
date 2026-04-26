// extract_image_page.dart
// 提取图片 - 从视频中提取帧图片

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';
import '../utils/top_notify.dart';
import '../utils/native_file_helper.dart'
    if (dart.library.io) '../utils/native_file_helper.dart'
    if (dart.library.html) '../utils/native_file_helper_web.dart';
import '../utils/temp_dir_helper.dart'
    if (dart.library.io) '../utils/temp_dir_helper.dart'
    if (dart.library.html) '../utils/temp_dir_helper_web.dart';
import '../utils/save_to_gallery.dart';

class ExtractImagePage extends StatefulWidget {
  const ExtractImagePage({super.key});
  @override
  State<ExtractImagePage> createState() => _ExtractImagePageState();
}

class _ExtractImagePageState extends State<ExtractImagePage> {
  String? _videoPath;
  Duration _duration = Duration.zero;
  Duration _startTime = Duration.zero;
  Duration _endTime = Duration.zero;
  double _fps = 1.0;
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;
  List<String> _extractedImages = [];

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF1B5E20), Color(0xFF388E3C), Color(0xFFE8F5E9)],
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
      setState(() { _isLoading = true; _extractedImages = []; _videoPath = file.path; });
      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }
      setState(() {
        _controller = ctrl;
        _duration = ctrl.value.duration;
        _startTime = Duration.zero;
        _endTime = ctrl.value.duration;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) _showError(l10n.selectVideoFailed);
      setState(() => _isLoading = false);
    }
  }

  Future<void> _extract() async {
    if (_videoPath == null || kIsWeb) return;
    final l10n = AppLocalizations.of(context)!;
    if (_startTime >= _endTime) { _showError(l10n.startTimeMustBeBeforeEnd); return; }
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final outputDir = '${tempDir.path}/frames_${DateTime.now().millisecondsSinceEpoch}';
      await Directory(outputDir).create();
      final startSec = (_startTime.inMilliseconds / 1000.0).toStringAsFixed(3);
      final durationSec = ((_endTime - _startTime).inMilliseconds / 1000.0).toStringAsFixed(3);
      final cmd = '-ss $startSec -i "$_videoPath" -t $durationSec -vf fps=$_fps "$outputDir/frame_%04d.jpg" -y';
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      final dir = Directory(outputDir);
      if (ReturnCode.isSuccess(rc)) {
        final files = await dir.list().map((e) => e.path).where((p) => p.endsWith('.jpg')).toList();
        files.sort();
        if (files.isEmpty) {
          final fallbackCmd = '-ss $startSec -i "$_videoPath" -t $durationSec -r 1 "$outputDir/frame_%04d.jpg" -y';
          final fallbackSession = await FFmpegKit.execute(fallbackCmd);
          final fallbackRc = await fallbackSession.getReturnCode();
          if (ReturnCode.isSuccess(fallbackRc)) {
            final fallbackFiles = await dir.list().map((e) => e.path).where((p) => p.endsWith('.jpg') || p.endsWith('.png')).toList();
            fallbackFiles.sort();
            if (fallbackFiles.isNotEmpty && mounted) {
              setState(() { _extractedImages = fallbackFiles; });
              _showSuccess(l10n.extractedCount(fallbackFiles.length));
            } else { _showError(l10n.noImagesExtracted); }
          } else { _showError(l10n.extractFailed); }
        } else {
          if (mounted) {
            setState(() { _extractedImages = files; });
            _showSuccess(l10n.extractedCount(files.length));
          }
        }
      } else {
        final fallbackCmd = '-i "$_videoPath" -ss $startSec -t $durationSec -r 1 "$outputDir/frame_%04d.jpg" -y';
        final fallbackSession = await FFmpegKit.execute(fallbackCmd);
        final fallbackRc = await fallbackSession.getReturnCode();
        if (ReturnCode.isSuccess(fallbackRc)) {
          final fallbackFiles = await dir.list().map((e) => e.path).where((p) => p.endsWith('.jpg') || p.endsWith('.png')).toList();
          fallbackFiles.sort();
          if (fallbackFiles.isNotEmpty && mounted) {
            setState(() { _extractedImages = fallbackFiles; });
            _showSuccess(l10n.extractedCount(fallbackFiles.length));
          } else { _showError(l10n.noImagesExtractedShort); }
        } else { _showError(l10n.extractFailed); }
      }
    } catch (e) { _showError(l10n.extractError(e.toString())); }
    if (mounted) setState(() => _isProcessing = false);
  }

  Future<void> _saveAllToGallery() async {
    if (_extractedImages.isEmpty) return;
    final l10n = AppLocalizations.of(context)!;
    await SaveToGallery.saveAll(_extractedImages, context, unit: l10n.segmentCount);
  }

  void _showError(String m) { if (mounted) TopNotify.error(context, m); }
  void _showSuccess(String m) { if (mounted) TopNotify.success(context, m); }
  String _fmt(Duration d) => '${d.inMinutes.toString().padLeft(2,'0')}:${(d.inSeconds%60).toString().padLeft(2,'0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
    body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
      _buildAppBar(l10n), Expanded(child: _videoPath == null ? _buildPickArea(l10n) : _buildWorkArea(l10n)),
    ]))));
  }

  Widget _buildAppBar(AppLocalizations l10n) => Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:8), child: Row(children: [
    IconButton(icon: const Icon(Icons.arrow_back,color:Colors.white), onPressed: () => Navigator.pop(context)),
    Expanded(child: Text(l10n.extractImages, style: const TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea(AppLocalizations l10n) => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.image, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?l10n.loading:l10n.tapToSelectVideo, style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea(AppLocalizations l10n) => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    Container(height:180, decoration: BoxDecoration(color:Colors.black87, borderRadius:BorderRadius.circular(16)),
      child: _controller!=null&&_controller!.value.isInitialized ? ClipRRect(borderRadius:BorderRadius.circular(16), child: AspectRatio(aspectRatio:_controller!.value.aspectRatio, child: VideoPlayer(_controller!))) : const Center(child: CircularProgressIndicator(color:Colors.white))),
    const SizedBox(height:16),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Row(children: [const Icon(Icons.timer,color:Colors.teal), const SizedBox(width:8), Expanded(child: Text(l10n.videoDuration(_fmt(_duration)), style: const TextStyle(fontWeight:FontWeight.w600), overflow: TextOverflow.ellipsis))]),
      const SizedBox(height:12),
      _buildTimeSlider(l10n.startTime, _startTime, Colors.green, (v) {
        setState(() {
          _startTime = Duration(milliseconds: v.toInt());
          if (_startTime >= _endTime) { _endTime = _startTime + const Duration(seconds: 1); if (_endTime > _duration) _endTime = _duration; }
        });
      }),
      const SizedBox(height:4),
      _buildTimeSlider(l10n.endTime, _endTime, Colors.orange, (v) {
        setState(() {
          _endTime = Duration(milliseconds: v.toInt());
          if (_endTime <= _startTime) { _startTime = _endTime - const Duration(seconds: 1); if (_startTime < Duration.zero) _startTime = Duration.zero; }
        });
      }),
      const SizedBox(height:8),
      Text(l10n.extractRange(_fmt(_startTime), _fmt(_endTime), _fmt(_endTime - _startTime)), style: TextStyle(color:Colors.teal.shade700, fontWeight:FontWeight.w600), overflow: TextOverflow.ellipsis),
      const SizedBox(height:12),
      Text(l10n.extractFps(_fps.toStringAsFixed(_fps==_fps.roundToDouble()?0:1)), style: const TextStyle(fontWeight:FontWeight.w600), overflow: TextOverflow.ellipsis),
      Slider(value: _fps, min:0.5, max:30, divisions:59, label: _fps.toStringAsFixed(1), onChanged: (v)=>setState(()=>_fps=v)),
      Text(l10n.estimatedImages(((_endTime - _startTime).inSeconds * _fps).round()), style: TextStyle(fontSize:13,color:Colors.grey.shade600), overflow: TextOverflow.ellipsis),
    ])),
    const SizedBox(height:20),
    if (_extractedImages.isEmpty) SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: _isProcessing?null:_extract,
      style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
      child: _isProcessing ? Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text(l10n.extracting,style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : Text(l10n.startExtract,style:TextStyle(fontSize:17,fontWeight:FontWeight.w600)),
    )) else Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Text(l10n.extractedImagesCount(_extractedImages.length), style: const TextStyle(fontWeight:FontWeight.w600,fontSize:16)),
      const SizedBox(height:12),
      SizedBox(height:200, child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, crossAxisSpacing:4, mainAxisSpacing:4), itemCount: _extractedImages.length.clamp(0, 30),
        itemBuilder: (_,i) => ClipRRect(borderRadius:BorderRadius.circular(8), child: Image.file(File(_extractedImages[i]), fit:BoxFit.cover)),
      )),
      if (_extractedImages.length > 30) Padding(padding: const EdgeInsets.only(top:8), child: Text(l10n.showingFirst30(_extractedImages.length), style: TextStyle(color:Colors.grey.shade600,fontSize:12))),
      const SizedBox(height:12),
      SizedBox(width:double.infinity, child: ElevatedButton(onPressed: _saveAllToGallery, style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.download),const SizedBox(width:8),Flexible(child: Text(l10n.saveAllCount(_extractedImages.length),overflow:TextOverflow.ellipsis))]))),
    ]),
    const SizedBox(height:12),
    TextButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.swap_horiz,color:Colors.white70), label: Text(l10n.changeVideo,style:const TextStyle(color:Colors.white70))),
  ]));

  Widget _buildTimeSlider(String label, Duration value, Color color, ValueChanged<double> onChanged) {
    final maxMs = _duration.inMilliseconds > 0 ? _duration.inMilliseconds.toDouble() : 1.0;
    final valMs = value.inMilliseconds.toDouble().clamp(0.0, maxMs);
    return Column(children: [
      Row(children: [Icon(Icons.access_time, size:16, color:color), const SizedBox(width:4), Expanded(child: Text(label, style: TextStyle(fontSize:13,color:Colors.grey.shade600), overflow: TextOverflow.ellipsis)), Text(_fmt(value), style: TextStyle(fontSize:13,fontWeight:FontWeight.w600,color:Colors.grey.shade800), overflow: TextOverflow.ellipsis)]),
      SliderTheme(data: SliderThemeData(activeTrackColor: color, inactiveTrackColor: color.withValues(alpha:0.2)), child: Slider(value: valMs, min:0, max:maxMs, onChanged: onChanged)),
    ]);
  }
}
