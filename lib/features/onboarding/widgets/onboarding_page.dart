import 'package:flutter/material.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/onboarding/models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height * 0.42,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 220,
              width: 220,
              decoration: const BoxDecoration(
                color: AppThemes.privacyColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                model.icon,
                size: 100,
                color: AppThemes.redColor,
              ),
            ),
            const SizedBox(height: 35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 220),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppThemes.darkCremey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      model.badge,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppThemes.darkGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  model.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppThemes.greenColor,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  model.description,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.7,
                    color: AppThemes.hiAccount,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
