import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/authentication/data/repo/auth.dart';
import 'package:sanad/features/onboarding/screens/onboarding_screen.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Landing screen shown on app start: plays the logo animation, then routes the user onward.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _continueAfterSplash();
  }

  // Waits for the intro animation, then decides where to go:
  // onboarding (first launch) -> role-based home -> role selection.
  Future<void> _continueAfterSplash() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    // The user may have left the screen during the delay; don't navigate with a dead context.
    if (!mounted) return;

    bool hasCompletedOnboarding = false;
    try {
      final preferences = await SharedPreferences.getInstance();
      if (!mounted) return;
      // Onboarding is shown only once; its completion flag lives in SharedPreferences.
      hasCompletedOnboarding =
          preferences.getBool(OnboardingScreen.completedKey) ?? false;
    } catch (_) {
      // Storage plugin failures must not leave the splash screen stuck.
      hasCompletedOnboarding = false;
    }
    if (!mounted) return;
    if (!hasCompletedOnboarding) {
      context.go('/onboarding');
      return;
    }

    // Role lookup can throw when there is no signed-in user, which we treat as no role.
    String? role;
    try {
      role = await Auth().currentUserRole();
    } catch (_) {
      // Supabase or network failures must not leave the splash screen stuck.
      // Treat them as no signed-in role and send the user to role selection.
      role = null;
    }
    if (!mounted) return;

    // Customers and providers have separate flows; anyone else picks a role first.
    context.go(switch (role) {
      'customer' => '/customer/management',
      'provider' => '/provider/dashboard',
      _ => '/role-selection',
    });
  }

  @override
  // Logo, app name, tagline and loader all fade/slide in one after another via staggered delays.
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.cremeyColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Falls back to an icon if the logo asset is missing.
            Image.asset(
                  'assets/images/Sanad house · Soft rise.png',
                  width: 84.w,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.home_repair_service_outlined,
                    color: AppThemes.greenColor,
                    size: 84.w,
                  ),
                )
                .animate()
                .fadeIn(duration: 2000.ms, curve: Curves.easeInOut)
                .slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 2000.ms,
                  curve: Curves.easeOutCubic,
                ),
            SizedBox(height: 24.h),
            // IntrinsicWidth makes the green underline exactly as wide as the app name.
            IntrinsicWidth(
              child:
                  Column(
                        spacing: 1,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.appName,
                            style: TextStyle(
                              fontSize: 64.sp,
                              height: 1.h,
                              fontWeight: FontWeight.bold,
                              color: AppThemes.greenColor,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 4.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.r),
                              color: AppThemes.greenColor,
                            ),
                          ),
                        ],
                      )
                      .animate(delay: 400.ms)
                      .fadeIn(duration: 1500.ms, curve: Curves.easeInOut)
                      .slideY(
                        begin: 0.15,
                        end: 0,
                        duration: 1500.ms,
                        curve: Curves.easeOutCubic,
                      ),
            ),
            SizedBox(height: 24.h),
            Text(
                  AppLocalizations.of(context)!.splashTagline,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: AppThemes.SplashText,
                  ),
                )
                .animate(delay: 900.ms)
                .fadeIn(duration: 1300.ms, curve: Curves.easeInOut)
                .slideY(
                  begin: 0.12,
                  end: 0,
                  duration: 1300.ms,
                  curve: Curves.easeOutCubic,
                ),
            SizedBox(height: 80.h),
            // Loading dots to show the app is still starting up.
            SpinKitThreeBounce(color: AppThemes.hiAccount, size: 14.sp)
                .animate(delay: 1400.ms)
                .fadeIn(duration: 1000.ms, curve: Curves.easeInOut),
            SizedBox(height: 12.h),
            Text(
                  AppLocalizations.of(context)!.splashFooter,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF8A8A8A),
                  ),
                )
                .animate(delay: 1800.ms)
                .fadeIn(duration: 1100.ms, curve: Curves.easeInOut)
                .slideY(
                  begin: 0.1,
                  end: 0,
                  duration: 1100.ms,
                  curve: Curves.easeOutCubic,
                ),
          ],
        ),
      ),
    );
  }
}
