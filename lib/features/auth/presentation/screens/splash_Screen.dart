import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/presentation/auth_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) context.go('/role-selection');
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return Scaffold(
      backgroundColor: AppThemes.cremeyColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 92,
                width: 92,
                decoration: BoxDecoration(
                  color: AppThemes.redColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.home_repair_service_outlined,
                  color: AppThemes.whiteColor,
                  size: 54,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                strings.appName,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: AppThemes.greenColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                strings.splashTagline,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppThemes.splashText,
                ),
              ),
              const SizedBox(height: 56),
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppThemes.greenColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(strings.splashFooter),
            ],
          ),
        ),
      ),
    );
  }
}
