import 'dart:async';

import 'package:flutter/material.dart';

class FadeRightWidget extends StatefulWidget {
  final Widget child;
  final int delay;

  const FadeRightWidget({
    Key? key,
    required this.child,
    required this.delay,
  }) : super(key: key);

  @override
  _FadeRightWidgetState createState() => _FadeRightWidgetState();
}

class _FadeRightWidgetState extends State<FadeRightWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _animOffset = Tween<Offset>(
      begin: const Offset(0.35, 0.0),
      end: Offset.zero,
    ).animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
