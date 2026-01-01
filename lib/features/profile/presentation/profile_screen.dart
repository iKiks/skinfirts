import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/home/presentation/homepage.dart';
import 'package:skinfirts/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:skinfirts/features/profile/presentation/profile_details_screen.dart';
import 'package:skinfirts/features/profile/presentation/privacy_policy_screen.dart';
import 'package:skinfirts/features/profile/presentation/widgets/profile_header.dart';
import 'package:skinfirts/features/profile/presentation/widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static final _options = [
    _ProfileOption(
      icon: Icons.person_outline,
      label: 'Profile',
      onTap: (context) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const ProfileDetailsScreen()),
        );
      },
    ),
    _ProfileOption(icon: Icons.favorite_border, label: 'Favorite'),
    _ProfileOption(
      icon: Icons.account_balance_wallet_outlined,
      label: 'Payment Method',
    ),
    _ProfileOption(
      icon: Icons.lock_outline,
      label: 'Privacy Policy',
      onTap: (context) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const PrivacyPolicyScreen(),
          ),
        );
      },
    ),
    _ProfileOption(icon: Icons.settings_outlined, label: 'Settings'),
    _ProfileOption(icon: Icons.help_outline, label: 'Help'),
    _ProfileOption(
      icon: Icons.logout,
      label: 'Logout',
      iconColor: AppColors.error,
      iconBackgroundColor: AppColors.error.withOpacity(0.12),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primary,
            size: ResponsiveSize.width(18),
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'My Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: ResponsiveSize.fontSize(20),
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(24),
            vertical: ResponsiveSize.height(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileHeader(name: 'John Doe', subtitle: 'Skincare Enthusiast'),
              SizedBox(height: ResponsiveSize.height(28)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(12),
                  vertical: ResponsiveSize.height(12),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(ResponsiveSize.width(24)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(_options.length, (index) {
                    final option = _options[index];
                    final isLast = index == _options.length - 1;
                    return ProfileOptionTile(
                      icon: option.icon,
                      label: option.label,
                      onTap: () => option.onTap?.call(context),
                      showDivider: !isLast,
                      iconColor: option.iconColor,
                      iconBackgroundColor: option.iconBackgroundColor,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: 2,
        onItemSelected: (index) {
          if (index == 0) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(builder: (_) => const HomePage()),
              );
            }
          }
        },
      ),
    );
  }
}

class _ProfileOption {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final void Function(BuildContext context)? onTap;

  const _ProfileOption({
    required this.icon,
    required this.label,
    this.iconColor,
    this.iconBackgroundColor,
    this.onTap,
  });
}
