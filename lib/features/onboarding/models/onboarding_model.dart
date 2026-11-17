import 'package:material_ui/material_ui.dart';

/// Content of one onboarding slide.
class OnboardingModel {
  final String title;
  final String description;
  final IconData icon;
  final String badge;

  const OnboardingModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.badge,
  });
}
