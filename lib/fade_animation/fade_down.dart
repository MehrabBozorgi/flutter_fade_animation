import 'dart:async';

import 'package:flutter/material.dart';

class FadeDownWidget extends StatefulWidget {
  final Widget child;
  final int delay;

  const FadeDownWidget({
    Key? key,
    required this.child,
    required this.delay,
  }) : super(key: key);

  @override
  _FadeDownWidgetState createState() => _FadeDownWidgetState();
}

class _FadeDownWidgetState extends State<FadeDownWidget>
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
      begin: const Offset(0.0, 0.35),
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
