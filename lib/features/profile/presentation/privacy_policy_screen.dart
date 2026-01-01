import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const _introParagraphs = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam. Fusce a scelerisque neque, sed accumsan metus.',
    'Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. Aenean arcu metus, bibendum at rhoncus at, volutpat et lacus. Morbi pellentesque malesuada eros semper ultrices. Vestibulum lobortis enim vel neque auctor, a ultrices ex placerat. Mauris ut lacinia justo, sed suscipit tortor. Nam egestas nulla posuere neque tincidunt porta.',
  ];

  static const _terms = [
    'Ut lacinia justo sit amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros est vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisl posuere risus, vel facilisis nisl tellus ac turpis.',
    'Ut lacinia justo sit amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros est vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisl posuere risus, vel facilisis nisl tellus.',
    'Lorem ipsum dolor sit amet, c nsectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.',
    'Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. Aenean arcu metus, bibendum at rhoncus at, volutpat et lacus. Morbi pellentesque malesuada eros semper ultrices. Vestibulum lobortis enim vel neque auctor, a ultrices ex placerat. Mauris ut lacinia justo, sed suscipit tortor. Nam egestas nulla posuere neque tincidunt porta.',
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
                'Last Update: 14/08/2024',
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
                style: titleStyle?.copyWith(fontSize: ResponsiveSize.fontSize(18)),
              ),
              SizedBox(height: ResponsiveSize.height(16)),
              ...List.generate(_terms.length, (index) {
                final itemNumber = index + 1;
                return Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveSize.height(14)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$itemNumber.',
                        style: subtitleStyle,
                      ),
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
