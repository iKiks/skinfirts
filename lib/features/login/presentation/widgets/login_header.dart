import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w700,
      fontSize: ResponsiveSize.fontSize(26),
    );
    final subtitleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: ResponsiveSize.fontSize(14),
      height: 1.5,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome', style: titleStyle),
        SizedBox(height: ResponsiveSize.height(6)),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          style: subtitleStyle,
        ),
      ],
    );
  }
}
