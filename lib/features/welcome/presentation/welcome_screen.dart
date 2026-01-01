import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/login/presentation/login_screen.dart';
import 'package:skinfirts/features/signup/presentation/signup_screen.dart';
import 'package:skinfirts/features/welcome/presentation/widgets/welcome_cta_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = _titleStyle(context);
    final subtitleStyle = _subtitleStyle(context);
    final bodyStyle = _bodyStyle(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(28)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: ResponsiveSize.height(150)),
                _buildHeroSection(titleStyle, subtitleStyle),
                SizedBox(height: ResponsiveSize.height(32)),
                Text(
                  'Personalized dermatology care that listens to your skin and designs a glow-up plan built just for you.',
                  textAlign: TextAlign.center,
                  style: bodyStyle,
                ),
                const Spacer(),
                WelcomeCtaButton(
                  label: 'Log In',
                  background: AppColors.primary,
                  foreground: AppColors.white,
                  onTap: () => _openLogin(context),
                ),
                SizedBox(height: ResponsiveSize.height(14)),
                WelcomeCtaButton(
                  label: 'Sign Up',
                  background: AppColors.secondary,
                  foreground: AppColors.primary,
                  onTap: () => _openSignup(context),
                ),
                SizedBox(height: ResponsiveSize.height(65)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openLogin(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 380),
        pageBuilder: (_, animation, _) => const LoginScreen(),
        transitionsBuilder: (_, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.06),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _openSignup(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 380),
        pageBuilder: (_, animation, _) => const SignupScreen(),
        transitionsBuilder: (_, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.06),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(TextStyle title, TextStyle subtitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/logo_blue.png', width: ResponsiveSize.width(164)),
        SizedBox(height: ResponsiveSize.height(20)),
        Text('Skin', style: title),
        Text('Firts', style: title),
        SizedBox(height: ResponsiveSize.height(10)),
        Text('Dermatology Center', style: subtitle),
      ],
    );
  }

  TextStyle _titleStyle(BuildContext context) {
    final base =
        Theme.of(context).textTheme.displaySmall ??
        const TextStyle(fontSize: 36, fontWeight: FontWeight.w400);
    return base.copyWith(
      color: AppColors.primary,
      fontSize: ResponsiveSize.fontSize(36),
      fontWeight: FontWeight.w400,
      letterSpacing: 1.15,
    );
  }

  TextStyle _subtitleStyle(BuildContext context) {
    final base =
        Theme.of(context).textTheme.labelLarge ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    return base.copyWith(
      color: AppColors.primary,
      fontSize: ResponsiveSize.fontSize(14),
      letterSpacing: 0.6,
    );
  }

  TextStyle _bodyStyle(BuildContext context) {
    final base =
        Theme.of(context).textTheme.bodyMedium ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
    return base.copyWith(
      color: AppColors.textSecondary,
      fontSize: ResponsiveSize.fontSize(13),
      height: 1.45,
      letterSpacing: 0.15,
    );
  }
}
