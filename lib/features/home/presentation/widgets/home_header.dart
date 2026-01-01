import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class HomeHeader extends StatelessWidget {
  final String? userName;

  const HomeHeader({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    final subtitleStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: AppColors.primary.withOpacity(0.75),
      fontSize: ResponsiveSize.fontSize(12),
    );
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontSize: ResponsiveSize.fontSize(18),
    );

    final resolvedName = userName?.trim().isNotEmpty ?? false
        ? _titleCase(userName!.trim())
        : 'John Doe';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: ResponsiveSize.width(24),
          backgroundColor: AppColors.secondary,
          backgroundImage: const AssetImage('assets/logo.png'),
        ),
        SizedBox(width: ResponsiveSize.width(6)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, WelcomeBack', style: subtitleStyle),
            SizedBox(height: ResponsiveSize.height(4)),
            Text(resolvedName, style: titleStyle),
          ],
        ),
        const Spacer(),
        _HeaderIconButton(icon: Icons.search, onPressed: () {}),
        _HeaderIconButton(icon: Icons.notifications_none, onPressed: () {}),
        _HeaderIconButton(icon: Icons.settings_outlined, onPressed: () {}),
      ],
    );
  }
}

String _titleCase(String value) {
  return value
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .map(
        (part) =>
            part.substring(0, 1).toUpperCase() +
            part.substring(1).toLowerCase(),
      )
      .join(' ');
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _HeaderIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(ResponsiveSize.width(14)),
      child: Ink(
        width: ResponsiveSize.width(40),
        height: ResponsiveSize.width(40),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(ResponsiveSize.width(14)),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: ResponsiveSize.width(20),
        ),
      ),
    );
  }
}
