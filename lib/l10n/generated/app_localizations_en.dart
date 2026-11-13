// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sanad';

  @override
  String get homeTitle => 'Sanad home';

  @override
  String get counterMessage => 'You have pushed the button this many times:';

  @override
  String get increment => 'Increment';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get requestsTitle => 'My requests';

  @override
  String get requestsSubtitle =>
      'All your requests and appointments in one place';

  @override
  String get currentRequestsTab => 'Current (1)';

  @override
  String get pastRequestsTab => 'Previous (3)';

  @override
  String get currentOrdersSection => 'Current requests';

  @override
  String get pastVisitsSection => 'Your previous visits';

  @override
  String get scheduledVisitStatus => 'Visit scheduled';

  @override
  String get currentServiceTitle => 'Automatic washing machine repair';

  @override
  String get currentProviderInfo => 'Ahmed Sayed • Nasr City';

  @override
  String get currentVisitDate => 'Sunday, November 7 • 1–2 PM';

  @override
  String trackRequestButton(String requestId) {
    return 'Track $requestId';
  }

  @override
  String trackRequestComingSoon(String requestId) {
    return 'Details for request $requestId are coming soon';
  }

  @override
  String get completedStatus => 'Completed';

  @override
  String get completedRatedStatus => 'Completed and rated';

  @override
  String get cancelledStatus => 'Cancelled';

  @override
  String get pastRepairTitle => 'Kitchen sink leak repair';

  @override
  String get pastRepairProvider => 'Hossam Adel • Maadi';

  @override
  String get pastRepairDate => 'October 28, 2026 • 4:30 PM';

  @override
  String get pastFridgeTitle => 'Refrigerator maintenance';

  @override
  String get pastFridgeProvider => 'Ahmed Sayed • Nasr City';

  @override
  String get pastFridgeDate => 'September 15, 2026 • 3 PM';

  @override
  String get pastLightTitle => 'Light fixture installation';

  @override
  String get pastLightProvider => 'Ibrahim • Nasr City';

  @override
  String get pastLightDate => 'September 1, 2026';

  @override
  String get newRequestButton => 'Request a new service';

  @override
  String get newRequestComingSoon => 'New request creation is coming soon';

  @override
  String get homeNavigation => 'Home';

  @override
  String get categoriesNavigation => 'Categories';

  @override
  String get myRequestsNavigation => 'My requests';

  @override
  String get accountNavigation => 'Account';
}
