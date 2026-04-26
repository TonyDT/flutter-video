// separate_av_page.dart
// 音视频分离 - 将视频的音频和画面分离

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:xixi_media_tool/l10n/app_localizations.dart';
import '../utils/native_file_helper.dart'
    if (dart.library.io) '../utils/native_file_helper.dart'
    if (dart.library.html) '../utils/native_file_helper_web.dart';
import '../utils/top_notify.dart';
import '../utils/temp_dir_helper.dart'
    if (dart.library.io) '../utils/temp_dir_helper.dart'
    if (dart.library.html) '../utils/temp_dir_helper_web.dart';

class SeparateAVPage extends StatefulWidget {
  const SeparateAVPage({super.key});
  @override
  State<SeparateAVPage> createState() => _SeparateAVPageState();
}

class _SeparateAVPageState extends State<SeparateAVPage> {
  String? _videoPath;
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;
  String? _videoOnlyPath;
  String? _audioOnlyPath;
  String? _mp3Path;
  bool _videoSaved = false;
  bool _audioSaved = false;
  bool _mp3Saved = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _audioPlaying = false;
  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF00695C), Color(0xFF26A69A), Color(0xFFE0F2F1)],
  );

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((d) { if (mounted) setState(() => _audioDuration = d); });
    _audioPlayer.onPositionChanged.listen((p) { if (mounted) setState(() => _audioPosition = p); });
    _audioPlayer.onPlayerComplete.listen((_) { if (mounted) setState(() { _audioPlaying = false; _audioPosition = Duration.zero; }); });
  }

  @override
  void dispose() { _controller?.dispose(); _audioPlayer.dispose(); super.dispose(); }

  Future<void> _pickVideo() async {
    if (!mounted || _isLoading) return;
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: false, withData: kIsWeb);
      if (!mounted || result == null || result.files.isEmpty) return;
      final file = result.files.first;
      if (file.path == null) return;
      _controller?.dispose(); _controller = null;
      await _audioPlayer.stop();
      setState(() {
        _isLoading = true;
        _videoOnlyPath = null; _audioOnlyPath = null; _mp3Path = null;
        _videoSaved = false; _audioSaved = false; _mp3Saved = false;
        _audioPlaying = false; _audioPosition = Duration.zero; _audioDuration = Duration.zero;
        _videoPath = file.path;
      });
      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      await ctrl.initialize();
      if (!mounted) { ctrl.dispose(); return; }
      ctrl.setLooping(true);
      await ctrl.play();
      setState(() { _controller = ctrl; _isLoading = false; });
    } catch (e) {
      if (mounted) _showError(l10n.selectVideoFailed);
      setState(() => _isLoading = false);
    }
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _separate() async {
    if (_videoPath == null || kIsWeb) return;
    final l10n = AppLocalizations.of(context)!;
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final ts = DateTime.now().millisecondsSinceEpoch;
      final videoOut = '${tempDir.path}/video_only_$ts.mp4';
      final audioOut = '${tempDir.path}/audio_only_$ts.m4a';
      final mp3Out = '${tempDir.path}/audio_only_$ts.mp3';

      final vCmd = '-i "$_videoPath" -c:v copy -an "$videoOut" -y';
      final vSession = await FFmpegKit.execute(vCmd);
      final vRc = await vSession.getReturnCode();
      bool videoOk = ReturnCode.isSuccess(vRc);
      if (!videoOk) {
        final vCmd2 = '-i "$_videoPath" -c:v libx264 -an -pix_fmt yuv420p "$videoOut" -y';
        final vSession2 = await FFmpegKit.execute(vCmd2);
        videoOk = ReturnCode.isSuccess(await vSession2.getReturnCode());
      }

      final aCmd = '-i "$_videoPath" -c:a aac -vn "$audioOut" -y';
      final aSession = await FFmpegKit.execute(aCmd);
      final aRc = await aSession.getReturnCode();
      bool audioOk = ReturnCode.isSuccess(aRc);
      if (!audioOk) {
        final aCmd1b = '-i "$_videoPath" -c:a copy -vn "$audioOut" -y';
        final aSession1b = await FFmpegKit.execute(aCmd1b);
        audioOk = ReturnCode.isSuccess(await aSession1b.getReturnCode());
      }

      bool mp3Ok = false;
      final mp3Cmd = '-i "$_videoPath" -c:a libmp3lame -q:a 2 -vn "$mp3Out" -y';
      final mp3Session = await FFmpegKit.execute(mp3Cmd);
      mp3Ok = ReturnCode.isSuccess(await mp3Session.getReturnCode());

      if (mounted) {
        setState(() {
          if (videoOk) _videoOnlyPath = videoOut;
          if (audioOk) _audioOnlyPath = audioOut;
          if (mp3Ok) _mp3Path = mp3Out;
        });
      }

      if (_videoOnlyPath != null || _audioOnlyPath != null || _mp3Path != null) {
        _showSuccess(l10n.separateComplete);
      } else { _showError(l10n.separateFailed); }
    } catch (e) {
      if (mounted) _showError(l10n.separateError(e.toString()));
    }
    if (mounted) setState(() => _isProcessing = false);
  }

  Future<void> _saveVideoFile() async {
    if (_videoOnlyPath == null) return;
    final l10n = AppLocalizations.of(context)!;
    try {
      final fileName = _videoOnlyPath!.split('/').last;
      final destPath = await FilePicker.platform.saveFile(
        dialogTitle: l10n.saveVideoOnly,
        fileName: fileName,
        type: FileType.video,
        allowedExtensions: ['mp4'],
      );
      if (destPath == null) return;
      final sourceFile = File(_videoOnlyPath!);
      if (await sourceFile.exists()) {
        await sourceFile.copy(destPath);
        setState(() => _videoSaved = true);
        _showSuccess(l10n.videoOnlySaved);
      } else { _showError(l10n.sourceFileNotExist); }
    } catch (e) { _showError(l10n.saveVideoError(e.toString())); }
  }

  Future<void> _saveAudioToFile(String path, String label, Function(bool) onSaved) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final fileName = path.split('/').last;
      final ext = fileName.split('.').last.toLowerCase();
      final destPath = await FilePicker.platform.saveFile(
        dialogTitle: l10n.saveLabel(label),
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: [ext],
      );
      if (destPath == null) return;
      final sourceFile = File(path);
      if (await sourceFile.exists()) {
        await sourceFile.copy(destPath);
        onSaved(true);
        _showSuccess(l10n.labelSaved(label));
      } else { _showError(l10n.fileNotExist(label)); }
    } catch (e) { _showError(l10n.saveLabelError(e.toString())); }
  }

  Future<void> _toggleAudioPlay() async {
    if (_audioOnlyPath == null && _mp3Path == null) return;
    final path = _mp3Path ?? _audioOnlyPath!;
    if (_audioPlaying) { await _audioPlayer.pause(); setState(() => _audioPlaying = false); }
    else { await _audioPlayer.play(DeviceFileSource(path)); setState(() => _audioPlaying = true); }
  }

  Future<void> _seekAudio(Duration pos) async { await _audioPlayer.seek(pos); }

  void _reset() {
    _controller?.dispose(); _audioPlayer.stop();
    setState(() {
      _videoPath = null; _controller = null;
      _videoOnlyPath = null; _audioOnlyPath = null; _mp3Path = null;
      _videoSaved = false; _audioSaved = false; _mp3Saved = false;
      _isProcessing = false;
      _audioPlaying = false; _audioPosition = Duration.zero; _audioDuration = Duration.zero;
    });
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
    Expanded(child: Text(l10n.separateAV, style: const TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea(AppLocalizations l10n) => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.layers_clear, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?l10n.loading:l10n.tapToSelectVideo, style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea(AppLocalizations l10n) => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    _buildVideoPlayer(),
    const SizedBox(height:16),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: Row(children: [
      const Icon(Icons.layers_clear, color: Colors.blue), const SizedBox(width:12), Expanded(child: Text(l10n.separateDescription, style: const TextStyle(fontSize:14))),
    ])),
    const SizedBox(height:20),
    if (_videoOnlyPath == null && _audioOnlyPath == null && _mp3Path == null) ...[
      SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: _isProcessing?null:_separate,
        style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF00695C),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
        child: _isProcessing ? Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text(l10n.separating,style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : Text(l10n.startSeparate,style:TextStyle(fontSize:17,fontWeight:FontWeight.w600)),
      )),
    ] else ...[
      if (_videoOnlyPath != null) Card(child: ListTile(
        leading: Icon(Icons.videocam, color: _videoSaved ? Colors.green : Colors.blue),
        title: Text(l10n.videoOnly, overflow: TextOverflow.ellipsis, maxLines: 1),
        subtitle: Text(_videoSaved ? l10n.savedToAlbumLabel : _videoOnlyPath!.split('/').last, overflow: TextOverflow.ellipsis, maxLines: 1),
        trailing: _videoSaved
          ? const Icon(Icons.check_circle, color: Colors.green)
          : IconButton(icon: const Icon(Icons.download), onPressed: _saveVideoFile),
      )),
      if (_audioOnlyPath != null) Card(child: _buildAudioCard(
        _audioOnlyPath!, l10n.m4aAudio, _audioSaved, Icons.audiotrack, Colors.orange,
        (ok) => setState(() => _audioSaved = ok),
      )),
      if (_mp3Path != null) Card(child: _buildAudioCard(
        _mp3Path!, l10n.mp3Audio, _mp3Saved, Icons.music_note, Colors.purple,
        (ok) => setState(() => _mp3Saved = ok),
      )),
      if (_audioOnlyPath != null || _mp3Path != null) _buildAudioPlayer(l10n),
      const SizedBox(height:12),
      Row(children: [
        Expanded(child: ElevatedButton.icon(
          onPressed: _reset,
          icon: const Icon(Icons.refresh, size:18),
          label: Text(l10n.reselect),
          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF43A047), foregroundColor:Colors.white, padding:const EdgeInsets.symmetric(vertical:12), shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),
        )),
      ]),
    ],
    const SizedBox(height:12),
    TextButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.swap_horiz,color:Colors.white70), label: Text(l10n.changeVideo,style:TextStyle(color:Colors.white70))),
  ]));

  Widget _buildVideoPlayer() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container(height: 220, decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
        child: const Center(child: CircularProgressIndicator(color: Colors.white)));
    }
    return Container(
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: GestureDetector(
            onTap: () { if (_controller!.value.isPlaying) { _controller!.pause(); } else { _controller!.play(); } setState(() {}); },
            child: Stack(alignment: Alignment.center, children: [
              VideoPlayer(_controller!),
              if (!_controller!.value.isPlaying)
                Container(decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(12), child: const Icon(Icons.play_arrow, color: Colors.white, size: 36)),
            ]),
          )),
        ),
        ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: _controller!,
          builder: (context, value, _) {
            final pos = value.position;
            final dur = value.duration;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(children: [
                SliderTheme(data: SliderThemeData(
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  trackHeight: 3, activeTrackColor: Colors.blue, inactiveTrackColor: Colors.white30, thumbColor: Colors.blue,
                ), child: Slider(
                  value: dur.inMilliseconds > 0 ? pos.inMilliseconds.clamp(0, dur.inMilliseconds).toDouble() : 0,
                  min: 0, max: dur.inMilliseconds > 0 ? dur.inMilliseconds.toDouble() : 1,
                  onChanged: (v) => _controller!.seekTo(Duration(milliseconds: v.round())),
                )),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(_formatDuration(pos), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  Text(_formatDuration(dur), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ]),
              ]),
            );
          },
        ),
      ]),
    );
  }

  Widget _buildAudioCard(String path, String label, bool saved, IconData icon, Color color, Function(bool) onSaved) {
    final l10n = AppLocalizations.of(context)!;
    return ListTile(
      leading: Icon(icon, color: saved ? Colors.green : color),
      title: Text(label, overflow: TextOverflow.ellipsis),
      subtitle: Text(saved ? l10n.savedToAlbumLabel : path.split('/').last, overflow: TextOverflow.ellipsis, maxLines: 1),
      trailing: saved
        ? const Icon(Icons.check_circle, color: Colors.green)
        : IconButton(icon: const Icon(Icons.download), onPressed: () => _saveAudioToFile(path, label, onSaved)),
    );
  }

  Widget _buildAudioPlayer(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(children: [
          const Icon(Icons.equalizer, color: Colors.blue, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(_mp3Path != null ? l10n.playMp3Audio : l10n.playM4aAudio,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          IconButton(icon: Icon(_audioPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            size: 40, color: Colors.blue), onPressed: _toggleAudioPlay),
          Expanded(child: SliderTheme(data: SliderThemeData(
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            trackHeight: 3, activeTrackColor: Colors.blue, inactiveTrackColor: Colors.grey.shade300, thumbColor: Colors.blue,
          ), child: Slider(
            value: _audioDuration.inMilliseconds > 0
              ? _audioPosition.inMilliseconds.clamp(0, _audioDuration.inMilliseconds).toDouble() : 0,
            min: 0, max: _audioDuration.inMilliseconds > 0 ? _audioDuration.inMilliseconds.toDouble() : 1,
            onChanged: (v) => _seekAudio(Duration(milliseconds: v.round())),
          ))),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(_formatDuration(_audioPosition), style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          Text(_formatDuration(_audioDuration), style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ]),
      ]),
    );
  }
}
