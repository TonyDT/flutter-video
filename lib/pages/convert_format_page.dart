// convert_format_page.dart
// 格式转换 - 转换视频格式

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

class ConvertFormatPage extends StatefulWidget {
  const ConvertFormatPage({super.key});
  @override
  State<ConvertFormatPage> createState() => _ConvertFormatPageState();
}

class _ConvertFormatPageState extends State<ConvertFormatPage> {
  String? _videoPath;
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;
  String? _resultPath;
  String _targetFormat = 'mp4';

  static const _formats = ['mp4', 'avi', 'mov', 'mkv', 'webm', 'flv', 'wmv', '3gp'];
  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF33691E), Color(0xFF558B2F), Color(0xFFF1F8E9)],
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
      setState(() { _isLoading = true; _resultPath = null; _videoPath = file.path; });
      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }
      setState(() { _controller = ctrl; _isLoading = false; });
    } catch (e) {
      if (mounted) _showError(l10n.selectVideoFailed);
      setState(() => _isLoading = false);
    }
  }

  Future<void> _convert() async {
    if (_videoPath == null || kIsWeb) return;
    final l10n = AppLocalizations.of(context)!;
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final output = '${tempDir.path}/converted_${DateTime.now().millisecondsSinceEpoch}.$_targetFormat';
      String cmd;
      if (_targetFormat == 'webm') {
        cmd = '-i "$_videoPath" -c:v libvpx -c:a libvorbis "$output" -y';
      } else if (_targetFormat == 'avi') {
        cmd = '-i "$_videoPath" -c:v mpeg4 -c:a mp3 "$output" -y';
      } else {
        cmd = '-i "$_videoPath" -c:v libx264 -c:a aac "$output" -y';
      }
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      if (ReturnCode.isSuccess(rc)) {
        _resultPath = output;
        _showSuccess(l10n.convertSuccess);
      } else { _showError(l10n.convertFailed); }
    } catch (e) { _showError(l10n.convertError(e.toString())); }
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
      _buildAppBar(l10n), Expanded(child: _videoPath == null ? _buildPickArea(l10n) : _buildWorkArea(l10n)),
    ]))));
  }

  Widget _buildAppBar(AppLocalizations l10n) => Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:8), child: Row(children: [
    IconButton(icon: const Icon(Icons.arrow_back,color:Colors.white), onPressed: () => Navigator.pop(context)),
    Expanded(child: Text(l10n.convertFormat, style: const TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea(AppLocalizations l10n) => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.autorenew, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?l10n.loading:l10n.tapToSelectVideo, style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea(AppLocalizations l10n) => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    Container(height:180, decoration: BoxDecoration(color:Colors.black87, borderRadius:BorderRadius.circular(16)),
      child: _controller!=null&&_controller!.value.isInitialized ? ClipRRect(borderRadius:BorderRadius.circular(16), child: AspectRatio(aspectRatio:_controller!.value.aspectRatio, child: VideoPlayer(_controller!))) : const Center(child: CircularProgressIndicator(color:Colors.white))),
    const SizedBox(height:16),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Text(l10n.targetFormat, style: const TextStyle(fontWeight:FontWeight.w600,fontSize:16)),
      const SizedBox(height:12),
      Wrap(spacing:8, runSpacing:8, children: _formats.map((f) => ChoiceChip(label: Text(f.toUpperCase()), selected: _targetFormat==f, onSelected: (_)=>setState(()=>_targetFormat=f))).toList()),
    ])),
    const SizedBox(height:20),
    if (_resultPath == null) SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: _isProcessing?null:_convert,
      style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF33691E),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
      child: _isProcessing ? Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text(l10n.converting,style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : Text(l10n.convertTo(_targetFormat.toUpperCase()),style:const TextStyle(fontSize:17,fontWeight:FontWeight.w600), overflow: TextOverflow.ellipsis),
    )) else Row(children: [
      Expanded(child: ElevatedButton(onPressed:_saveToGallery, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.download),const SizedBox(width:8),Flexible(child: Text(l10n.saveToAlbum,overflow:TextOverflow.ellipsis))]))),
      const SizedBox(width:12),
      Expanded(child: ElevatedButton(onPressed:(){ _controller?.dispose(); setState((){_resultPath=null;_controller=null;}); _pickVideo(); }, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF33691E),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.refresh),const SizedBox(width:8),Flexible(child: Text(l10n.reselect,overflow:TextOverflow.ellipsis))]))),
    ]),
  ]));
}
