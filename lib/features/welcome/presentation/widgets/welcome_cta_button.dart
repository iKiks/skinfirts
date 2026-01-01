import 'package:flutter/material.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class WelcomeCtaButton extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  const WelcomeCtaButton({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.height(45),
      width: ResponsiveSize.width(250),

      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.width(26)),
          ),
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveSize.fontSize(16),
          ),
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}
