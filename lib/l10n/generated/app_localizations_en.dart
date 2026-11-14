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

  @override
  String get categoriesTitle => 'All categories';

  @override
  String get categoriesSubtitle => 'Choose the service you need';

  @override
  String get homeServicesLabel => 'Home services';

  @override
  String get categoriesSearchHint => 'Search for a service or issue';

  @override
  String get categoriesNoResults => 'No categories match your search';

  @override
  String get navigationComingSoon => 'This section is coming soon';

  @override
  String categoryComingSoon(String category) {
    return '$category services are coming soon';
  }

  @override
  String get applianceCategory => 'Home appliance maintenance';

  @override
  String get applianceCategoryDescription =>
      'Repair and maintenance for home appliances';

  @override
  String get paintingCategory => 'Painting';

  @override
  String get paintingCategoryDescription =>
      'Painting, decor, and wall renovations';

  @override
  String get carpentryCategory => 'Carpentry';

  @override
  String get carpentryCategoryDescription =>
      'Home furniture repair and carpentry';

  @override
  String get electricalCategory => 'Electrical';

  @override
  String get electricalCategoryDescription =>
      'Home wiring, lighting, switches, and panels';

  @override
  String get airConditioningCategory => 'Air conditioning';

  @override
  String get airConditioningCategoryDescription =>
      'Air conditioner repair and installation';

  @override
  String get plumbingCategory => 'Plumbing';

  @override
  String get plumbingCategoryDescription => 'Leak repair and pipe installation';
}
