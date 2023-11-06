import 'dart:math';

import 'package:flutter/material.dart';

class CountDownPainter extends CustomPainter {
  final Animation<double> animation;
  final Color ringColor;
  final Color fillColor;
  final double strokeWidth;

  CountDownPainter({
    required this.animation,
    required this.ringColor,
    required this.fillColor,
    required this.strokeWidth,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final offset = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2;

    final progress = (1.0 - animation.value) * 2 * pi;

    canvas.drawCircle(offset, radius, paint);
    paint.color = fillColor;
    canvas.drawArc(
      Rect.fromCircle(center: offset, radius: radius),
      -pi / 2,
      progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
