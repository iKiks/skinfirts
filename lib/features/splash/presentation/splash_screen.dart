import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/splash/presentation/painters/halo_painter.dart';
import 'package:skinfirts/features/splash/presentation/painters/morphing_wave_painter.dart';
import 'package:skinfirts/features/splash/presentation/widgets/cascade_text.dart';
import 'package:skinfirts/features/splash/presentation/widgets/corner_glows.dart';
import 'package:skinfirts/features/splash/presentation/widgets/floating_orb.dart';
import 'package:skinfirts/features/splash/presentation/widgets/shimmer_text.dart';
import 'package:skinfirts/features/welcome/presentation/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _backgroundController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 5200),
  )..repeat(reverse: true);

  late final AnimationController _introController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..forward();

  late final AnimationController _pulseController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
    lowerBound: 0.0,
    upperBound: 1.0,
  )..repeat(reverse: true);
  bool _didNavigate = false;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _backgroundController;
    _introController;
    _pulseController;
    _introController.addStatusListener(_handleIntroStatus);
  }

  @override
  void dispose() {
    _introController.removeStatusListener(_handleIntroStatus);
    _navigationTimer?.cancel();
    _backgroundController.dispose();
    _introController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = _titleStyle(context);
    final subtitleStyle = _subtitleStyle(context);
    final heroSize = ResponsiveSize.width(240);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _blend(AppColors.primary, Colors.black, 0.1),
                      AppColors.primary,
                      _blend(AppColors.primary, Colors.white, 0.12),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _backgroundController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: SplashMorphingWavePainter(
                      progress: _backgroundController.value,
                      baseColor: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: SplashCornerGlows(animation: _backgroundController),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveSize.height(48)),
                Align(
                  alignment: const Alignment(0, -0.08),
                  child: SizedBox(
                    width: heroSize,
                    height: heroSize,
                    child: AnimatedBuilder(
                      animation: _backgroundController,
                      builder: (context, _) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: Size(heroSize, heroSize),
                              painter: SplashHaloPainter(
                                progress: _backgroundController.value,
                              ),
                            ),
                            SplashFloatingOrb(
                              animation: _backgroundController,
                              radius: heroSize * 0.42,
                              size: ResponsiveSize.width(34),
                              phaseOffset: 0.0,
                              verticalBias: 0.72,
                              color: AppColors.white.withAlpha(61),
                            ),
                            SplashFloatingOrb(
                              animation: _backgroundController,
                              radius: heroSize * 0.36,
                              size: ResponsiveSize.width(26),
                              phaseOffset: math.pi * 0.55,
                              verticalBias: -0.65,
                              color: AppColors.white.withAlpha(46),
                            ),
                            SplashFloatingOrb(
                              animation: _backgroundController,
                              radius: heroSize * 0.48,
                              size: ResponsiveSize.width(18),
                              phaseOffset: math.pi * 1.2,
                              verticalBias: 0.5,
                              color: AppColors.white.withAlpha(51),
                            ),
                            AnimatedBuilder(
                              animation: _backgroundController,
                              builder: (context, _) {
                                final tilt =
                                    math.sin(
                                      _backgroundController.value * math.pi * 2,
                                    ) *
                                    0.04;
                                return AnimatedBuilder(
                                  animation: _pulseController,
                                  builder: (context, child) {
                                    final pulse = math.sin(
                                      _pulseController.value * math.pi,
                                    );
                                    final scale = 0.94 + pulse * 0.08;
                                    return Transform.rotate(
                                      angle: tilt,
                                      child: Transform.scale(
                                        scale: scale,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.white
                                                    .withAlpha(
                                                      ((0.16 + pulse * 0.12) *
                                                              255)
                                                          .toInt(),
                                                    ),
                                                blurRadius: 40,
                                                spreadRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: child!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/logo.png',
                                    width: ResponsiveSize.width(132),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveSize.height(56)),
                SplashCascadeText(
                  text: 'Skin',
                  style: titleStyle,
                  animation: _introController,
                  startDelay: 0.05,
                ),
                SplashCascadeText(
                  text: 'Firts',
                  style: titleStyle,
                  animation: _introController,
                  startDelay: 0.22,
                ),
                SizedBox(height: ResponsiveSize.height(14)),
                AnimatedBuilder(
                  animation: _introController,
                  builder: (context, child) {
                    final curved = CurvedAnimation(
                      parent: _introController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                    );
                    final opacity = curved.value;
                    final offset = (1.0 - opacity) * ResponsiveSize.height(18);
                    return Opacity(
                      opacity: opacity,
                      child: Transform.translate(
                        offset: Offset(0, offset),
                        child: child!,
                      ),
                    );
                  },
                  child: SplashShimmerText(
                    text: 'Dermatology Center',
                    style: subtitleStyle,
                    shimmerColor: AppColors.white,
                  ),
                ),
                SizedBox(height: ResponsiveSize.height(32)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleIntroStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _navigationTimer?.cancel();
      _navigationTimer = Timer(const Duration(seconds: 5), _scheduleNavigation);
    }
  }

  void _scheduleNavigation() {
    if (_didNavigate || !mounted) {
      return;
    }
    _navigationTimer?.cancel();
    _navigationTimer = null;
    _didNavigate = true;
    Navigator.of(context).pushReplacement(_buildWelcomeRoute());
  }

  PageRouteBuilder<void> _buildWelcomeRoute() {
    return PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 650),
      reverseTransitionDuration: const Duration(milliseconds: 650),
      pageBuilder: (_, animation, _) => const WelcomeScreen(),
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
    );
  }

  TextStyle _titleStyle(BuildContext context) {
    final base =
        Theme.of(context).textTheme.displaySmall ??
        const TextStyle(fontSize: 36, fontWeight: FontWeight.w300);
    return base.copyWith(
      color: AppColors.white,
      fontSize: ResponsiveSize.fontSize(38),
      fontWeight: FontWeight.w300,
      letterSpacing: 1.24,
    );
  }

  TextStyle _subtitleStyle(BuildContext context) {
    final base =
        Theme.of(context).textTheme.labelLarge ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
    return base.copyWith(
      color: AppColors.white.withAlpha(230),
      fontSize: ResponsiveSize.fontSize(15),
      letterSpacing: 0.68,
    );
  }

  static Color _blend(Color a, Color b, double t) {
    return Color.lerp(a, b, t) ?? a;
  }
}
