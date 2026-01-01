import 'package:flutter/material.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class SplashCascadeText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Animation<double> animation;
  final double startDelay;

  const SplashCascadeText({
    super.key,
    required this.text,
    required this.style,
    required this.animation,
    this.startDelay = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final chars = text.split('');
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < chars.length; i++)
          AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              final perChar = 0.12;
              final start = (startDelay + i * perChar).clamp(0.0, 0.9);
              final end = (start + 0.5).clamp(0.0, 1.0);
              final range = (animation.value - start) / (end - start);
              final normalized = range.clamp(0.0, 1.0);
              final eased = Curves.easeOutBack.transform(normalized);
              final dy = (1.0 - eased) * ResponsiveSize.height(20);
              final scale = 0.86 + 0.14 * eased;
              return Opacity(
                opacity: normalized,
                child: Transform.translate(
                  offset: Offset(0, dy),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.center,
                    child: Text(chars[i], style: style),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
