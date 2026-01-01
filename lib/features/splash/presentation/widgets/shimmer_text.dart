import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class SplashShimmerText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Color shimmerColor;

  const SplashShimmerText({
    super.key,
    required this.text,
    required this.style,
    required this.shimmerColor,
  });

  @override
  State<SplashShimmerText> createState() => _SplashShimmerTextState();
}

class _SplashShimmerTextState extends State<SplashShimmerText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final width = MediaQuery.of(context).size.width;
        final shimmerWidth = width * 0.35;
        final x =
            -shimmerWidth + (width + shimmerWidth * 2) * _controller.value;
        return ShaderMask(
          shaderCallback: (bounds) {
            return ui.Gradient.linear(
              Offset(x, 0),
              Offset(x + shimmerWidth, 0),
              [
                Colors.transparent,
                widget.shimmerColor.withAlpha((0.35 * 255).toInt()),
                Colors.transparent,
              ],
              [0.25, 0.5, 0.75],
            );
          },
          blendMode: BlendMode.srcATop,
          child: child!,
        );
      },
      child: Text(widget.text, style: widget.style),
    );
  }
}
