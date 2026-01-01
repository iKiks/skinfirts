import 'dart:math' as math;
import 'package:flutter/material.dart';

class SplashFloatingOrb extends StatelessWidget {
  final Animation<double> animation;
  final double radius;
  final double size;
  final double phaseOffset;
  final double verticalBias;
  final Color color;

  const SplashFloatingOrb({
    super.key,
    required this.animation,
    required this.radius,
    required this.size,
    required this.phaseOffset,
    required this.verticalBias,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final angle = animation.value * math.pi * 2 + phaseOffset;
        final offset = Offset(
          math.cos(angle) * radius,
          math.sin(angle) * radius * verticalBias,
        );
        final scale = 0.85 + 0.15 * math.sin(angle + phaseOffset);
        return Transform.translate(
          offset: offset,
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [color, color.withAlpha(0)]),
              ),
            ),
          ),
        );
      },
    );
  }
}
