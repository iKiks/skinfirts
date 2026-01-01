import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class SplashCornerGlows extends StatelessWidget {
  final Animation<double> animation;

  const SplashCornerGlows({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final t = animation.value * math.pi * 2;
        final intensity = 0.15 + 0.08 * math.sin(t);
        final blur = 22.0 + 6.0 * math.cos(t + math.pi / 4);
        return Stack(
          children: [
            Positioned(
              top: ResponsiveSize.height(36) + math.sin(t) * 8,
              left: ResponsiveSize.width(18),
              child: _buildGlowBlob(
                size: ResponsiveSize.width(132),
                blurSigma: blur,
                color: AppColors.white.withAlpha((intensity * 255).toInt()),
              ),
            ),
            Positioned(
              bottom: ResponsiveSize.height(28) + math.cos(t) * 12,
              right: ResponsiveSize.width(22),
              child: _buildGlowBlob(
                size: ResponsiveSize.width(168),
                blurSigma: blur * 1.1,
                color: AppColors.white.withAlpha(
                  (intensity * 0.8 * 255).toInt(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGlowBlob({
    required double size,
    required double blurSigma,
    required Color color,
  }) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
