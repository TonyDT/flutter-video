// mute_video_page.dart
// 视频消音 - 去除视频中的音频

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import '../utils/native_file_helper.dart'
    if (dart.library.io) '../utils/native_file_helper.dart'
    if (dart.library.html) '../utils/native_file_helper_web.dart';
import '../utils/top_notify.dart';
import '../utils/temp_dir_helper.dart'
    if (dart.library.io) '../utils/temp_dir_helper.dart'
    if (dart.library.html) '../utils/temp_dir_helper_web.dart';
import '../utils/permission_helper.dart'
    if (dart.library.io) '../utils/permission_helper.dart'
    if (dart.library.html) '../utils/permission_helper_web.dart';
import '../utils/gallery_saver_helper.dart'
    if (dart.library.io) '../utils/gallery_saver_helper.dart'
    if (dart.library.html) '../utils/gallery_saver_helper_web.dart';

class MuteVideoPage extends StatefulWidget {
  const MuteVideoPage({super.key});
  @override
  State<MuteVideoPage> createState() => _MuteVideoPageState();
}

class _MuteVideoPageState extends State<MuteVideoPage> {
  String? _videoPath;
  String? _resultPath;
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFFE0F2F1)],
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
      setState(() { _isLoading = true; _resultPath = null; _videoPath = file.path; });
      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }
      setState(() { _controller = ctrl; _isLoading = false; });
      await ctrl.play();
    } catch (e) {
      if (mounted) _showError('选择视频失败');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _mute() async {
    if (_videoPath == null || kIsWeb) return;
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final output = '${tempDir.path}/muted_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final cmd = '-i "$_videoPath" -c:v copy -an "$output" -y';
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      if (ReturnCode.isSuccess(rc)) {
        _resultPath = output;
        _showSuccess('消音成功！');
        _controller?.dispose();
        final newCtrl = VideoPlayerController.file(NativeFileHelper.getFile(output));
        _controller = newCtrl;
        await newCtrl.initialize();
        if (!mounted) { newCtrl.dispose(); return; }
        setState(() {});
        await newCtrl.play();
      } else { _showError('消音失败'); }
    } catch (e) { _showError('消音出错: $e'); }
    setState(() => _isProcessing = false);
  }

  Future<void> _saveToGallery() async {
    if (_resultPath == null) return;
    final ok = await PermissionHelper.requestPhotos();
    if (ok != true) { _showError('需要相册权限'); return; }
    final result = await GallerySaverHelper.saveFile(_resultPath!);
    if (result == true) { _showSuccess('已保存到相册'); } else { _showError('保存失败'); }
  }

  void _showError(String m) { if (mounted) TopNotify.error(context, m); }
  void _showSuccess(String m) { if (mounted) TopNotify.success(context, m); }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
      _buildAppBar(), Expanded(child: _videoPath == null ? _buildPickArea() : _buildWorkArea()),
    ]))),
  );

  Widget _buildAppBar() => Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:8), child: Row(children: [
    IconButton(icon: const Icon(Icons.arrow_back,color:Colors.white), onPressed: () => Navigator.pop(context)),
    const Expanded(child: Text('视频消音', style: TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea() => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.volume_off, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?'加载中...':'点击选择视频', style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea() => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    Container(height:220, decoration: BoxDecoration(color:Colors.black87, borderRadius:BorderRadius.circular(16)),
      child: _controller!=null&&_controller!.value.isInitialized ? ClipRRect(borderRadius:BorderRadius.circular(16), child: AspectRatio(aspectRatio:_controller!.value.aspectRatio, child: VideoPlayer(_controller!))) : const Center(child: CircularProgressIndicator(color:Colors.white))),
    const SizedBox(height:16),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: const Row(children: [
      Icon(Icons.volume_off, color: Colors.purple), SizedBox(width:12), Expanded(child: Text('将去除视频中的所有音频，仅保留画面', style: TextStyle(fontSize:14))),
    ])),
    const SizedBox(height:20),
    if (_resultPath == null) SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: _isProcessing?null:_mute,
      style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF00695C),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
      child: _isProcessing ? const Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text('消音中...',style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.volume_off),const SizedBox(width:10),Flexible(child: Text('去除音频',style:const TextStyle(fontSize:17,fontWeight:FontWeight.w600),overflow:TextOverflow.ellipsis))]),
    )) else Row(children: [
      Expanded(child: ElevatedButton(onPressed:_saveToGallery, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.download),const SizedBox(width:8),Flexible(child: Text('保存到相册',overflow:TextOverflow.ellipsis))]))),
      const SizedBox(width:12),
      Expanded(child: ElevatedButton(onPressed:(){ _controller?.dispose(); setState((){_resultPath=null;_controller=null;}); _pickVideo(); }, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF00695C),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.refresh),const SizedBox(width:8),Flexible(child: Text('重新选择',overflow:TextOverflow.ellipsis))]))),
    ]),
  ]));
}
