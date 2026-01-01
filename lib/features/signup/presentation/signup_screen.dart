import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/home/presentation/homepage.dart';
import 'package:skinfirts/features/signup/presentation/widgets/signup_app_bar.dart';
import 'package:skinfirts/features/signup/presentation/widgets/signup_form.dart';
import 'package:skinfirts/features/signup/presentation/widgets/signup_social_options.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SignupAppBar(),
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
                    SignupForm(
                      onSubmit: (data) => _handleSubmit(context, data),
                    ),
                    const SignupSocialOptions(),
                    SizedBox(height: ResponsiveSize.height(32)),
                    const _LoginPrompt(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context, SignupFormData data) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomePage(userName: data.fullName)),
      (route) => false,
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  const _LoginPrompt();

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: ResponsiveSize.fontSize(13),
    );
    final linkStyle = baseStyle?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    );

    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'already have an account? ', style: baseStyle),
              TextSpan(text: 'Log in', style: linkStyle),
            ],
          ),
        ),
      ),
    );
  }
}
