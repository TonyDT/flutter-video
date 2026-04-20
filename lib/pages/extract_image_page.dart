// extract_image_page.dart
// 提取图片 - 从视频中提取帧图片

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import '../utils/top_notify.dart';
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
    colors: [Color(0xFF4ECDC4), Color(0xFF36B3A8), Color(0xFFE0F7FA)],
  );

  @override
  void dispose() { _controller?.dispose(); super.dispose(); }

  Future<void> _pickVideo() async {
    if (!mounted || _isLoading) return;
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
      if (mounted) _showError('选择视频失败');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _extract() async {
    if (_videoPath == null || kIsWeb) return;
    if (_startTime >= _endTime) { _showError('开始时间必须小于结束时间'); return; }
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final outputDir = '${tempDir.path}/frames_${DateTime.now().millisecondsSinceEpoch}';
      await Directory(outputDir).create();
      final startSec = (_startTime.inMilliseconds / 1000.0).toStringAsFixed(3);
      final durationSec = ((_endTime - _startTime).inMilliseconds / 1000.0).toStringAsFixed(3);
      // -ss 在 -i 前面：快速 seek；-t 指定持续时长；fps 滤镜提取帧
      final cmd = '-ss $startSec -i "$_videoPath" -t $durationSec -vf fps=$_fps "$outputDir/frame_%04d.jpg" -y';
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      final dir = Directory(outputDir);
      if (ReturnCode.isSuccess(rc)) {
        final files = await dir.list().map((e) => e.path).where((p) => p.endsWith('.jpg')).toList();
        files.sort();
        if (files.isEmpty) {
          // 如果没有 jpg，检查是否有其他格式
          final allFiles = await dir.list().map((e) => e.path).toList();
          allFiles.sort();
          // 尝试不带 fps 滤镜重新提取（每秒一帧兜底）
          final fallbackCmd = '-ss $startSec -i "$_videoPath" -t $durationSec -r 1 "$outputDir/frame_%04d.jpg" -y';
          final fallbackSession = await FFmpegKit.execute(fallbackCmd);
          final fallbackRc = await fallbackSession.getReturnCode();
          if (ReturnCode.isSuccess(fallbackRc)) {
            final fallbackFiles = await dir.list().map((e) => e.path).where((p) => p.endsWith('.jpg') || p.endsWith('.png')).toList();
            fallbackFiles.sort();
            if (fallbackFiles.isNotEmpty && mounted) {
              setState(() { _extractedImages = fallbackFiles; });
              _showSuccess('提取了 ${fallbackFiles.length} 张图片');
            } else {
              _showError('未能提取到图片，请检查视频文件');
            }
          } else {
            _showError('提取失败');
          }
        } else {
          if (mounted) {
            setState(() { _extractedImages = files; });
            _showSuccess('提取了 ${files.length} 张图片');
          }
        }
      } else {
        // 主命令失败，尝试简单方式
        final fallbackCmd = '-i "$_videoPath" -ss $startSec -t $durationSec -r 1 "$outputDir/frame_%04d.jpg" -y';
        final fallbackSession = await FFmpegKit.execute(fallbackCmd);
        final fallbackRc = await fallbackSession.getReturnCode();
        if (ReturnCode.isSuccess(fallbackRc)) {
          final fallbackFiles = await dir.list().map((e) => e.path).where((p) => p.endsWith('.jpg') || p.endsWith('.png')).toList();
          fallbackFiles.sort();
          if (fallbackFiles.isNotEmpty && mounted) {
            setState(() { _extractedImages = fallbackFiles; });
            _showSuccess('提取了 ${fallbackFiles.length} 张图片');
          } else {
            _showError('未能提取到图片');
          }
        } else {
          _showError('提取失败');
        }
      }
    } catch (e) { _showError('提取出错: $e'); }
    if (mounted) setState(() => _isProcessing = false);
  }

  Future<void> _saveAllToGallery() async {
    if (_extractedImages.isEmpty) return;
    final ok = await PermissionHelper.requestPhotos();
    if (ok != true) { _showError('需要相册权限'); return; }
    int saved = 0;
    for (final imgPath in _extractedImages) {
      final r = await GallerySaverHelper.saveFile(imgPath);
      if (r == true) { saved++; }
    }
    if (saved > 0) {
      _showSuccess('已保存 $saved 张图片到相册');
    } else {
      _showError('保存失败');
    }
  }

  void _showError(String m) { if (mounted) TopNotify.error(context, m); }
  void _showSuccess(String m) { if (mounted) TopNotify.success(context, m); }
  String _fmt(Duration d) => '${d.inMinutes.toString().padLeft(2,'0')}:${(d.inSeconds%60).toString().padLeft(2,'0')}';

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
      _buildAppBar(), Expanded(child: _videoPath == null ? _buildPickArea() : _buildWorkArea()),
    ]))),
  );

  Widget _buildAppBar() => Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:8), child: Row(children: [
    IconButton(icon: const Icon(Icons.arrow_back,color:Colors.white), onPressed: () => Navigator.pop(context)),
    const Expanded(child: Text('提取图片', style: TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea() => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.image, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?'加载中...':'点击选择视频', style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea() => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    Container(height:180, decoration: BoxDecoration(color:Colors.black87, borderRadius:BorderRadius.circular(16)),
      child: _controller!=null&&_controller!.value.isInitialized ? ClipRRect(borderRadius:BorderRadius.circular(16), child: AspectRatio(aspectRatio:_controller!.value.aspectRatio, child: VideoPlayer(_controller!))) : const Center(child: CircularProgressIndicator(color:Colors.white))),
    const SizedBox(height:16),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Row(children: [const Icon(Icons.timer,color:Colors.teal), const SizedBox(width:8), Text('视频时长: ${_fmt(_duration)}', style: const TextStyle(fontWeight:FontWeight.w600))]),
      const SizedBox(height:12),
      // 时间范围选择
      _buildTimeSlider('开始时间', _startTime, Colors.green, (v) {
        setState(() {
          _startTime = Duration(milliseconds: v.toInt());
          if (_startTime >= _endTime) {
            _endTime = _startTime + const Duration(seconds: 1);
            if (_endTime > _duration) _endTime = _duration;
          }
        });
      }),
      const SizedBox(height:4),
      _buildTimeSlider('结束时间', _endTime, Colors.orange, (v) {
        setState(() {
          _endTime = Duration(milliseconds: v.toInt());
          if (_endTime <= _startTime) {
            _startTime = _endTime - const Duration(seconds: 1);
            if (_startTime < Duration.zero) _startTime = Duration.zero;
          }
        });
      }),
      const SizedBox(height:8),
      Text('提取范围: ${_fmt(_startTime)} - ${_fmt(_endTime)}  (共 ${_fmt(_endTime - _startTime)})', style: TextStyle(color:Colors.teal.shade700, fontWeight:FontWeight.w600)),
      const SizedBox(height:12),
      Text('提取频率: ${_fps.toStringAsFixed(_fps==_fps.roundToDouble()?0:1)} 帧/秒', style: const TextStyle(fontWeight:FontWeight.w600)),
      Slider(value: _fps, min:0.5, max:30, divisions:59, label: _fps.toStringAsFixed(1), onChanged: (v)=>setState(()=>_fps=v)),
      Text('预计提取约 ${((_endTime - _startTime).inSeconds * _fps).round()} 张图片', style: TextStyle(fontSize:13,color:Colors.grey.shade600)),
    ])),
    const SizedBox(height:20),
    if (_extractedImages.isEmpty) SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: _isProcessing?null:_extract,
      style: ElevatedButton.styleFrom(backgroundColor:Colors.teal,foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
      child: _isProcessing ? const Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text('提取中...',style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : const Text('开始提取',style:TextStyle(fontSize:17,fontWeight:FontWeight.w600)),
    )) else Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Text('已提取 ${_extractedImages.length} 张图片', style: const TextStyle(fontWeight:FontWeight.w600,fontSize:16)),
      const SizedBox(height:12),
      SizedBox(height:200, child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, crossAxisSpacing:4, mainAxisSpacing:4), itemCount: _extractedImages.length.clamp(0, 30),
        itemBuilder: (_,i) => ClipRRect(borderRadius:BorderRadius.circular(8), child: Image.file(File(_extractedImages[i]), fit:BoxFit.cover)),
      )),
      if (_extractedImages.length > 30) Padding(padding: const EdgeInsets.only(top:8), child: Text('仅显示前30张，共 ${_extractedImages.length} 张', style: TextStyle(color:Colors.grey.shade600,fontSize:12))),
      const SizedBox(height:12),
      SizedBox(width:double.infinity, child: ElevatedButton(onPressed: _saveAllToGallery, style: ElevatedButton.styleFrom(backgroundColor:Colors.green,foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.download),const SizedBox(width:8),Flexible(child: Text('保存全部 ${_extractedImages.length} 张到相册',overflow:TextOverflow.ellipsis))]))),
    ]),
    const SizedBox(height:12),
    TextButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.swap_horiz,color:Colors.white70), label: const Text('更换视频',style:TextStyle(color:Colors.white70))),
  ]));

  Widget _buildTimeSlider(String label, Duration value, Color color, ValueChanged<double> onChanged) {
    final maxMs = _duration.inMilliseconds > 0 ? _duration.inMilliseconds.toDouble() : 1.0;
    final valMs = value.inMilliseconds.toDouble().clamp(0.0, maxMs);
    return Column(children: [
      Row(children: [Icon(Icons.access_time, size:16, color:color), const SizedBox(width:4), Text(label, style: TextStyle(fontSize:13,color:Colors.grey.shade600)), const Spacer(), Text(_fmt(value), style: TextStyle(fontSize:13,fontWeight:FontWeight.w600,color:Colors.grey.shade800))]),
      SliderTheme(data: SliderThemeData(activeTrackColor: color, inactiveTrackColor: color.withValues(alpha:0.2)), child: Slider(value: valMs, min:0, max:maxMs, onChanged: onChanged)),
    ]);
  }
}
