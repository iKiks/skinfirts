import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/home/presentation/homepage.dart';
import 'package:skinfirts/features/login/presentation/widgets/login_app_bar.dart';
import 'package:skinfirts/features/login/presentation/widgets/login_form.dart';
import 'package:skinfirts/features/login/presentation/widgets/login_header.dart';
import 'package:skinfirts/features/login/presentation/widgets/login_social_options.dart';
import 'package:skinfirts/features/signup/presentation/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const LoginAppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(28),
                vertical: ResponsiveSize.height(28),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveSize.height(10)),
                    const LoginHeader(),
                    SizedBox(height: ResponsiveSize.height(32)),
                    LoginForm(
                      onSubmit: (identifier, password) =>
                          _handleSubmit(context, identifier, password),
                    ),
                    const LoginSocialOptions(),
                    SizedBox(height: ResponsiveSize.height(32)),
                    _SignUpPrompt(onTap: () => _openSignup(context)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context, String identifier, String password) {
    final displayName = identifier.contains('@')
        ? identifier.split('@').first
        : identifier;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomePage(userName: displayName.trim())),
      (route) => false,
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
}

class _SignUpPrompt extends StatelessWidget {
  final VoidCallback onTap;

  const _SignUpPrompt({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: ResponsiveSize.fontSize(13),
    );
    final highlightStyle = baseStyle?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    );

    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "Don't have an account? ", style: baseStyle),
              TextSpan(text: 'Sign Up', style: highlightStyle),
            ],
          ),
        ),
      ),
    );
  }
}
