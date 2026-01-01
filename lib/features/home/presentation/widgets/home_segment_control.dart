import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class HomeSegmentControl extends StatelessWidget {
  final int selectedIndex;
  final List<HomeSegmentItem> items;

  const HomeSegmentControl({
    super.key,
    required this.selectedIndex,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveSize.width(6)),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.45),
        borderRadius: BorderRadius.circular(ResponsiveSize.width(28)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < items.length; i++)
            _SegmentChip(
              item: items[i],
              selected: i == selectedIndex,
            ),
        ],
      ),
    );
  }
}

class HomeSegmentItem {
  final IconData icon;
  final String label;

  const HomeSegmentItem({required this.icon, required this.label});
}

class _SegmentChip extends StatelessWidget {
  final HomeSegmentItem item;
  final bool selected;

  const _SegmentChip({required this.item, required this.selected});

  @override
  Widget build(BuildContext context) {
    final selectedColor = AppColors.primary;
    final defaultColor = AppColors.primary.withOpacity(0.55);

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.width(12),
          vertical: ResponsiveSize.height(10),
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(ResponsiveSize.width(22)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: ResponsiveSize.width(18),
              color: selected ? selectedColor : defaultColor,
            ),
            SizedBox(height: ResponsiveSize.height(6)),
            Text(
              item.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: selected ? selectedColor : defaultColor,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: ResponsiveSize.fontSize(11),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
