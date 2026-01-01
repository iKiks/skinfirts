import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class SplashMorphingWavePainter extends CustomPainter {
  final double progress;
  final Color baseColor;

  SplashMorphingWavePainter({required this.progress, required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * math.pi * 2;
    final highlight = Color.lerp(baseColor, Colors.white, 0.25)!.withAlpha(97);
    final shadow = Color.lerp(baseColor, Colors.black, 0.32)!.withAlpha(115);

    final topWave = Path()
      ..moveTo(0, size.height * 0.18)
      ..cubicTo(
        size.width * 0.2,
        size.height * (0.12 + 0.06 * math.sin(t)),
        size.width * 0.42,
        size.height * (0.26 + 0.08 * math.cos(t * 1.1)),
        size.width,
        size.height * 0.2,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    final bottomWave = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.72)
      ..cubicTo(
        size.width * 0.24,
        size.height * (0.78 + 0.07 * math.sin(t + math.pi / 3)),
        size.width * 0.62,
        size.height * (0.88 + 0.05 * math.cos(t * 0.9)),
        size.width,
        size.height * 0.78,
      )
      ..lineTo(size.width, size.height)
      ..close();

    final topPaint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width, size.height * 0.28),
        [highlight, highlight.withAlpha(0)],
      );

    final bottomPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, size.height),
        Offset(size.width, size.height * 0.7),
        [shadow.withAlpha(0), shadow],
      );

    canvas.drawPath(topWave, topPaint);
    canvas.drawPath(bottomWave, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant SplashMorphingWavePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.baseColor != baseColor;
  }
}
