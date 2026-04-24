// dubbing_video_page.dart
// 视频配音 - 为视频添加或替换音频

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
import '../utils/save_to_gallery.dart';

class DubbingVideoPage extends StatefulWidget {
  const DubbingVideoPage({super.key});
  @override
  State<DubbingVideoPage> createState() => _DubbingVideoPageState();
}

class _DubbingVideoPageState extends State<DubbingVideoPage> {
  String? _videoPath;
  String? _audioPath;
  String? _videoName;
  String? _audioName;
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;
  String? _resultPath;
  bool _replaceAudio = true; // true=替换音频, false=混合音频

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF558B2F), Color(0xFF7CB342), Color(0xFFF1F8E9)],
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
      setState(() { _isLoading = true; _resultPath = null; _videoPath = file.path; _videoName = file.name; });
      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }
      setState(() { _controller = ctrl; _isLoading = false; });
    } catch (e) {
      if (mounted) _showError('选择视频失败');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickAudio() async {
    if (!mounted) return;
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.audio, allowMultiple: false, withData: kIsWeb);
      if (!mounted || result == null || result.files.isEmpty) return;
      final file = result.files.first;
      if (file.path == null) return;
      setState(() { _audioPath = file.path; _audioName = file.name; _resultPath = null; });
    } catch (e) {
      if (mounted) _showError('选择音频失败');
    }
  }

  Future<void> _dubbing() async {
    if (_videoPath == null || _audioPath == null || kIsWeb) return;
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final output = '${tempDir.path}/dubbed_${DateTime.now().millisecondsSinceEpoch}.mp4';
      String cmd;
      if (_replaceAudio) {
        cmd = '-i "$_videoPath" -i "$_audioPath" -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest "$output" -y';
      } else {
        cmd = '-i "$_videoPath" -i "$_audioPath" -c:v copy -c:a aac -filter_complex "[0:a][1:a]amix=inputs=2:duration=longest" -map 0:v -map 0:a "$output" -y';
      }
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      if (ReturnCode.isSuccess(rc)) {
        _resultPath = output;
        _showSuccess('配音成功！');
        _controller?.dispose();
        final newCtrl = VideoPlayerController.file(NativeFileHelper.getFile(output));
        _controller = newCtrl;
        await newCtrl.initialize();
        if (!mounted) { newCtrl.dispose(); return; }
        setState(() {});
        await newCtrl.play();
      } else { _showError('配音失败'); }
    } catch (e) { _showError('配音出错: $e'); }
    setState(() => _isProcessing = false);
  }

  Future<void> _saveToGallery() async {
    if (_resultPath == null) return;
    await SaveToGallery.save(_resultPath!, context);
  }

  void _showError(String m) { if (mounted) TopNotify.error(context, m); }
  void _showSuccess(String m) { if (mounted) TopNotify.success(context, m); }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
      _buildAppBar(), Expanded(child: _buildWorkArea()),
    ]))),
  );

  Widget _buildAppBar() => Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:8), child: Row(children: [
    IconButton(icon: const Icon(Icons.arrow_back,color:Colors.white), onPressed: () => Navigator.pop(context)),
    const Expanded(child: Text('视频配音', style: TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildWorkArea() => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    // 视频选择卡片
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Row(children: [const Icon(Icons.videocam,color:Color(0xFF2E7D32)), const SizedBox(width:8), Expanded(child: Text(_videoPath==null?'选择视频':_videoName??'已选择视频', style: TextStyle(fontWeight:FontWeight.w600,color:_videoPath==null?Colors.grey:Colors.black), overflow: TextOverflow.ellipsis))]),
      if (_videoPath != null && _controller != null && _controller!.value.isInitialized) Container(height:150,margin:const EdgeInsets.only(top:12), decoration:BoxDecoration(color:Colors.black87,borderRadius:BorderRadius.circular(12)), child: ClipRRect(borderRadius:BorderRadius.circular(12), child: AspectRatio(aspectRatio:_controller!.value.aspectRatio, child: VideoPlayer(_controller!))),
      ),
      const SizedBox(height:8),
      SizedBox(width:double.infinity, child: OutlinedButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.video_call), label: Flexible(child: Text(_videoPath==null?'选择视频':'更换视频', overflow: TextOverflow.ellipsis)))),
    ])),
    const SizedBox(height:12),
    // 音频选择卡片
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Row(children: [const Icon(Icons.audiotrack,color:Color(0xFF2E7D32)), const SizedBox(width:8), Expanded(child: Text(_audioPath==null?'选择音频':_audioName??'已选择音频', style: TextStyle(fontWeight:FontWeight.w600,color:_audioPath==null?Colors.grey:Colors.black), overflow: TextOverflow.ellipsis))]),
      const SizedBox(height:8),
      SizedBox(width:double.infinity, child: OutlinedButton.icon(onPressed: _pickAudio, icon: const Icon(Icons.audio_file), label: Flexible(child: Text(_audioPath==null?'选择音频':'更换音频', overflow: TextOverflow.ellipsis)))),
    ])),
    const SizedBox(height:12),
    // 模式选择
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      const Text('配音模式:', style: TextStyle(fontWeight:FontWeight.w600)),
      const SizedBox(height:8),
      SwitchListTile(title: const Text('替换原音频'), subtitle: const Text('关闭则混合两路音频'), value: _replaceAudio, onChanged: (v)=>setState(()=>_replaceAudio=v), dense:true),
    ])),
    const SizedBox(height:20),
    if (_resultPath == null) SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: (_videoPath!=null&&_audioPath!=null&&!_isProcessing) ? _dubbing : null,
      style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF558B2F),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
      child: _isProcessing ? const Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text('配音中...',style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : const Text('开始配音',style:TextStyle(fontSize:17,fontWeight:FontWeight.w600)),
    )) else Row(children: [
      Expanded(child: ElevatedButton(onPressed:_saveToGallery, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.download),const SizedBox(width:8),Flexible(child: Text('保存到相册',overflow:TextOverflow.ellipsis))]))),
      const SizedBox(width:12),
      Expanded(child: ElevatedButton(onPressed:(){ _controller?.dispose(); setState((){_resultPath=null;_controller=null;}); }, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF558B2F),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.refresh),const SizedBox(width:8),Flexible(child: Text('重新来过',overflow:TextOverflow.ellipsis))]))),
    ]),
  ]));
}
