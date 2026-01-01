import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class HomeDateSelector extends StatelessWidget {
  final int selectedIndex;
  final List<HomeDateItem> items;

  const HomeDateSelector({
    super.key,
    required this.selectedIndex,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.height(90),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: ResponsiveSize.width(10)),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = index == selectedIndex;
          return _DateCard(item: item, selected: isSelected);
        },
      ),
    );
  }
}

class HomeDateItem {
  final String dayLabel;
  final String dateLabel;

  const HomeDateItem({required this.dayLabel, required this.dateLabel});
}

class _DateCard extends StatelessWidget {
  final HomeDateItem item;
  final bool selected;

  const _DateCard({required this.item, required this.selected});

  @override
  Widget build(BuildContext context) {
    final baseColor = selected ? AppColors.primary : AppColors.white;
    final textColor = selected ? AppColors.white : AppColors.textPrimary;
    final dayColor = selected ? AppColors.white : AppColors.textSecondary;

    return Container(
      width: ResponsiveSize.width(45),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(ResponsiveSize.width(18)),
        border: selected
            ? null
            : Border.all(color: AppColors.secondary.withOpacity(0.8)),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveSize.height(12),
        horizontal: ResponsiveSize.width(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.dayLabel.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: dayColor,
              fontSize: ResponsiveSize.fontSize(11),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: ResponsiveSize.height(12)),
          Text(
            item.dateLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: ResponsiveSize.fontSize(18),
            ),
          ),
        ],
      ),
    );
  }
}
