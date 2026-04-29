// dubbing_video_page.dart
// 视频配音 - 为视频添加或替换音频

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
  bool _replaceAudio = true;

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF78350F), Color(0xFF7C2D12), Color(0xFFFEF3C7)],
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
      setState(() { _isLoading = true; _resultPath = null; _videoPath = file.path; _videoName = file.name; });
      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }
      setState(() { _controller = ctrl; _isLoading = false; });
    } catch (e) {
      if (mounted) _showError(l10n.selectVideoFailed);
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickAudio() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.audio, allowMultiple: false, withData: kIsWeb);
      if (!mounted || result == null || result.files.isEmpty) return;
      final file = result.files.first;
      if (file.path == null) return;
      setState(() { _audioPath = file.path; _audioName = file.name; _resultPath = null; });
    } catch (e) {
      if (mounted) _showError(l10n.selectAudioFailed);
    }
  }

  Future<void> _dubbing() async {
    if (_videoPath == null || _audioPath == null || kIsWeb) return;
    final l10n = AppLocalizations.of(context)!;
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
        _showSuccess(l10n.dubbingSuccess);
        _controller?.dispose();
        final newCtrl = VideoPlayerController.file(NativeFileHelper.getFile(output));
        _controller = newCtrl;
        await newCtrl.initialize();
        if (!mounted) { newCtrl.dispose(); return; }
        setState(() {});
        await newCtrl.play();
      } else { _showError(l10n.dubbingFailed); }
    } catch (e) { _showError(l10n.dubbingError(e.toString())); }
    setState(() => _isProcessing = false);
  }

  Future<void> _saveToGallery() async {
    if (_resultPath == null) return;
    await SaveToGallery.save(_resultPath!, context);
  }

  void _showError(String m) { if (mounted) TopNotify.error(context, m); }
  void _showSuccess(String m) { if (mounted) TopNotify.success(context, m); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
    body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
      _buildAppBar(l10n), Expanded(child: _buildWorkArea(l10n)),
    ]))));
  }

  Widget _buildAppBar(AppLocalizations l10n) => Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:8), child: Row(children: [
    IconButton(icon: const Icon(Icons.arrow_back,color:Colors.white), onPressed: () => Navigator.pop(context)),
    Expanded(child: Text(l10n.dubbingVideo, style: const TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildWorkArea(AppLocalizations l10n) => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Row(children: [const Icon(Icons.videocam,color:Color(0xFF2E7D32)), const SizedBox(width:8), Expanded(child: Text(_videoPath==null?l10n.selectVideo:_videoName??l10n.videoSelected, style: TextStyle(fontWeight:FontWeight.w600,color:_videoPath==null?Colors.grey:Colors.black), overflow: TextOverflow.ellipsis))]),
      if (_videoPath != null && _controller != null && _controller!.value.isInitialized) Container(height:150,margin:const EdgeInsets.only(top:12), decoration:BoxDecoration(color:Colors.black87,borderRadius:BorderRadius.circular(12)), child: ClipRRect(borderRadius:BorderRadius.circular(12), child: AspectRatio(aspectRatio:_controller!.value.aspectRatio, child: VideoPlayer(_controller!)))),
      const SizedBox(height:8),
      SizedBox(width:double.infinity, child: OutlinedButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.video_call), label: Flexible(child: Text(_videoPath==null?l10n.selectVideo:l10n.changeVideo, overflow: TextOverflow.ellipsis)))),
    ])),
    const SizedBox(height:12),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Row(children: [const Icon(Icons.audiotrack,color:Color(0xFF2E7D32)), const SizedBox(width:8), Expanded(child: Text(_audioPath==null?l10n.selectAudio:_audioName??l10n.audioSelected, style: TextStyle(fontWeight:FontWeight.w600,color:_audioPath==null?Colors.grey:Colors.black), overflow: TextOverflow.ellipsis))]),
      const SizedBox(height:8),
      SizedBox(width:double.infinity, child: OutlinedButton.icon(onPressed: _pickAudio, icon: const Icon(Icons.audio_file), label: Flexible(child: Text(_audioPath==null?l10n.selectAudio:l10n.changeVideo, overflow: TextOverflow.ellipsis)))),
    ])),
    const SizedBox(height:12),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Text(l10n.dubbingMode, style: const TextStyle(fontWeight:FontWeight.w600)),
      const SizedBox(height:8),
      SwitchListTile(title: Text(l10n.replaceOriginalAudio), subtitle: Text(l10n.replaceAudioHint), value: _replaceAudio, onChanged: (v)=>setState(()=>_replaceAudio=v), dense:true),
    ])),
    const SizedBox(height:20),
    if (_resultPath == null) SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: (_videoPath!=null&&_audioPath!=null&&!_isProcessing) ? _dubbing : null,
      style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF558B2F),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
      child: _isProcessing ? Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text(l10n.dubbing,style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : Text(l10n.startDubbing,style:TextStyle(fontSize:17,fontWeight:FontWeight.w600)),
    )) else Row(children: [
      Expanded(child: ElevatedButton(onPressed:_saveToGallery, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.download),const SizedBox(width:8),Flexible(child: Text(l10n.saveToAlbum,overflow:TextOverflow.ellipsis))]))),
      const SizedBox(width:12),
      Expanded(child: ElevatedButton(onPressed:(){ _controller?.dispose(); setState((){_resultPath=null;_controller=null;}); }, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF558B2F),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.refresh),const SizedBox(width:8),Flexible(child: Text(l10n.startOver,overflow:TextOverflow.ellipsis))]))),
    ]),
  ]));
}
