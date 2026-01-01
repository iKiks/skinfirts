import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class HomeDoctorCard extends StatelessWidget {
  final HomeDoctor doctor;

  const HomeDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final nameStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: ResponsiveSize.fontSize(16),
        );
    final specialtyStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
          fontSize: ResponsiveSize.fontSize(12),
        );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(16),
        vertical: ResponsiveSize.height(14),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveSize.width(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: ResponsiveSize.width(24),
            backgroundColor: AppColors.secondary,
            backgroundImage: doctor.photoAsset != null
                ? AssetImage(doctor.photoAsset!)
                : null,
            child: doctor.photoAsset == null
                ? Icon(
                    Icons.person,
                    size: ResponsiveSize.width(24),
                    color: AppColors.primary,
                  )
                : null,
          ),
          SizedBox(width: ResponsiveSize.width(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.name, style: nameStyle),
                SizedBox(height: ResponsiveSize.height(6)),
                Text(doctor.specialty, style: specialtyStyle),
                SizedBox(height: ResponsiveSize.height(12)),
                Row(
                  children: [
                    _InfoPill(
                      icon: Icons.star,
                      value: doctor.rating,
                    ),
                    SizedBox(width: ResponsiveSize.width(10)),
                    _InfoPill(
                      icon: Icons.person,
                      value: doctor.patients,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ActionCircle(
                icon: Icons.chat_bubble_outline,
                highlighted: false,
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              _ActionCircle(
                icon:
                    doctor.favorited ? Icons.favorite : Icons.favorite_border,
                highlighted: doctor.favorited,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCircle extends StatelessWidget {
  final IconData icon;
  final bool highlighted;

  const _ActionCircle({required this.icon, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveSize.width(36),
      height: ResponsiveSize.width(36),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.primary : AppColors.secondary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: highlighted ? AppColors.white : AppColors.primary,
        size: ResponsiveSize.width(18),
      ),
    );
  }
}

class HomeDoctor {
  final String name;
  final String specialty;
  final String rating;
  final String patients;
  final bool favorited;
  final String? photoAsset;

  const HomeDoctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.patients,
    this.favorited = false,
    this.photoAsset,
  });
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoPill({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(10),
        vertical: ResponsiveSize.height(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.6),
        borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: ResponsiveSize.width(14),
            color: AppColors.primary,
          ),
          SizedBox(width: ResponsiveSize.width(6)),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: ResponsiveSize.fontSize(11),
                ),
          ),
        ],
      ),
    );
  }
}
