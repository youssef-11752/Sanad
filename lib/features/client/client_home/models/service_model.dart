import 'package:material_ui/material_ui.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

// Service types offered on the home screen; used to look up the localized name.
enum HomeServiceCategory {
  painting,
  appliances,
  plumbing,
  carpentry,
  electrical,
  airConditioning,
}

/// A service tile on the home screen: its id, display title, category and icon.
class ServiceModel {
  final String id;
  final String title;
  final HomeServiceCategory category;
  final IconData icon;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
  });

  // The stored title is hard-coded Arabic; this returns the title in the current app language
  // based on the category, so search and display follow the user's locale.
  String localizedTitle(AppLocalizations localizations) => switch (category) {
    HomeServiceCategory.painting => localizations.paintingCategory,
    HomeServiceCategory.appliances => localizations.applianceCategory,
    HomeServiceCategory.plumbing => localizations.plumbingCategory,
    HomeServiceCategory.carpentry => localizations.carpentryCategory,
    HomeServiceCategory.electrical => localizations.electricalCategory,
    HomeServiceCategory.airConditioning =>
      localizations.airConditioningCategory,
  };
}
