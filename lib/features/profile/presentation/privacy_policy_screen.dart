import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const _introParagraphs = [
    'Skinfirts helps you track skin routines, doctor appointments, and product insights. We collect only the personal details needed to personalise your experience, create secure accounts, and connect you with licensed dermatology professionals.',
    'Your profile data, appointment history, and routine notes stay encrypted and are never sold. We may use anonymised analytics to improve recommendations, but you can export or delete your information from the settings menu at any time.',
  ];

  static const _terms = [
    'You must provide accurate personal details when creating a Skinfirts account. This includes your name, contact information, and any dermatology notes you choose to store so practitioners can offer appropriate care.',
    'Appointment reminders, treatment plans, and progress photos you upload are stored securely. Do not share login credentials, and notify us immediately if you notice unauthorised activity.',
    'Product reviews and community posts should remain respectful and free of medical claims. We reserve the right to remove content that is harmful, promotional, or violates healthcare advertising guidelines.',
    'Deleting your account removes all personal data from our active systems within 30 days. We may retain anonymised analytics to improve services, but they cannot be linked back to you.',
  ];

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w700,
      fontSize: ResponsiveSize.fontSize(20),
    );
    final subtitleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
      fontSize: ResponsiveSize.fontSize(13),
    );
    final bodyStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      height: 1.6,
      fontSize: ResponsiveSize.fontSize(13),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primary,
            size: ResponsiveSize.width(18),
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text('Privacy Policy', style: titleStyle),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveSize.width(12)),
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: AppColors.primary,
                size: ResponsiveSize.width(20),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(24),
            vertical: ResponsiveSize.height(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last Update: 01/01/2026',
                style: subtitleStyle?.copyWith(
                  color: AppColors.primary.withOpacity(0.7),
                ),
              ),
              SizedBox(height: ResponsiveSize.height(20)),
              ..._introParagraphs.map(
                (paragraph) => Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveSize.height(16)),
                  child: Text(paragraph, style: bodyStyle),
                ),
              ),
              SizedBox(height: ResponsiveSize.height(10)),
              Text(
                'Terms & Conditions',
                style: titleStyle?.copyWith(
                  fontSize: ResponsiveSize.fontSize(18),
                ),
              ),
              SizedBox(height: ResponsiveSize.height(16)),
              ...List.generate(_terms.length, (index) {
                final itemNumber = index + 1;
                return Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveSize.height(14)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$itemNumber.', style: subtitleStyle),
                      SizedBox(width: ResponsiveSize.width(12)),
                      Expanded(child: Text(_terms[index], style: bodyStyle)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
