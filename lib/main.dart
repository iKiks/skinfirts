import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'core/utils/responsiveness/app_responsiveness.dart';
import 'features/splash/presentation/splash_screen.dart';

void main() {
  runApp(const SkinfirtsApp());
}

class SkinfirtsApp extends StatelessWidget {
  const SkinfirtsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skinfirts',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      builder: (context, child) {
        ResponsiveSize.init(context);
        return child ?? const SizedBox.shrink();
      },
      home: const SplashScreen(),
    );
  }
}
