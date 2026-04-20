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
import '../utils/permission_helper.dart'
    if (dart.library.io) '../utils/permission_helper.dart'
    if (dart.library.html) '../utils/permission_helper_web.dart';
import '../utils/gallery_saver_helper.dart'
    if (dart.library.io) '../utils/gallery_saver_helper.dart'
    if (dart.library.html) '../utils/gallery_saver_helper_web.dart';

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
  String? _resultPath;
  bool _controllerError = false;

  // 框选裁剪区域 (归一化 0~1，相对于视频显示区域)
  double _cropLeft = 0.0;
  double _cropTop = 0.0;
  double _cropRight = 1.0;
  double _cropBottom = 1.0;

  // 拖拽状态
  _DragHandle? _activeDrag;

  static const _bg = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFFFF6B6B), Color(0xFFEE5A5A), Color(0xFFFFEBEE)],
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
      _controller?.dispose(); _controller = null;
      setState(() {
        _isLoading = true; _resultPath = null; _controllerError = false;
        _videoPath = file.path;
        _cropLeft = 0.0; _cropTop = 0.0; _cropRight = 1.0; _cropBottom = 1.0;
      });
      final ctrl = VideoPlayerController.file(NativeFileHelper.getFile(file.path!));
      try {
        await ctrl.initialize();
      } catch (e) {
        if (mounted) {
          setState(() { _isLoading = false; _controllerError = true; });
          _showError('视频初始化失败');
        }
        ctrl.dispose();
        return;
      }
      if (!mounted) { ctrl.dispose(); return; }
      _videoWidth = ctrl.value.size.width.toInt();
      _videoHeight = ctrl.value.size.height.toInt();
      ctrl.setLooping(true);
      await ctrl.play();
      setState(() { _controller = ctrl; _isLoading = false; });
    } catch (e) {
      if (mounted) _showError('选择视频失败');
      setState(() => _isLoading = false);
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
      // 确保宽高为偶数（H.264要求）
      final ew = w - (w % 2);
      final eh = h - (h % 2);
      final cmd = '-i "$_videoPath" -vf "crop=$ew:$eh:$x:$y" -c:v libx264 -preset fast -c:a copy "$output" -y';
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();
      if (ReturnCode.isSuccess(rc)) {
        if (mounted) {
          _resultPath = output;
          _showSuccess('裁剪成功！');
          _controller?.dispose();
          final newCtrl = VideoPlayerController.file(NativeFileHelper.getFile(output));
          try {
            await newCtrl.initialize();
            if (mounted) {
              newCtrl.setLooping(true);
              await newCtrl.play();
              setState(() { _controller = newCtrl; });
            } else {
              newCtrl.dispose();
            }
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
    final ok = await PermissionHelper.requestPhotos();
    if (ok != true) { _showError('需要相册权限'); return; }
    final result = await GallerySaverHelper.saveFile(_resultPath!);
    if (result == true) _showSuccess('已保存到相册'); else _showError('保存失败');
  }

  void _reset() {
    _controller?.dispose();
    setState(() {
      _videoPath = null; _controller = null; _resultPath = null;
      _controllerError = false; _isProcessing = false;
      _cropLeft = 0.0; _cropTop = 0.0; _cropRight = 1.0; _cropBottom = 1.0;
    });
  }

  void _showError(String m) { if (mounted) TopNotify.error(context, m); }
  void _showSuccess(String m) { if (mounted) TopNotify.success(context, m); }

  bool get _hasCropArea => (_cropRight - _cropLeft) < 0.99 || (_cropBottom - _cropTop) < 0.99;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(decoration: const BoxDecoration(gradient: _bg), child: SafeArea(child: Column(children: [
      _buildAppBar(), Expanded(child: _videoPath == null ? _buildPickArea() : _buildWorkArea()),
    ]))),
  );

  Widget _buildAppBar() => Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:8), child: Row(children: [
    IconButton(icon: const Icon(Icons.arrow_back,color:Colors.white), onPressed: () => Navigator.pop(context)),
    const Expanded(child: Text('视频裁剪', style: TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold), textAlign:TextAlign.center, maxLines:1, overflow:TextOverflow.ellipsis)),
    const SizedBox(width:48),
  ]));

  Widget _buildPickArea() => Center(child: InkWell(onTap: _isLoading?null:_pickVideo, child: Container(
    padding: const EdgeInsets.all(32), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.crop, size: 64, color: Colors.white70),
      const SizedBox(height:16), Text(_isLoading?'加载中...':'点击选择视频', style: const TextStyle(color:Colors.white,fontSize:18)),
    ]),
  )));

  Widget _buildWorkArea() => SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
    // 视频播放器 + 框选裁剪区域
    _buildVideoWithCrop(),
    const SizedBox(height:12),
    // 裁剪信息
    if (_videoWidth != null && _videoHeight != null && _resultPath == null)
      Container(padding: const EdgeInsets.symmetric(horizontal:16, vertical:8), decoration: BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(12)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('原始: ${_videoWidth}x$_videoHeight', style: const TextStyle(fontSize:13, color: Colors.grey)),
          const SizedBox(width:12),
          const Icon(Icons.arrow_forward, size:16, color: Colors.grey),
          const SizedBox(width:12),
          Text('裁剪: ${(_videoWidth! * (_cropRight - _cropLeft)).toInt()}x${(_videoHeight! * (_cropBottom - _cropTop)).toInt()}', style: const TextStyle(fontSize:13, fontWeight: FontWeight.bold, color: Colors.red)),
        ]),
      ),
    const SizedBox(height:16),
    if (_resultPath == null) ...[
      // 操作提示
      Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.7), borderRadius: BorderRadius.circular(12)),
        child: const Row(children: [
          Icon(Icons.touch_app, color: Colors.red, size: 20), SizedBox(width:8),
          Expanded(child: Text('拖动视频上的裁剪框选择要保留的区域', style: TextStyle(fontSize: 13))),
        ]),
      ),
      const SizedBox(height:16),
      // 重置裁剪区域
      if (_hasCropArea) TextButton.icon(
        onPressed: () => setState(() { _cropLeft=0; _cropTop=0; _cropRight=1; _cropBottom=1; }),
        icon: const Icon(Icons.crop_free, color: Colors.white70),
        label: const Text('重置裁剪区域', style: TextStyle(color: Colors.white70)),
      ),
      const SizedBox(height:8),
      // 裁剪按钮
      SizedBox(width: double.infinity, height: 52, child: ElevatedButton(
        onPressed: (_hasCropArea && !_isProcessing) ? _crop : null,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)), elevation: 0),
        child: _isProcessing
          ? const Row(mainAxisAlignment: MainAxisSize.min, children: [SizedBox(width:24,height:24,child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)), SizedBox(width:12), Text('裁剪中...', style: TextStyle(fontSize:16, fontWeight: FontWeight.w600))])
          : const Text('开始裁剪', style: TextStyle(fontSize:17, fontWeight: FontWeight.w600)),
      )),
    ] else ...[
      Row(children: [
        Expanded(child: ElevatedButton(onPressed: _saveToGallery, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical:14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.download), SizedBox(width:8), Text('保存到相册')])),
        ),
        const SizedBox(width:12),
        Expanded(child: ElevatedButton(onPressed: _reset, style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical:14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.refresh), SizedBox(width:8), Text('重新选择')])),
        ),
      ]),
    ],
    const SizedBox(height:12),
    TextButton.icon(onPressed: _pickVideo, icon: const Icon(Icons.swap_horiz,color:Colors.white70), label: const Text('更换视频',style:TextStyle(color:Colors.white70))),
  ]));

  Widget _buildVideoWithCrop() {
    if (_controllerError) {
      return Container(height: 220, decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
        child: const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.error_outline, color: Colors.white54, size: 40),
          SizedBox(height:8), Text('视频加载失败', style: TextStyle(color: Colors.white54)),
        ])));
    }
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container(height: 220, decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
        child: const Center(child: CircularProgressIndicator(color: Colors.white)));
    }
    return Container(
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        // 视频画面 + 裁剪框
        ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: _CropOverlay(
            controller: _controller!,
            cropLeft: _cropLeft, cropTop: _cropTop, cropRight: _cropRight, cropBottom: _cropBottom,
            onCropChanged: (l, t, r, b) {
              setState(() { _cropLeft = l; _cropTop = t; _cropRight = r; _cropBottom = b; });
            },
            activeDrag: _activeDrag,
            onDragStart: (handle) => _activeDrag = handle,
            onDragEnd: () => _activeDrag = null,
          ),
        ),
        // 视频进度条
        ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: _controller!,
          builder: (context, value, _) {
            final pos = value.position;
            final dur = value.duration;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(children: [
                SliderTheme(data: SliderThemeData(
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  trackHeight: 3,
                  activeTrackColor: Colors.red,
                  inactiveTrackColor: Colors.white30,
                  thumbColor: Colors.red,
                ), child: Slider(
                  value: dur.inMilliseconds > 0 ? pos.inMilliseconds.clamp(0, dur.inMilliseconds).toDouble() : 0,
                  min: 0, max: dur.inMilliseconds > 0 ? dur.inMilliseconds.toDouble() : 1,
                  onChanged: (v) => _controller!.seekTo(Duration(milliseconds: v.round())),
                )),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(_formatDuration(pos), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  GestureDetector(
                    onTap: () {
                      if (_controller!.value.isPlaying) { _controller!.pause(); } else { _controller!.play(); }
                    },
                    child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 20),
                  ),
                  Text(_formatDuration(dur), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ]),
              ]),
            );
          },
        ),
      ]),
    );
  }
}

// 裁剪框的拖拽手柄类型
enum _DragHandle {
  topLeft, topRight, bottomLeft, bottomRight,
  top, bottom, left, right,
  inside,
}

// 视频裁剪框覆盖层
class _CropOverlay extends StatefulWidget {
  final VideoPlayerController controller;
  final double cropLeft, cropTop, cropRight, cropBottom;
  final void Function(double l, double t, double r, double b) onCropChanged;
  final _DragHandle? activeDrag;
  final void Function(_DragHandle handle) onDragStart;
  final void Function() onDragEnd;

  const _CropOverlay({
    required this.controller,
    required this.cropLeft, required this.cropTop,
    required this.cropRight, required this.cropBottom,
    required this.onCropChanged,
    required this.activeDrag,
    required this.onDragStart,
    required this.onDragEnd,
  });

  @override
  State<_CropOverlay> createState() => _CropOverlayState();
}

class _CropOverlayState extends State<_CropOverlay> {
  _DragHandle? _dragging;

  double _startLeft = 0, _startTop = 0, _startRight = 1, _startBottom = 1;
  Offset _dragStartPos = Offset.zero;

  static const double _minSize = 0.1; // 最小裁剪区域
  static const double _handleSize = 24.0;

  void _onPanStart(DragStartDetails details, BoxConstraints constraints) {
    final local = details.localPosition;
    final w = constraints.maxWidth;
    final h = constraints.maxHeight;

    final nx = (local.dx / w).clamp(0.0, 1.0);
    final ny = (local.dy / h).clamp(0.0, 1.0);

    // 判断触摸点在哪个手柄上
    final handleSize = _handleSize / w; // 归一化手柄区域
    final handleSizeY = _handleSize / h;

    _DragHandle? handle;

    // 四角手柄
    if ((nx - widget.cropLeft).abs() < handleSize * 2 && (ny - widget.cropTop).abs() < handleSizeY * 2) {
      handle = _DragHandle.topLeft;
    } else if ((nx - widget.cropRight).abs() < handleSize * 2 && (ny - widget.cropTop).abs() < handleSizeY * 2) {
      handle = _DragHandle.topRight;
    } else if ((nx - widget.cropLeft).abs() < handleSize * 2 && (ny - widget.cropBottom).abs() < handleSizeY * 2) {
      handle = _DragHandle.bottomLeft;
    } else if ((nx - widget.cropRight).abs() < handleSize * 2 && (ny - widget.cropBottom).abs() < handleSizeY * 2) {
      handle = _DragHandle.bottomRight;
    }
    // 四边手柄
    else if (ny >= widget.cropTop - handleSizeY && ny <= widget.cropTop + handleSizeY &&
             nx >= widget.cropLeft && nx <= widget.cropRight) {
      handle = _DragHandle.top;
    } else if (ny >= widget.cropBottom - handleSizeY && ny <= widget.cropBottom + handleSizeY &&
               nx >= widget.cropLeft && nx <= widget.cropRight) {
      handle = _DragHandle.bottom;
    } else if (nx >= widget.cropLeft - handleSize && nx <= widget.cropLeft + handleSize &&
               ny >= widget.cropTop && ny <= widget.cropBottom) {
      handle = _DragHandle.left;
    } else if (nx >= widget.cropRight - handleSize && nx <= widget.cropRight + handleSize &&
               ny >= widget.cropTop && ny <= widget.cropBottom) {
      handle = _DragHandle.right;
    }
    // 框内
    else if (nx >= widget.cropLeft && nx <= widget.cropRight &&
             ny >= widget.cropTop && ny <= widget.cropBottom) {
      handle = _DragHandle.inside;
    }

    if (handle != null) {
      _dragging = handle;
      _startLeft = widget.cropLeft;
      _startTop = widget.cropTop;
      _startRight = widget.cropRight;
      _startBottom = widget.cropBottom;
      _dragStartPos = details.globalPosition;
      widget.onDragStart(handle);
    }
  }

  void _onPanUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    if (_dragging == null) return;
    final w = constraints.maxWidth;
    final h = constraints.maxHeight;
    final dx = details.globalPosition.dx - _dragStartPos.dx;
    final dy = details.globalPosition.dy - _dragStartPos.dy;
    final ndx = dx / w;
    final ndy = dy / h;

    double l = _startLeft, t = _startTop, r = _startRight, b = _startBottom;

    switch (_dragging!) {
      case _DragHandle.topLeft:
        l = (_startLeft + ndx).clamp(0.0, r - _minSize);
        t = (_startTop + ndy).clamp(0.0, b - _minSize);
      case _DragHandle.topRight:
        r = (_startRight + ndx).clamp(l + _minSize, 1.0);
        t = (_startTop + ndy).clamp(0.0, b - _minSize);
      case _DragHandle.bottomLeft:
        l = (_startLeft + ndx).clamp(0.0, r - _minSize);
        b = (_startBottom + ndy).clamp(t + _minSize, 1.0);
      case _DragHandle.bottomRight:
        r = (_startRight + ndx).clamp(l + _minSize, 1.0);
        b = (_startBottom + ndy).clamp(t + _minSize, 1.0);
      case _DragHandle.top:
        t = (_startTop + ndy).clamp(0.0, b - _minSize);
      case _DragHandle.bottom:
        b = (_startBottom + ndy).clamp(t + _minSize, 1.0);
      case _DragHandle.left:
        l = (_startLeft + ndx).clamp(0.0, r - _minSize);
      case _DragHandle.right:
        r = (_startRight + ndx).clamp(l + _minSize, 1.0);
      case _DragHandle.inside:
        final cropW = _startRight - _startLeft;
        final cropH = _startBottom - _startTop;
        final newL = (_startLeft + ndx).clamp(0.0, 1.0 - cropW);
        final newT = (_startTop + ndy).clamp(0.0, 1.0 - cropH);
        l = newL; t = newT; r = newL + cropW; b = newT + cropH;
    }

    widget.onCropChanged(l, t, r, b);
  }

  void _onPanEnd(DragEndDetails details) {
    _dragging = null;
    widget.onDragEnd();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final aspectRatio = widget.controller.value.aspectRatio;
      // 计算视频在约束内的实际显示尺寸
      double videoW, videoH;
      if (constraints.maxWidth / constraints.maxHeight > aspectRatio) {
        videoH = constraints.maxHeight;
        videoW = videoH * aspectRatio;
      } else {
        videoW = constraints.maxWidth;
        videoH = videoW / aspectRatio;
      }
      final offsetX = (constraints.maxWidth - videoW) / 2;
      final offsetY = (constraints.maxHeight - videoH) / 2;

      return GestureDetector(
        onPanStart: (d) => _onPanStart(d, constraints),
        onPanUpdate: (d) => _onPanUpdate(d, constraints),
        onPanEnd: _onPanEnd,
        child: SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(children: [
            // 视频画面居中
            Positioned(
              left: offsetX, top: offsetY, width: videoW, height: videoH,
              child: AspectRatio(aspectRatio: aspectRatio, child: VideoPlayer(widget.controller)),
            ),
            // 遮罩 + 裁剪框
            Positioned(
              left: offsetX, top: offsetY, width: videoW, height: videoH,
              child: Stack(children: [
                // 四块半透明遮罩
                _buildMask(videoW, videoH),
                // 裁剪框边线
                Positioned(
                  left: widget.cropLeft * videoW,
                  top: widget.cropTop * videoH,
                  width: (widget.cropRight - widget.cropLeft) * videoW,
                  height: (widget.cropBottom - widget.cropTop) * videoH,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Stack(children: [
                      // 网格线 (三分法)
                      _buildGrid(),
                      // 四角手柄
                      _buildCornerHandle(Alignment.topLeft),
                      _buildCornerHandle(Alignment.topRight),
                      _buildCornerHandle(Alignment.bottomLeft),
                      _buildCornerHandle(Alignment.bottomRight),
                      // 四边中点手柄
                      _buildEdgeHandle(Alignment.topCenter),
                      _buildEdgeHandle(Alignment.bottomCenter),
                      _buildEdgeHandle(Alignment.centerLeft),
                      _buildEdgeHandle(Alignment.centerRight),
                    ]),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      );
    });
  }

  Widget _buildMask(double videoW, double videoH) {
    final cl = widget.cropLeft * videoW;
    final ct = widget.cropTop * videoH;
    final cw = (widget.cropRight - widget.cropLeft) * videoW;
    final ch = (widget.cropBottom - widget.cropTop) * videoH;
    final cr = cl + cw;
    final cb = ct + ch;

    return Stack(children: [
      // 上
      if (ct > 0) Positioned(left: 0, top: 0, width: videoW, height: ct,
        child: Container(color: Colors.black54)),
      // 下
      if (cb < videoH) Positioned(left: 0, top: cb, width: videoW, height: videoH - cb,
        child: Container(color: Colors.black54)),
      // 左
      if (cl > 0) Positioned(left: 0, top: ct, width: cl, height: ch,
        child: Container(color: Colors.black54)),
      // 右
      if (cr < videoW) Positioned(left: cr, top: ct, width: videoW - cr, height: ch,
        child: Container(color: Colors.black54)),
    ]);
  }

  Widget _buildGrid() {
    return Column(children: [
      Expanded(child: Row(children: [
        Expanded(child: Container(border: Border(right: BorderSide(color: Colors.white24, width: 0.5)))),
        Expanded(child: Container(border: Border(right: BorderSide(color: Colors.white24, width: 0.5)))),
        Expanded(child: Container()),
      ])),
      Expanded(child: Row(children: [
        Expanded(child: Container(border: Border(right: BorderSide(color: Colors.white24, width: 0.5)))),
        Expanded(child: Container(border: Border(right: BorderSide(color: Colors.white24, width: 0.5)))),
        Expanded(child: Container()),
      ])),
      Expanded(child: Row(children: [
        Expanded(child: Container(border: Border(right: BorderSide(color: Colors.white24, width: 0.5)))),
        Expanded(child: Container(border: Border(right: BorderSide(color: Colors.white24, width: 0.5)))),
        Expanded(child: Container()),
      ])),
    ]);
  }

  Widget _buildCornerHandle(Alignment alignment) {
    return Align(alignment: alignment, child: Container(
      width: _handleSize, height: _handleSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: alignment == Alignment.topLeft ? const BorderRadius.only(topLeft: Radius.circular(4)) :
                      alignment == Alignment.topRight ? const BorderRadius.only(topRight: Radius.circular(4)) :
                      alignment == Alignment.bottomLeft ? const BorderRadius.only(bottomLeft: Radius.circular(4)) :
                      const BorderRadius.only(bottomRight: Radius.circular(4)),
      ),
    ));
  }

  Widget _buildEdgeHandle(Alignment alignment) {
    return Align(alignment: alignment, child: Container(
      width: alignment == Alignment.topCenter || alignment == Alignment.bottomCenter ? 32 : 4,
      height: alignment == Alignment.topCenter || alignment == Alignment.bottomCenter ? 4 : 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
    ));
  }
}
