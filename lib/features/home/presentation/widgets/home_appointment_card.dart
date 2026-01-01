import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class HomeAppointmentCard extends StatelessWidget {
  final HomeAppointment appointment;

  const HomeAppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final doctorStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: ResponsiveSize.fontSize(16),
        );
    final descStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
          fontSize: ResponsiveSize.fontSize(12),
          height: 1.4,
        );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.6),
        borderRadius: BorderRadius.circular(ResponsiveSize.width(22)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(16),
        vertical: ResponsiveSize.height(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: appointment.slots
                .map(
                  (slot) => Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveSize.height(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: ResponsiveSize.width(8),
                          height: ResponsiveSize.width(8),
                          decoration: BoxDecoration(
                            color: slot.highlight
                                ? AppColors.primary
                                : AppColors.white,
                            border: Border.all(
                              color: slot.highlight
                                  ? AppColors.primary
                                  : AppColors.primary.withOpacity(0.4),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: ResponsiveSize.width(8)),
                        Text(
                          slot.time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: slot.highlight
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                fontWeight: slot.highlight
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: ResponsiveSize.fontSize(12),
                              ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(width: ResponsiveSize.width(16)),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(ResponsiveSize.width(20)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.18),
                    blurRadius: 26,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(18),
                vertical: ResponsiveSize.height(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveSize.width(12),
                          vertical: ResponsiveSize.height(6),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.8),
                          borderRadius:
                              BorderRadius.circular(ResponsiveSize.width(16)),
                        ),
                        child: Text(
                          appointment.dateRangeLabel,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.primary,
                                fontSize: ResponsiveSize.fontSize(11),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.push_pin,
                        color: AppColors.primary,
                        size: ResponsiveSize.width(18),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveSize.height(18)),
                  Text(appointment.title, style: doctorStyle),
                  SizedBox(height: ResponsiveSize.height(10)),
                  Text(appointment.description, style: descStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAppointment {
  final String dateRangeLabel;
  final String title;
  final String description;
  final List<HomeAppointmentSlot> slots;

  const HomeAppointment({
    required this.dateRangeLabel,
    required this.title,
    required this.description,
    required this.slots,
  });
}

class HomeAppointmentSlot {
  final String time;
  final bool highlight;

  const HomeAppointmentSlot({required this.time, this.highlight = false});
}
