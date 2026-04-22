// separate_av_page.dart
// 音视频分离 - 将视频的音频和画面分离

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
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
  String? _audioOnlyPath; // m4a
  String? _mp3Path;       // mp3
  bool _videoSaved = false;
  bool _audioSaved = false;
  bool _mp3Saved = false;

  // 音频播放
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
    _audioPlayer.onDurationChanged.listen((d) {
      if (mounted) setState(() => _audioDuration = d);
    });
    _audioPlayer.onPositionChanged.listen((p) {
      if (mounted) setState(() => _audioPosition = p);
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) setState(() { _audioPlaying = false; _audioPosition = Duration.zero; });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    if (!mounted || _isLoading) return;
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
      if (mounted) _showError('选择视频失败');
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
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final ts = DateTime.now().millisecondsSinceEpoch;
      final videoOut = '${tempDir.path}/video_only_$ts.mp4';
      final audioOut = '${tempDir.path}/audio_only_$ts.m4a';
      final mp3Out = '${tempDir.path}/audio_only_$ts.mp3';

      // 提取纯视频（用 copy 快速提取，失败则转码）
      final vCmd = '-i "$_videoPath" -c:v copy -an "$videoOut" -y';
      final vSession = await FFmpegKit.execute(vCmd);
      final vRc = await vSession.getReturnCode();
      bool videoOk = ReturnCode.isSuccess(vRc);
      if (!videoOk) {
        final vCmd2 = '-i "$_videoPath" -c:v libx264 -an -pix_fmt yuv420p "$videoOut" -y';
        final vSession2 = await FFmpegKit.execute(vCmd2);
        videoOk = ReturnCode.isSuccess(await vSession2.getReturnCode());
      }

      // 提取纯音频 - m4a（AAC 编码，兼容性好）
      final aCmd = '-i "$_videoPath" -c:a aac -vn "$audioOut" -y';
      final aSession = await FFmpegKit.execute(aCmd);
      final aRc = await aSession.getReturnCode();
      bool audioOk = ReturnCode.isSuccess(aRc);
      if (!audioOk) {
        // m4a 失败，尝试 copy 模式
        final aCmd1b = '-i "$_videoPath" -c:a copy -vn "$audioOut" -y';
        final aSession1b = await FFmpegKit.execute(aCmd1b);
        audioOk = ReturnCode.isSuccess(await aSession1b.getReturnCode());
      }

      // 同时提取 MP3 格式
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
        _showSuccess('分离完成！');
      } else {
        _showError('分离失败，视频可能不包含音视频轨道');
      }
    } catch (e) {
      if (mounted) _showError('分离出错: $e');
    }
    if (mounted) setState(() => _isProcessing = false);
  }

  Future<void> _saveVideoToGallery() async {
    if (_videoOnlyPath == null) return;
    final ok = await PermissionHelper.requestPhotos();
    if (ok != true) { _showError('需要相册权限'); return; }
    try {
      final result = await GallerySaverHelper.saveFile(_videoOnlyPath!);
      if (result) {
        setState(() => _videoSaved = true);
        _showSuccess('纯视频已保存到相册');
      } else {
        _showError('保存视频失败');
      }
    } catch (e) {
      _showError('保存视频出错: $e');
    }
  }

  Future<void> _saveAudioToFile(String path, String label, Function(bool) onSaved) async {
    try {
      final downloadsDir = await getDownloadsDirectory();
      if (downloadsDir == null) { _showError('无法获取下载目录'); return; }
      final fileName = path.split('/').last;
      final destPath = '${downloadsDir.path}/$fileName';
      final sourceFile = File(path);
      if (await sourceFile.exists()) {
        await sourceFile.copy(destPath);
        onSaved(true);
        _showSuccess('$label 已保存到: Downloads/$fileName');
      } else {
        _showError('$label 文件不存在');
      }
    } catch (e) {
      _showError('保存出错: $e');
    }
  }

  Future<void> _toggleAudioPlay() async {
    if (_audioOnlyPath == null && _mp3Path == null) return;
    final path = _mp3Path ?? _audioOnlyPath!;
    if (_audioPlaying) {
      await _audioPlayer.pause();
      setState(() => _audioPlaying = false);
    } else {
      await _audioPlayer.play(DeviceFileSource(path));
      setState(() => _audioPlaying = true);
    }
  }

  Future<void> _seekAudio(Duration pos) async {
    await _audioPlayer.seek(pos);
  }

  void _reset() {
    _controller?.dispose();
    _audioPlayer.stop();
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
  Widget build(BuildContext context) => Scaffold(
    body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
      _buildAppBar(), Expanded(child: _videoPath == null ? _buildPickArea() : _buildWorkArea()),
    ]))),
  );

  Widget _buildAppBar() => Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:8), child: Row(children: [
    IconButton(icon: const Icon(Icons.arrow_back,color:Colors.white), onPressed: () => Navigator.pop(context)),
    const Expanded(child: Text('音视频分离', style: TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea() => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.layers_clear, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?'加载中...':'点击选择视频', style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea() => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    // 视频播放器
    _buildVideoPlayer(),
    const SizedBox(height:16),
    // 说明
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(16)), child: const Row(children: [
      Icon(Icons.layers_clear, color: Colors.blue), SizedBox(width:12), Expanded(child: Text('将视频的画面和音频分别提取为独立文件', style: TextStyle(fontSize:14))),
    ])),
    const SizedBox(height:20),
    if (_videoOnlyPath == null && _audioOnlyPath == null && _mp3Path == null) ...[
      SizedBox(width:double.infinity,height:52, child: ElevatedButton(onPressed: _isProcessing?null:_separate,
        style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF00695C),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(26)),elevation:0),
        child: _isProcessing ? const Row(mainAxisAlignment:MainAxisAlignment.center,children:[SizedBox(width:24,height:24,child:CircularProgressIndicator(color:Colors.white,strokeWidth:2.5)),SizedBox(width:12),Text('分离中...',style:TextStyle(fontSize:16,fontWeight:FontWeight.w600))]) : const Text('开始分离',style:TextStyle(fontSize:17,fontWeight:FontWeight.w600)),
      )),
    ] else ...[
      // 纯视频
      if (_videoOnlyPath != null) Card(child: ListTile(
        leading: Icon(Icons.videocam, color: _videoSaved ? Colors.green : Colors.blue),
        title: const Text('纯视频（无音频）', overflow: TextOverflow.ellipsis, maxLines: 1),
        subtitle: Text(_videoSaved ? '已保存到相册' : _videoOnlyPath!.split('/').last, overflow: TextOverflow.ellipsis, maxLines: 1),
        trailing: _videoSaved
          ? const Icon(Icons.check_circle, color: Colors.green)
          : IconButton(icon: const Icon(Icons.download), onPressed: _saveVideoToGallery),
      )),
      // 纯音频 M4A
      if (_audioOnlyPath != null) Card(child: _buildAudioCard(
        _audioOnlyPath!, 'M4A 音频', _audioSaved, Icons.audiotrack, Colors.orange,
        (ok) => setState(() => _audioSaved = ok),
      )),
      // MP3 音频
      if (_mp3Path != null) Card(child: _buildAudioCard(
        _mp3Path!, 'MP3 音频', _mp3Saved, Icons.music_note, Colors.purple,
        (ok) => setState(() => _mp3Saved = ok),
      )),
      // 音频播放控制
      if (_audioOnlyPath != null || _mp3Path != null) _buildAudioPlayer(),
      const SizedBox(height:12),
      Row(children: [
        Expanded(child: ElevatedButton.icon(
          onPressed: _reset,
          icon: const Icon(Icons.refresh, size:18),
          label: const Text('重新选择'),
          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF43A047), foregroundColor:Colors.white, padding:const EdgeInsets.symmetric(vertical:12), shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),
        )),
      ]),
    ],
    const SizedBox(height:12),
    TextButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.swap_horiz,color:Colors.white70), label: const Text('更换视频',style:TextStyle(color:Colors.white70))),
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
            onTap: () {
              if (_controller!.value.isPlaying) { _controller!.pause(); } else { _controller!.play(); }
              setState(() {});
            },
            child: Stack(alignment: Alignment.center, children: [
              VideoPlayer(_controller!),
              if (!_controller!.value.isPlaying)
                Container(decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(12), child: const Icon(Icons.play_arrow, color: Colors.white, size: 36)),
            ]),
          )),
        ),
        // 视频进度条
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
                  trackHeight: 3,
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.white30,
                  thumbColor: Colors.blue,
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
    return ListTile(
      leading: Icon(icon, color: saved ? Colors.green : color),
      title: Text(label, overflow: TextOverflow.ellipsis),
      subtitle: Text(saved ? '已保存到 Downloads' : path.split('/').last, overflow: TextOverflow.ellipsis, maxLines: 1),
      trailing: saved
        ? const Icon(Icons.check_circle, color: Colors.green)
        : IconButton(icon: const Icon(Icons.download), onPressed: () => _saveAudioToFile(path, label, onSaved)),
    );
  }

  Widget _buildAudioPlayer() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(children: [
          const Icon(Icons.equalizer, color: Colors.blue, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(_mp3Path != null ? '播放 MP3 音频' : '播放 M4A 音频',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          IconButton(icon: Icon(_audioPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            size: 40, color: Colors.blue), onPressed: _toggleAudioPlay),
          Expanded(child: SliderTheme(data: SliderThemeData(
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            trackHeight: 3,
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Colors.blue,
          ), child: Slider(
            value: _audioDuration.inMilliseconds > 0
              ? _audioPosition.inMilliseconds.clamp(0, _audioDuration.inMilliseconds).toDouble()
              : 0,
            min: 0,
            max: _audioDuration.inMilliseconds > 0 ? _audioDuration.inMilliseconds.toDouble() : 1,
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
