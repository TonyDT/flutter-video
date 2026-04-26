// ratio_video_page.dart
// 视频比例 - 调整视频宽高比

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

class RatioVideoPage extends StatefulWidget {
  const RatioVideoPage({super.key});
  @override
  State<RatioVideoPage> createState() => _RatioVideoPageState();
}

class _RatioVideoPageState extends State<RatioVideoPage> {
  String? _videoPath;
  int? _videoWidth;
  int? _videoHeight;
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;
  String? _resultPath;
  String _targetRatio = '16:9';
  String _scaleMode = 'fit';

  static const _ratios = ['16:9', '9:16', '4:3', '1:1', '21:9'];
  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF2E7D32), Color(0xFF43A047), Color(0xFFE8F5E9)],
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
      _videoWidth = ctrl.value.size.width.toInt();
      _videoHeight = ctrl.value.size.height.toInt();
      setState(() { _controller = ctrl; _isLoading = false; });
    } catch (e) {
      if (mounted) _showError(l10n.selectVideoFailed);
      setState(() => _isLoading = false);
    }
  }

  Future<void> _adjustRatio() async {
    if (_videoPath == null || kIsWeb || _videoWidth == null || _videoHeight == null) return;
    final l10n = AppLocalizations.of(context)!;
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final output = '${tempDir.path}/ratio_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final parts = _targetRatio.split(':');
      final tw = int.parse(parts[0]);
      final th = int.parse(parts[1]);

      final int iw = _videoWidth!;
      final int ih = _videoHeight!;
      final int ow = iw;
      final int oh = (iw * th / tw).round();
      final int targetW = ow % 2 == 0 ? ow : ow + 1;
      final int targetH = oh % 2 == 0 ? oh : oh + 1;

      String vf;

      if (_scaleMode == 'fit') {
        vf = 'scale=$targetW:$targetH';
      } else if (_scaleMode == 'pad') {
        final double scaleByW = targetW / iw;
        final double scaleByH = targetH / ih;
        final double scale = scaleByW < scaleByH ? scaleByW : scaleByH;
        int scaledW = (iw * scale).round();
        int scaledH = (ih * scale).round();
        if (scaledW % 2 != 0) scaledW += 1;
        if (scaledH % 2 != 0) scaledH += 1;
        vf = 'scale=$scaledW:$scaledH,pad=$targetW:$targetH:(ow-iw)/2:(oh-ih)/2:black';
      } else {
        final double scaleByW = targetW / iw;
        final double scaleByH = targetH / ih;
        final double scale = scaleByW > scaleByH ? scaleByW : scaleByH;
        int scaledW = (iw * scale).round();
        int scaledH = (ih * scale).round();
        if (scaledW % 2 != 0) scaledW += 1;
        if (scaledH % 2 != 0) scaledH += 1;
        vf = 'scale=$scaledW:$scaledH,crop=$targetW:$targetH:(iw-$targetW)/2:(ih-$targetH)/2';
      }

      debugPrint('Ratio adjust: mode=$_scaleMode ratio=$_targetRatio src=${iw}x${ih} target=${targetW}x${targetH} vf=$vf');
      final cmd = '-i "$_videoPath" -vf "$vf" -c:v libx264 -preset fast -c:a copy -pix_fmt yuv420p "$output" -y';
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      if (ReturnCode.isSuccess(rc)) {
        _resultPath = output;
        _showSuccess(l10n.ratioSuccess);
        _controller?.dispose();
        final newCtrl = VideoPlayerController.file(NativeFileHelper.getFile(output));
        _controller = newCtrl;
        await newCtrl.initialize();
        if (!mounted) { newCtrl.dispose(); return; }
        setState(() {});
        await newCtrl.play();
      } else { _showError(l10n.ratioFailed); }
    } catch (e) { _showError(l10n.ratioError(e.toString())); }
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
    Expanded(child: Text(l10n.ratioVideo, style: const TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea(AppLocalizations l10n) => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.aspect_ratio, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?l10n.loading:l10n.tapToSelectVideo, style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea(AppLocalizations l10n) => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    Container(height:180, decoration: BoxDecoration(color:Colors.black87, borderRadius:BorderRadius.circular(16)),
      child: _controller!=null&&_controller!.value.isInitialized ? ClipRRect(borderRadius:BorderRadius.circular(16), child: AspectRatio(aspectRatio:_controller!.value.aspectRatio, child: VideoPlayer(_controller!))) : const Center(child: CircularProgressIndicator(color:Colors.white))),
    const SizedBox(height:16),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Text(l10n.originalLabel, style: const TextStyle(fontWeight:FontWeight.w600), overflow: TextOverflow.ellipsis),
      const SizedBox(height:12),
      Text(l10n.targetRatio, style: const TextStyle(fontWeight:FontWeight.w600)),
      const SizedBox(height:8),
      Wrap(spacing:8, children: _ratios.map((r) => ChoiceChip(label: Text(r), selected: _targetRatio==r, onSelected: (_)=>setState(()=>_targetRatio=r))).toList()),
      const SizedBox(height:12),
      Text(l10n.scaleMode, style: const TextStyle(fontWeight:FontWeight.w600)),
      const SizedBox(height:8),
      Wrap(spacing:8, children: [
        ChoiceChip(label: Text(l10n.stretchFit), selected: _scaleMode=='fit', onSelected: (_)=>setState(()=>_scaleMode='fit')),
        ChoiceChip(label: Text(l10n.cropFill), selected: _scaleMode=='crop', onSelected: (_)=>setState(()=>_scaleMode='crop')),
        ChoiceChip(label: Text(l10n.letterbox), selected: _scaleMode=='pad', onSelected: (_)=>setState(()=>_scaleMode='pad')),
      ]),
    ])),
    const SizedBox(height:20),
    if (_resultPath == null) SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: _isProcessing?null:_adjustRatio,
      style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
      child: _isProcessing ? Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text(l10n.adjusting,style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : Text(l10n.startAdjust,style:TextStyle(fontSize:17,fontWeight:FontWeight.w600)),
    )) else Row(children: [
      Expanded(child: ElevatedButton(onPressed:_saveToGallery, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.download),const SizedBox(width:8),Flexible(child: Text(l10n.saveToAlbum,overflow:TextOverflow.ellipsis))]))),
      const SizedBox(width:12),
      Expanded(child: ElevatedButton(onPressed:(){ _controller?.dispose(); setState((){_resultPath=null;_controller=null;}); _pickVideo(); }, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF43A047),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.refresh),const SizedBox(width:8),Flexible(child: Text(l10n.reselect,overflow:TextOverflow.ellipsis))]))),
    ]),
  ]));
}
