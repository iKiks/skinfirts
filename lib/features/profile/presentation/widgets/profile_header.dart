import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String? avatarAsset;
  final String? subtitle;
  final ImageProvider<Object>? avatarImage;

  const ProfileHeader({
    super.key,
    required this.name,
    this.avatarAsset,
    this.subtitle,
    this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: ResponsiveSize.fontSize(18),
        );

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: ResponsiveSize.width(48),
              backgroundColor: AppColors.secondary.withOpacity(0.6),
              backgroundImage: avatarImage ??
                  (avatarAsset != null ? AssetImage(avatarAsset!) : null),
              child: avatarImage == null && avatarAsset == null
                  ? Icon(
                      Icons.person,
                      size: ResponsiveSize.width(42),
                      color: AppColors.primary,
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: -ResponsiveSize.width(4),
              child: Container(
                width: ResponsiveSize.width(28),
                height: ResponsiveSize.width(28),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
                child: Icon(
                  Icons.edit,
                  size: ResponsiveSize.width(14),
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveSize.height(12)),
        Text(name, style: titleStyle),
        if (subtitle != null) ...[
          SizedBox(height: ResponsiveSize.height(6)),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: ResponsiveSize.fontSize(13),
                ),
          ),
        ],
      ],
    );
  }
}
