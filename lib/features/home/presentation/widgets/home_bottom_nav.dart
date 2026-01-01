import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class HomeBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;

  const HomeBottomNav({
    super.key,
    required this.selectedIndex,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_BottomItem>[
      const _BottomItem(icon: Icons.home_rounded),
      const _BottomItem(icon: Icons.chat_bubble_outline_rounded),
      const _BottomItem(icon: Icons.person_outline_rounded),
      const _BottomItem(icon: Icons.calendar_today_rounded),
    ];

    return SafeArea(
      minimum: EdgeInsets.only(
        left: ResponsiveSize.width(22),
        right: ResponsiveSize.width(22),
        bottom: ResponsiveSize.height(12),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.width(18),
          vertical: ResponsiveSize.height(14),
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(ResponsiveSize.width(32)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < items.length; i++)
              _BottomNavButton(
                item: items[i],
                selected: i == selectedIndex,
                onTap:
                    i == selectedIndex ? null : () => onItemSelected?.call(i),
              ),
          ],
        ),
      ),
    );
  }
}

class _BottomItem {
  final IconData icon;

  const _BottomItem({required this.icon});
}

class _BottomNavButton extends StatelessWidget {
  final _BottomItem item;
  final bool selected;
  final VoidCallback? onTap;

  const _BottomNavButton({
    required this.item,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: ResponsiveSize.width(50),
      height: ResponsiveSize.height(46),
      decoration: BoxDecoration(
        color: selected ? AppColors.white : AppColors.primary,
        borderRadius: BorderRadius.circular(ResponsiveSize.width(20)),
      ),
      child: Icon(
        item.icon,
        color: selected ? AppColors.primary : AppColors.white,
        size: ResponsiveSize.width(22),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}
