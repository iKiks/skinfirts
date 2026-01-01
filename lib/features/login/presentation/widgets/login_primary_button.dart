import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class LoginPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const LoginPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveSize.height(54),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.width(28)),
          ),
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveSize.fontSize(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
