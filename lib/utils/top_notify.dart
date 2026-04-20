import 'package:flutter/material.dart';

class TopNotify {
  static void show(BuildContext context, String message, {Color? backgroundColor, IconData? icon}) {
    if (!context.mounted) return;
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    final screenSize = MediaQuery.of(context).size;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) {
        return _TopNotifyWidget(
          topOffset: offset.dy,
          screenWidth: screenSize.width,
          message: message,
          backgroundColor: backgroundColor ?? Colors.black87,
          icon: icon,
          onDismiss: () {
            entry.remove();
          },
        );
      },
    );

    overlay.insert(entry);
  }

  static void error(BuildContext context, String message) {
    show(context, message, backgroundColor: Colors.red.shade700, icon: Icons.error_outline);
  }

  static void success(BuildContext context, String message) {
    show(context, message, backgroundColor: Colors.green.shade700, icon: Icons.check_circle_outline);
  }

  static void info(BuildContext context, String message) {
    show(context, message, backgroundColor: const Color(0xFF3D5A80), icon: Icons.info_outline);
  }
}

class _TopNotifyWidget extends StatefulWidget {
  final double topOffset;
  final double screenWidth;
  final String message;
  final Color backgroundColor;
  final IconData? icon;
  final VoidCallback onDismiss;

  const _TopNotifyWidget({
    required this.topOffset,
    required this.screenWidth,
    required this.message,
    required this.backgroundColor,
    this.icon,
    required this.onDismiss,
  });

  @override
  State<_TopNotifyWidget> createState() => _TopNotifyWidgetState();
}

class _TopNotifyWidgetState extends State<_TopNotifyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();

    // 自动消失
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _dismiss();
    });
  }

  void _dismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.topOffset + 4,
      left: 16,
      width: widget.screenWidth - 32,
      child: SlideTransition(
        position: _slideAnim,
        child: FadeTransition(
          opacity: _opacityAnim,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
