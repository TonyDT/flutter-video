// crop_video_page.dart
// 视频裁剪 - 手动框选裁剪区域

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

class CropVideoPage extends StatefulWidget {
  const CropVideoPage({super.key});
  @override
  State<CropVideoPage> createState() => _CropVideoPageState();
}

class _CropVideoPageState extends State<CropVideoPage> {
  String? _videoPath;
  int? _videoWidth;
  int? _videoHeight;
  VideoPlayerController? _controller;
  bool _isProcessing = false;
  bool _isLoading = false;
  bool _controllerError = false;
  String? _resultPath;

  // 框选裁剪区域 (归一化 0~1，相对于视频画面)
  double _cropLeft = 0.05;
  double _cropTop = 0.05;
  double _cropRight = 0.95;
  double _cropBottom = 0.95;

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF1B5E20), Color(0xFF388E3C), Color(0xFFE8F5E9)],
  );

  @override
  void dispose() { _controller?.dispose(); super.dispose(); }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _pickVideo() async {
    if (!mounted || _isLoading) return;
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: false, withData: kIsWeb);
      if (!mounted || result == null || result.files.isEmpty) return;
      final file = result.files.first;
      if (file.path == null) return;

      // 先清理旧 controller
      final oldCtrl = _controller;
      _controller = null;

      setState(() {
        _isLoading = true; _controllerError = false; _resultPath = null;
        _videoPath = file.path;
        _cropLeft = 0.05; _cropTop = 0.05; _cropRight = 0.95; _cropBottom = 0.95;
      });

      // dispose 在 setState 之后
      oldCtrl?.dispose();

      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      try {
        await ctrl.initialize();
      } catch (e) {
        if (mounted) {
          setState(() { _isLoading = false; _controllerError = true; });
          _showError('视频初始化失败: $e');
        }
        ctrl.dispose();
        return;
      }

      if (!mounted) { ctrl.dispose(); return; }
      _videoWidth = ctrl.value.size.width.toInt();
      _videoHeight = ctrl.value.size.height.toInt();
      ctrl.setLooping(true);
      await ctrl.play();
      if (!mounted) { ctrl.dispose(); return; }
      setState(() { _controller = ctrl; _isLoading = false; });
    } catch (e) {
      if (mounted) _showError('选择视频失败: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _crop() async {
    if (_videoPath == null || kIsWeb || _videoWidth == null || _videoHeight == null) return;
    _controller?.pause();
    setState(() => _isProcessing = true);
    try {
      final tempDir = await TempDirHelper.getTemporaryDirectory();
      final output = '${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final w = (_videoWidth! * (_cropRight - _cropLeft)).toInt();
      final h = (_videoHeight! * (_cropBottom - _cropTop)).toInt();
      final x = (_videoWidth! * _cropLeft).toInt();
      final y = (_videoHeight! * _cropTop).toInt();
      // 确保宽高为偶数
      final ew = w - (w % 2);
      final eh = h - (h % 2);
      final cmd = '-i "$_videoPath" -vf "crop=$ew:$eh:$x:$y" -c:v libx264 -preset fast -c:a copy "$output" -y';
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      if (ReturnCode.isSuccess(rc)) {
        if (mounted) {
          _resultPath = output;
          _showSuccess('裁剪成功！');
          final oldCtrl = _controller;
          _controller = null;
          oldCtrl?.dispose();
          final newCtrl = VideoPlayerController.file(NativeFileHelper.getFile(output));
          try {
            await newCtrl.initialize();
            if (mounted) {
              newCtrl.setLooping(true);
              await newCtrl.play();
              if (mounted) setState(() { _controller = newCtrl; });
            } else { newCtrl.dispose(); }
          } catch (e) {
            if (mounted) _showError('预览裁剪结果失败，但文件已生成');
            newCtrl.dispose();
          }
        }
      } else {
        if (mounted) _showError('裁剪失败');
      }
    } catch (e) {
      if (mounted) _showError('裁剪出错: $e');
    }
    if (mounted) setState(() => _isProcessing = false);
  }

  Future<void> _saveToGallery() async {
    if (_resultPath == null) return;
    await SaveToGallery.save(_resultPath!, context);
  }

  void _reset() {
    final ctrl = _controller;
    _controller = null;
    ctrl?.dispose();
    setState(() {
      _videoPath = null; _resultPath = null;
      _controllerError = false; _isProcessing = false;
      _cropLeft = 0.05; _cropTop = 0.05; _cropRight = 0.95; _cropBottom = 0.95;
    });
  }

  void _showError(String m) { if (mounted) TopNotify.error(context, m); }
  void _showSuccess(String m) { if (mounted) TopNotify.success(context, m); }

  bool get _hasCropChanged => (_cropRight - _cropLeft) < 0.94 || (_cropBottom - _cropTop) < 0.94;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
      _buildAppBar(),
      Expanded(child: _videoPath == null ? _buildPickArea() : _buildWorkArea()),
    ]))),
  );

  Widget _buildAppBar() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Row(children: [
      IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      const Expanded(child: Text('视频裁剪', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis)),
      const SizedBox(width: 48),
    ]),
  );

  Widget _buildPickArea() => Center(child: InkWell(
    onTap: _isLoading ? null : _pickVideo,
    child: Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.crop, size: 64, color: Colors.white70),
        const SizedBox(height: 16),
        Text(_isLoading ? '加载中...' : '点击选择视频', style: const TextStyle(color: Colors.white, fontSize: 18)),
      ]),
    ),
  ));

  Widget _buildWorkArea() => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(children: [
      // 视频预览 + 裁剪框
      _buildVideoPreview(),
      const SizedBox(height: 12),
      // 裁剪尺寸信息
      if (_videoWidth != null && _videoHeight != null)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('原始: ${_videoWidth}x$_videoHeight', style: const TextStyle(fontSize: 13, color: Colors.grey), overflow: TextOverflow.ellipsis),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Text('裁剪: ${(_videoWidth! * (_cropRight - _cropLeft)).toInt()}x${(_videoHeight! * (_cropBottom - _cropTop)).toInt()}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.red), overflow: TextOverflow.ellipsis),
          ]),
        ),
      const SizedBox(height: 12),
      // 操作提示
      if (_resultPath == null)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(12)),
          child: const Row(children: [
            Icon(Icons.touch_app, color: Colors.red, size: 20), SizedBox(width: 8),
            Expanded(child: Text('拖动绿色方块或边线调整裁剪区域，拖动框内移动位置', style: TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis, maxLines: 2)),
          ]),
        ),
      const SizedBox(height: 16),
      // 按钮
      if (_resultPath == null) ...[
        if (_hasCropChanged)
          TextButton.icon(
            onPressed: () => setState(() { _cropLeft = 0.05; _cropTop = 0.05; _cropRight = 0.95; _cropBottom = 0.95; }),
            icon: const Icon(Icons.crop_free, color: Colors.white70),
            label: const Text('重置裁剪区域', style: TextStyle(color: Colors.white70)),
          ),
        const SizedBox(height: 8),
        SizedBox(width: double.infinity, height: 52, child: ElevatedButton(
          onPressed: (_hasCropChanged && !_isProcessing) ? _crop : null,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)), elevation: 0),
          child: _isProcessing
            ? const Row(mainAxisSize: MainAxisSize.min, children: [SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)), SizedBox(width: 12), Text('裁剪中...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))])
            : const Text('开始裁剪', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        )),
      ] else ...[
        Row(children: [
          Expanded(child: ElevatedButton(onPressed: _saveToGallery,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.download), SizedBox(width: 8), Flexible(child: Text('保存到相册', overflow: TextOverflow.ellipsis))]))),
          const SizedBox(width: 12),
          Expanded(child: ElevatedButton(onPressed: _reset,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF43A047), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.refresh), SizedBox(width: 8), Flexible(child: Text('重新选择', overflow: TextOverflow.ellipsis))]))),
        ]),
      ],
      const SizedBox(height: 12),
      TextButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.swap_horiz, color: Colors.white70), label: const Text('更换视频', style: TextStyle(color: Colors.white70))),
    ]),
  );

  Widget _buildVideoPreview() {
    if (_controllerError) {
      return Container(
        height: 240, decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
        child: const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.error_outline, color: Colors.white54, size: 40),
          SizedBox(height: 8), Text('视频加载失败', style: TextStyle(color: Colors.white54)),
        ])),
      );
    }
    if (_isLoading || _controller == null || !_controller!.value.isInitialized) {
      return Container(
        height: 240, decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
        child: const Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final controller = _controller!;
    final aspectRatio = controller.value.aspectRatio;

    return Container(
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        // 视频画面 + 裁剪框
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: _CropOverlay(
            controller: controller,
            aspectRatio: aspectRatio,
            cropLeft: _cropLeft, cropTop: _cropTop, cropRight: _cropRight, cropBottom: _cropBottom,
            onCropChanged: (l, t, r, b) { setState(() { _cropLeft = l; _cropTop = t; _cropRight = r; _cropBottom = b; }); },
          ),
        ),
        // 视频进度条
        _buildVideoControls(controller),
      ]),
    );
  }

  Widget _buildVideoControls(VideoPlayerController controller) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final pos = value.position;
        final dur = value.duration;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(children: [
            SliderTheme(data: SliderThemeData(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              trackHeight: 3, activeTrackColor: Colors.red, inactiveTrackColor: Colors.white30, thumbColor: Colors.red,
            ), child: Slider(
              value: dur.inMilliseconds > 0 ? pos.inMilliseconds.clamp(0, dur.inMilliseconds).toDouble() : 0,
              min: 0, max: dur.inMilliseconds > 0 ? dur.inMilliseconds.toDouble() : 1,
              onChanged: (v) => controller.seekTo(Duration(milliseconds: v.round())),
            )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(_formatDuration(pos), style: const TextStyle(color: Colors.white70, fontSize: 12)),
              GestureDetector(
                onTap: () { if (controller.value.isPlaying) { controller.pause(); } else { controller.play(); } setState(() {}); },
                child: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 20),
              ),
              Text(_formatDuration(dur), style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ]),
        );
      },
    );
  }
}

// ─── 裁剪框覆盖层 ───────────────────────────────────────────

enum _DragHandle { topLeft, topRight, bottomLeft, bottomRight, top, bottom, left, right, inside }

class _CropOverlay extends StatefulWidget {
  final VideoPlayerController controller;
  final double aspectRatio;
  final double cropLeft, cropTop, cropRight, cropBottom;
  final void Function(double l, double t, double r, double b) onCropChanged;

  const _CropOverlay({
    required this.controller,
    required this.aspectRatio,
    required this.cropLeft, required this.cropTop,
    required this.cropRight, required this.cropBottom,
    required this.onCropChanged,
  });

  @override
  State<_CropOverlay> createState() => _CropOverlayState();
}

class _CropOverlayState extends State<_CropOverlay> {
  static const double _handleSize = 24.0;
  static const double _minSize = 0.08;

  _DragHandle? _dragging;
  double _startL = 0, _startT = 0, _startR = 1, _startB = 1;
  Offset _startPos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return GestureDetector(
          onPanStart: (d) => _handlePanStart(d, w, h),
          onPanUpdate: (d) => _handlePanUpdate(d, w, h),
          onPanEnd: (_) => _dragging = null,
          child: Stack(fit: StackFit.expand, children: [
            VideoPlayer(widget.controller),
            _buildMask(w, h),
            Positioned(
              left: widget.cropLeft * w,
              top: widget.cropTop * h,
              width: (widget.cropRight - widget.cropLeft) * w,
              height: (widget.cropBottom - widget.cropTop) * h,
              child: _buildCropFrame(),
            ),
          ]),
        );
      }),
    );
  }

  Widget _buildMask(double w, double h) {
    final cl = widget.cropLeft * w, ct = widget.cropTop * h;
    final cw = (widget.cropRight - widget.cropLeft) * w, ch = (widget.cropBottom - widget.cropTop) * h;
    final cr = cl + cw, cb = ct + ch;

    return Stack(children: [
      if (ct > 0) Positioned(left: 0, top: 0, width: w, height: ct, child: Container(color: Colors.black54)),
      if (cb < h) Positioned(left: 0, top: cb, width: w, height: h - cb, child: Container(color: Colors.black54)),
      if (cl > 0) Positioned(left: 0, top: ct, width: cl, height: ch, child: Container(color: Colors.black54)),
      if (cr < w) Positioned(left: cr, top: ct, width: w - cr, height: ch, child: Container(color: Colors.black54)),
    ]);
  }

  Widget _buildCropFrame() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 2)),
      child: Stack(children: [
        // 三分法网格
        Column(children: [
          Expanded(child: Row(children: [
            Expanded(child: Container(decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.white24, width: 0.5))))),
            Expanded(child: Container(decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.white24, width: 0.5))))),
            const Expanded(child: SizedBox()),
          ])),
          Expanded(child: Row(children: [
            Expanded(child: Container(decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.white24, width: 0.5))))),
            Expanded(child: Container(decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.white24, width: 0.5))))),
            const Expanded(child: SizedBox()),
          ])),
          Expanded(child: Row(children: [
            Expanded(child: Container(decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.white24, width: 0.5))))),
            Expanded(child: Container(decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.white24, width: 0.5))))),
            const Expanded(child: SizedBox()),
          ])),
        ]),
        // 四角手柄
        _corner(Alignment.topLeft, const BorderRadius.only(topLeft: Radius.circular(4))),
        _corner(Alignment.topRight, const BorderRadius.only(topRight: Radius.circular(4))),
        _corner(Alignment.bottomLeft, const BorderRadius.only(bottomLeft: Radius.circular(4))),
        _corner(Alignment.bottomRight, const BorderRadius.only(bottomRight: Radius.circular(4))),
        // 四边中点手柄（上下手柄更宽更高便于触摸）
        _edge(Alignment.topCenter, 48, 8),
        _edge(Alignment.bottomCenter, 48, 8),
        _edge(Alignment.centerLeft, 8, 48),
        _edge(Alignment.centerRight, 8, 48),
      ]),
    );
  }

  Widget _corner(Alignment align, BorderRadius radius) => Align(alignment: align, child: Container(
    width: _handleSize, height: _handleSize,
    decoration: BoxDecoration(color: Colors.green, borderRadius: radius, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 4)]),
  ));

  Widget _edge(Alignment align, double w, double h) => Align(alignment: align, child: Container(
    width: w, height: h,
    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(3), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 4)]),
  ));

  void _handlePanStart(DragStartDetails d, double w, double h) {
    final nx = (d.localPosition.dx / w).clamp(0.0, 1.0);
    final ny = (d.localPosition.dy / h).clamp(0.0, 1.0);
    // 上下边使用更大的触摸阈值，因为视频通常宽>高，归一化后纵向更短
    final thresholdX = 0.06;
    final thresholdY = (h / w) * 0.06; // 根据宽高比自适应，竖屏视频纵向阈值更大
    final edgeThresholdY = (thresholdY * 2.5).clamp(0.04, 0.12); // 上下边额外加大
    final edgeThresholdX = (thresholdX * 2.5).clamp(0.04, 0.12); // 左右边额外加大

    _DragHandle? handle;
    if ((nx - widget.cropLeft).abs() < thresholdX && (ny - widget.cropTop).abs() < thresholdY) {
      handle = _DragHandle.topLeft;
    } else if ((nx - widget.cropRight).abs() < thresholdX && (ny - widget.cropTop).abs() < thresholdY) {
      handle = _DragHandle.topRight;
    } else if ((nx - widget.cropLeft).abs() < thresholdX && (ny - widget.cropBottom).abs() < thresholdY) {
      handle = _DragHandle.bottomLeft;
    } else if ((nx - widget.cropRight).abs() < thresholdX && (ny - widget.cropBottom).abs() < thresholdY) {
      handle = _DragHandle.bottomRight;
    } else if (ny >= widget.cropTop - edgeThresholdY && ny <= widget.cropTop + edgeThresholdY && nx >= widget.cropLeft && nx <= widget.cropRight) {
      handle = _DragHandle.top;
    } else if (ny >= widget.cropBottom - edgeThresholdY && ny <= widget.cropBottom + edgeThresholdY && nx >= widget.cropLeft && nx <= widget.cropRight) {
      handle = _DragHandle.bottom;
    } else if (nx >= widget.cropLeft - edgeThresholdX && nx <= widget.cropLeft + edgeThresholdX && ny >= widget.cropTop && ny <= widget.cropBottom) {
      handle = _DragHandle.left;
    } else if (nx >= widget.cropRight - edgeThresholdX && nx <= widget.cropRight + edgeThresholdX && ny >= widget.cropTop && ny <= widget.cropBottom) {
      handle = _DragHandle.right;
    } else if (nx >= widget.cropLeft && nx <= widget.cropRight && ny >= widget.cropTop && ny <= widget.cropBottom) {
      handle = _DragHandle.inside;
    }

    if (handle != null) {
      _dragging = handle;
      _startL = widget.cropLeft; _startT = widget.cropTop;
      _startR = widget.cropRight; _startB = widget.cropBottom;
      _startPos = d.globalPosition;
    }
  }

  void _handlePanUpdate(DragUpdateDetails d, double w, double h) {
    if (_dragging == null) return;
    final dx = (d.globalPosition.dx - _startPos.dx) / w;
    final dy = (d.globalPosition.dy - _startPos.dy) / h;

    double l = _startL, t = _startT, r = _startR, b = _startB;

    switch (_dragging!) {
      case _DragHandle.topLeft:
        l = (_startL + dx).clamp(0.0, r - _minSize);
        t = (_startT + dy).clamp(0.0, b - _minSize);
      case _DragHandle.topRight:
        r = (_startR + dx).clamp(l + _minSize, 1.0);
        t = (_startT + dy).clamp(0.0, b - _minSize);
      case _DragHandle.bottomLeft:
        l = (_startL + dx).clamp(0.0, r - _minSize);
        b = (_startB + dy).clamp(t + _minSize, 1.0);
      case _DragHandle.bottomRight:
        r = (_startR + dx).clamp(l + _minSize, 1.0);
        b = (_startB + dy).clamp(t + _minSize, 1.0);
      case _DragHandle.top:
        t = (_startT + dy).clamp(0.0, b - _minSize);
      case _DragHandle.bottom:
        b = (_startB + dy).clamp(t + _minSize, 1.0);
      case _DragHandle.left:
        l = (_startL + dx).clamp(0.0, r - _minSize);
      case _DragHandle.right:
        r = (_startR + dx).clamp(l + _minSize, 1.0);
      case _DragHandle.inside:
        final cw = _startR - _startL;
        final ch = _startB - _startT;
        l = (_startL + dx).clamp(0.0, 1.0 - cw);
        t = (_startT + dy).clamp(0.0, 1.0 - ch);
        r = l + cw; b = t + ch;
    }

    widget.onCropChanged(l, t, r, b);
  }
}
