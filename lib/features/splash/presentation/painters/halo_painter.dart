import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';

class SplashHaloPainter extends CustomPainter {
  final double progress;

  SplashHaloPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;

    final glowPaint = Paint()
      ..shader = ui.Gradient.radial(
        center,
        outerRadius,
        [AppColors.white.withAlpha(56), Colors.transparent],
        [0.0, 1.0],
      );
    canvas.drawCircle(center, outerRadius, glowPaint);

    final haloProgress = (math.sin(progress * math.pi * 2) + 1) / 2;
    final ringRadius = outerRadius * (0.56 + haloProgress * 0.1);
    final sweepPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..shader = ui.Gradient.sweep(
        center,
        [
          Colors.transparent,
          AppColors.white.withAlpha(148),
          Colors.transparent,
        ],
        [0.0, 0.5, 1.0],
      );
    canvas.drawCircle(center, ringRadius, sweepPaint);
  }

  @override
  bool shouldRepaint(covariant SplashHaloPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
