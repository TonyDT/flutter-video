// split_video_page.dart
// 视频分割 - 按时间点将视频分割成多段

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

class SplitVideoPage extends StatefulWidget {
  const SplitVideoPage({super.key});
  @override
  State<SplitVideoPage> createState() => _SplitVideoPageState();
}

class _SplitVideoPageState extends State<SplitVideoPage> {
  String? _videoPath;
  Duration _duration = Duration.zero;
  List<Duration> _splitPoints = [];
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;
  List<String> _resultPaths = [];

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF33691E), Color(0xFF689F38), Color(0xFFF1F8E9)],
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
      setState(() { _isLoading = true; _resultPaths = []; _videoPath = file.path; });
      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }
      setState(() {
        _controller = ctrl;
        _duration = ctrl.value.duration;
        _isLoading = false;
        _splitPoints = [_duration ~/ 2];
      });
    } catch (e) {
      if (mounted) _showError(l10n.selectVideoFailed);
      setState(() => _isLoading = false);
    }
  }

  void _addSplitPoint() {
    if (_duration == Duration.zero) return;
    final allPoints = _getAllPoints();
    int longestIdx = 0;
    Duration longestDur = Duration.zero;
    for (int i = 0; i < allPoints.length - 1; i++) {
      final segDur = allPoints[i + 1] - allPoints[i];
      if (segDur > longestDur) { longestDur = segDur; longestIdx = i; }
    }
    final midPoint = allPoints[longestIdx] + longestDur ~/ 2;
    setState(() { _splitPoints.add(midPoint); _splitPoints.sort(); });
  }

  void _removeSplitPoint(int index) { setState(() { _splitPoints.removeAt(index); }); }

  List<Duration> _getAllPoints() {
    final points = [Duration.zero, ..._splitPoints, _duration];
    points.sort();
    return points;
  }

  Future<void> _split() async {
    if (_videoPath == null || kIsWeb) return;
    final l10n = AppLocalizations.of(context)!;
    if (_splitPoints.isEmpty) { _showError(l10n.addAtLeastOneSplitPoint); return; }
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final ts = DateTime.now().millisecondsSinceEpoch;
      final allPoints = _getAllPoints();
      _resultPaths = [];
      for (int i = 0; i < allPoints.length - 1; i++) {
        final output = '${tempDir.path}/split_${ts}_$i.mp4';
        final startSec = (allPoints[i].inMilliseconds / 1000.0).toStringAsFixed(3);
        final endSec = (allPoints[i + 1].inMilliseconds / 1000.0).toStringAsFixed(3);
        final cmd = '-i "$_videoPath" -ss $startSec -to $endSec -c:v libx264 -c:a aac -pix_fmt yuv420p "$output" -y';
        final session = await FFmpegKit.execute(cmd);
        final rc = await session.getReturnCode();
        if (ReturnCode.isSuccess(rc)) { _resultPaths.add(output); }
      }
      if (_resultPaths.isNotEmpty) { _showSuccess(l10n.splitComplete(_resultPaths.length)); }
      else { _showError(l10n.splitFailed); }
    } catch (e) { _showError(l10n.splitError(e.toString())); }
    setState(() => _isProcessing = false);
  }

  Future<void> _saveAllToGallery() async {
    if (_resultPaths.isEmpty) return;
    final l10n = AppLocalizations.of(context)!;
    await SaveToGallery.saveAll(_resultPaths, context, unit: l10n.segmentCount);
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
    Expanded(child: Text(l10n.splitVideo, style: const TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea(AppLocalizations l10n) => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.call_split, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?l10n.loading:l10n.tapToSelectVideo, style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea(AppLocalizations l10n) => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    Container(height:180, decoration: BoxDecoration(color:Colors.black87, borderRadius:BorderRadius.circular(16)),
      child: _controller!=null&&_controller!.value.isInitialized ? ClipRRect(borderRadius:BorderRadius.circular(16), child: AspectRatio(aspectRatio:_controller!.value.aspectRatio, child: VideoPlayer(_controller!))) : const Center(child: CircularProgressIndicator(color:Colors.white))),
    const SizedBox(height:16),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
      Row(children: [const Icon(Icons.timer,color:Colors.blue), const SizedBox(width:8), Expanded(child: Text(l10n.videoDuration(_fmt(_duration)), style: const TextStyle(fontWeight:FontWeight.w600), overflow: TextOverflow.ellipsis))]),
      const SizedBox(height:12),
      Row(children: [
        Text(l10n.splitPoints, style: const TextStyle(fontWeight:FontWeight.w600,fontSize:15)),
        const Spacer(),
        ElevatedButton.icon(onPressed: _addSplitPoint, icon: const Icon(Icons.add, size:18), label: Text(l10n.add, style: const TextStyle(fontSize:13)), style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF33691E),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(horizontal:10,vertical:6))),
      ]),
      const SizedBox(height:8),
      if (_splitPoints.isEmpty)
        Padding(padding: const EdgeInsets.symmetric(vertical:8), child: Text(l10n.noSplitPoints, style: TextStyle(color:Colors.grey.shade500,fontSize:13)))
      else
        ...List.generate(_splitPoints.length, (i) {
          return Padding(padding: const EdgeInsets.only(bottom:8), child: Column(children: [
            Row(children: [
              Icon(Icons.content_cut, size:16, color:Colors.blue.shade700),
              const SizedBox(width:8),
              Text(l10n.splitPoint(i+1), style: const TextStyle(fontSize:13,fontWeight:FontWeight.w600)),
              const SizedBox(width:8),
              Expanded(child: SliderTheme(data: SliderThemeData(activeTrackColor:Colors.blue, inactiveTrackColor:Colors.blue.withValues(alpha:0.2)), child: Slider(
                value: _splitPoints[i].inMilliseconds.toDouble().clamp(0.0, _duration.inMilliseconds.toDouble()),
                min: 0, max: _duration.inMilliseconds.toDouble(),
                onChanged: (v) { setState(() { _splitPoints[i] = Duration(milliseconds: v.toInt()); _splitPoints.sort(); }); },
              ))),
              Text(_fmt(_splitPoints[i]), style: const TextStyle(fontSize:13,fontWeight:FontWeight.w600)),
              const SizedBox(width:4),
              IconButton(icon: const Icon(Icons.close, size:18, color:Colors.red), onPressed: () => _removeSplitPoint(i), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
            ]),
          ]));
        }),
      if (_splitPoints.isNotEmpty) ...[
        const SizedBox(height:8), const Divider(), const SizedBox(height:4),
        Text(l10n.willProduceSegments(_splitPoints.length + 1), style: TextStyle(fontSize:13,color:Colors.grey.shade600), overflow: TextOverflow.ellipsis),
        const SizedBox(height:4),
        ...List.generate(_getAllPoints().length - 1, (i) {
          final pts = _getAllPoints();
          return Padding(padding: const EdgeInsets.only(bottom:2), child: Row(children: [
            Icon(Icons.play_circle_outline, size:14, color:Colors.green.shade600),
            const SizedBox(width:4),
            Text(l10n.segmentInfo(i+1, _fmt(pts[i]), _fmt(pts[i+1]), _fmt(pts[i+1] - pts[i])), style: const TextStyle(fontSize:12), overflow: TextOverflow.ellipsis),
          ]));
        }),
      ],
    ])),
    const SizedBox(height:20),
    if (_resultPaths.isEmpty) SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: _isProcessing?null:_split,
      style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF33691E),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
      child: _isProcessing ? Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text(l10n.splitting,style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : Text(l10n.startSplit,style:TextStyle(fontSize:17,fontWeight:FontWeight.w600)),
    )) else Column(children: [
      SizedBox(width:double.infinity, child: ElevatedButton(onPressed:_saveAllToGallery, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF2E7D32),foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))), child: Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.download),const SizedBox(width:8),Flexible(child: Text(l10n.saveAllSegments(_resultPaths.length),overflow:TextOverflow.ellipsis))]))),
      const SizedBox(height:12),
      ...List.generate(_resultPaths.length, (i) => Card(child: ListTile(leading: CircleAvatar(child: Text('${i+1}')), title: Text(l10n.segment(i+1), overflow: TextOverflow.ellipsis), subtitle: Text(_resultPaths[i].split('/').last, overflow: TextOverflow.ellipsis, maxLines: 1), trailing: const Icon(Icons.check_circle, color: Colors.green)))),
    ]),
    const SizedBox(height:12),
    TextButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.swap_horiz,color:Colors.white70), label: Text(l10n.changeVideo,style:const TextStyle(color:Colors.white70))),
  ]));
}
