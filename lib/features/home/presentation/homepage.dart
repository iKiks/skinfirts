import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/home/presentation/widgets/home_appointment_card.dart';
import 'package:skinfirts/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:skinfirts/features/home/presentation/widgets/home_date_selector.dart';
import 'package:skinfirts/features/home/presentation/widgets/home_doctor_card.dart';
import 'package:skinfirts/features/home/presentation/widgets/home_header.dart';
import 'package:skinfirts/features/home/presentation/widgets/home_search_bar.dart';
import 'package:skinfirts/features/home/presentation/widgets/home_segment_control.dart';
import 'package:skinfirts/features/profile/presentation/profile_screen.dart';

class HomePage extends StatelessWidget {
  final String? userName;

  const HomePage({super.key, this.userName});

  static const _segments = [
    HomeSegmentItem(icon: Icons.medical_services_outlined, label: 'Doctors'),
    HomeSegmentItem(icon: Icons.favorite_border, label: 'Favorite'),
    HomeSegmentItem(icon: Icons.tune, label: 'Filters'),
  ];

  static const _dateItems = [
    HomeDateItem(dayLabel: 'Mon', dateLabel: '9'),
    HomeDateItem(dayLabel: 'Tue', dateLabel: '10'),
    HomeDateItem(dayLabel: 'Wed', dateLabel: '11'),
    HomeDateItem(dayLabel: 'Thu', dateLabel: '12'),
    HomeDateItem(dayLabel: 'Fri', dateLabel: '13'),
    HomeDateItem(dayLabel: 'Sat', dateLabel: '14'),
  ];

  static const _appointment = HomeAppointment(
    dateRangeLabel: '11 Wednesday - Today',
    title: 'Dr. Olivia Turner, M.D.',
    description: 'Treatment and prevention of skin and photodermatitis.',
    slots: [
      HomeAppointmentSlot(time: '9 AM'),
      HomeAppointmentSlot(time: '10 AM', highlight: true),
      HomeAppointmentSlot(time: '11 AM'),
      HomeAppointmentSlot(time: '12 AM'),
    ],
  );

  static const _doctors = [
    HomeDoctor(
      name: 'Dr. Olivia Turner, M.D.',
      specialty: 'Dermato-Endocrinology',
      rating: '5',
      patients: '60',
      favorited: true,
    ),
    HomeDoctor(
      name: 'Dr. Alexander Bennett, Ph.D.',
      specialty: 'Dermato-Genetics',
      rating: '4.5',
      patients: '40',
    ),
    HomeDoctor(
      name: 'Dr. Sophia Martinez, Ph.D.',
      specialty: 'Cosmetic Bioengineering',
      rating: '5',
      patients: '150',
      favorited: true,
    ),
    HomeDoctor(
      name: 'Dr. Michael Davidson, M.D.',
      specialty: 'Nano-Dermatology',
      rating: '4.8',
      patients: '90',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final displayName = userName?.trim();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: ResponsiveSize.height(240),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.background,
                      AppColors.secondary.withOpacity(0.65),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveSize.width(24),
                      vertical: ResponsiveSize.height(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(userName: displayName),
                        SizedBox(height: ResponsiveSize.height(24)),
                        HomeSegmentControl(selectedIndex: 0, items: _segments),
                        SizedBox(height: ResponsiveSize.height(18)),
                        const HomeSearchBar(),
                        SizedBox(height: ResponsiveSize.height(24)),
                        HomeDateSelector(selectedIndex: 2, items: _dateItems),
                        SizedBox(height: ResponsiveSize.height(24)),
                        HomeAppointmentCard(appointment: _appointment),
                        SizedBox(height: ResponsiveSize.height(28)),
                        Text(
                          'Top Doctors',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: ResponsiveSize.fontSize(16),
                              ),
                        ),
                        SizedBox(height: ResponsiveSize.height(18)),
                        ..._doctors
                            .map(
                              (doctor) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: ResponsiveSize.height(16),
                                ),
                                child: HomeDoctorCard(doctor: doctor),
                              ),
                            )
                            .toList(),
                        SizedBox(height: ResponsiveSize.height(80)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: 0,
        onItemSelected: (index) {
          if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
