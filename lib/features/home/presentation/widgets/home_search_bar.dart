import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final hintStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary.withOpacity(0.6),
          fontSize: ResponsiveSize.fontSize(13),
        );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(20),
        vertical: ResponsiveSize.height(14),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveSize.width(26)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: AppColors.primary.withOpacity(0.75),
            size: ResponsiveSize.width(20),
          ),
          SizedBox(width: ResponsiveSize.width(12)),
          Expanded(
            child: Text('Search for doctors, symptoms...', style: hintStyle),
          ),
          Icon(
            Icons.tune,
            color: AppColors.primary,
            size: ResponsiveSize.width(20),
          ),
        ],
      ),
    );
  }
}
