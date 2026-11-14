
  import 'package:animated_splash_screen/animated_splash_screen.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_animate/flutter_animate.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_spinkit/flutter_spinkit.dart';
  import 'package:page_transition/page_transition.dart';
  import 'package:sanad/core/theme/colors.dart';
  import 'package:sanad/features/auth/presentation/screens/login_User_screen.dart';
  import 'package:sanad/l10n/generated/app_localizations.dart';

  class SplashScreen extends StatelessWidget {
    const SplashScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return AnimatedSplashScreen(
        duration: 4000,
        animationDuration: const Duration(milliseconds: 700),
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: AppThemes.cremeyColor,
        splashIconSize: 600,
        nextScreen: const LoginUserScreen(),

        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // image
            Image.asset(
              'assets/images/Sanad house · Soft rise.png',
              width: 84.w,
            )
                .animate()
                .fadeIn(
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                )
                .slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 2000.ms,
                  curve: Curves.easeOutCubic,
                ),

            SizedBox(height: 24.h),

            // Sanad Text
            IntrinsicWidth(
              child: Column(
                spacing: 1,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!.appName,
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

            // Main Sentince
            Text(AppLocalizations.of(context)!.splashTagline,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: AppThemes.SplashText,
              ),
            )
                .animate(delay: 900.ms)
                .fadeIn(
                  duration: 1300.ms,
                  curve: Curves.easeInOut,
                )
                .slideY(
                  begin: 0.12,
                  end: 0,
                  duration: 1300.ms,
                  curve: Curves.easeOutCubic,
                ),

            SizedBox(height: 80.h),

            // Loading 
            SpinKitThreeBounce(
              color: AppThemes.hiAccount,
              size: 14.sp,
            )
                .animate(delay: 1400.ms)
                .fadeIn(
                  duration: 1000.ms,
                  curve: Curves.easeInOut,
                ),

            SizedBox(height: 12.h),

            // Final Sentince
            Text(AppLocalizations.of(context)!.splashFooter,
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF8A8A8A),
              ),
            )
                .animate(delay: 1800.ms)
                .fadeIn(
                  duration: 1100.ms,
                  curve: Curves.easeInOut,
                )
                .slideY(
                  begin: 0.1,
                  end: 0,
                  duration: 1100.ms,
                  curve: Curves.easeOutCubic,
                ),
          ],
        ),
      );
    }
  }
