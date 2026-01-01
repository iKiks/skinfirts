import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class SignupTermsNotice extends StatefulWidget {
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  const SignupTermsNotice({super.key, this.onTermsTap, this.onPrivacyTap});

  @override
  State<SignupTermsNotice> createState() => _SignupTermsNoticeState();
}

class _SignupTermsNoticeState extends State<SignupTermsNotice> {
  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()..onTap = widget.onTermsTap;
    _privacyRecognizer = TapGestureRecognizer()..onTap = widget.onPrivacyTap;
  }

  @override
  void didUpdateWidget(SignupTermsNotice oldWidget) {
    super.didUpdateWidget(oldWidget);
    _termsRecognizer.onTap = widget.onTermsTap;
    _privacyRecognizer.onTap = widget.onPrivacyTap;
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: AppColors.textSecondary,
      fontSize: ResponsiveSize.fontSize(12),
      height: 1.5,
    );
    final linkStyle = textStyle?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textStyle,
        children: [
          const TextSpan(text: 'By continuing, you agree to\n'),
          TextSpan(
            text: 'Terms of Use',
            style: linkStyle,
            recognizer: _termsRecognizer,
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy.',
            style: linkStyle,
            recognizer: _privacyRecognizer,
          ),
        ],
      ),
    );
  }
}
