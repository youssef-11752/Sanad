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
  String currentRequestsTab(int count) {
    return 'Current ($count)';
  }

  @override
  String pastRequestsTab(int count) {
    return 'Previous ($count)';
  }

  @override
  String get noCurrentOrders => 'No current orders.';

  @override
  String get noPreviousOrders => 'No previous orders.';

  @override
  String get ordersLoadError => 'Couldn\'t load your orders.';

  @override
  String get retryButton => 'Retry';

  @override
  String get currentOrdersSection => 'Current requests';

  @override
  String get pastVisitsSection => 'Your previous visits';

  @override
  String get pendingStatus => 'Pending';

  @override
  String get fulfilledStatus => 'Fulfilled';

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
