import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class SignupSocialOptions extends StatelessWidget {
  const SignupSocialOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final captionStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: AppColors.textSecondary,
      fontSize: ResponsiveSize.fontSize(12),
    );

    return Column(
      children: [
        SizedBox(height: ResponsiveSize.height(20)),
        Text('or sign up with', style: captionStyle),
        SizedBox(height: ResponsiveSize.height(16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _SignupSocialButton(icon: Icons.g_mobiledata),
            _SignupSocialButton(icon: Icons.facebook),
            _SignupSocialButton(icon: Icons.fingerprint),
          ],
        ),
      ],
    );
  }
}

class _SignupSocialButton extends StatelessWidget {
  final IconData icon;

  const _SignupSocialButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(ResponsiveSize.width(28)),
        onTap: () {},
        child: Ink(
          width: ResponsiveSize.width(48),
          height: ResponsiveSize.width(48),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: ResponsiveSize.width(20),
          ),
        ),
      ),
    );
  }
}
