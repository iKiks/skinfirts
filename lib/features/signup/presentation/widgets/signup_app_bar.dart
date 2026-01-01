import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class SignupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignupAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: ResponsiveSize.width(18),
          color: AppColors.textPrimary,
        ),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(
        'New Account',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: ResponsiveSize.fontSize(20),
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ResponsiveSize.height(56));
}
