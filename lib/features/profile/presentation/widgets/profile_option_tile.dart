import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.showDivider = true,
    this.iconColor,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.textPrimary,
          fontSize: ResponsiveSize.fontSize(15),
          fontWeight: FontWeight.w500,
        );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(8),
            vertical: ResponsiveSize.height(14),
          ),
          decoration: BoxDecoration(
            border: showDivider
                ? Border(
                    bottom: BorderSide(
                      color: AppColors.textPrimary.withOpacity(0.08),
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: ResponsiveSize.width(42),
                height: ResponsiveSize.width(42),
                decoration: BoxDecoration(
                  color: iconBackgroundColor ??
                      AppColors.secondary.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? AppColors.primary,
                  size: ResponsiveSize.width(20),
                ),
              ),
              SizedBox(width: ResponsiveSize.width(16)),
              Expanded(child: Text(label, style: labelStyle)),
              Icon(
                Icons.chevron_right,
                color: AppColors.primary,
                size: ResponsiveSize.width(22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
