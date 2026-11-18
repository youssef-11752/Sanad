import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:sanad/features/authentication/data/repo/auth.dart';
import 'package:sanad/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () async {
      if (!mounted) return;
      var loggedIn = false;
      try {
        loggedIn = Supabase.instance.client.auth.currentSession != null;
      } on AssertionError {
        // The splash can also be previewed before Supabase is initialized.
      }
      if (!loggedIn) {
        final preferences = await SharedPreferences.getInstance();
        if (!mounted) return;
        final hasCompletedOnboarding =
            preferences.getBool(OnboardingScreen.completedKey) ?? false;
        context.go(hasCompletedOnboarding ? '/login/customer' : '/onboarding');
        return;
      }
      final role = await Auth().currentUserRole();
      if (!mounted) return;
      context.go(
        role == 'provider' ? '/provider/dashboard' : '/customer/management',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.cremeyColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                          'assets/icons/Sanad house · Soft rise.png',
                          width: 84.w,
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
                              .fadeIn(
                                duration: 1500.ms,
                                curve: Curves.easeInOut,
                              )
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
                            color: AppThemes.splashText,
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
            ),
          ),
        ),
      ),
    );
  }
}
