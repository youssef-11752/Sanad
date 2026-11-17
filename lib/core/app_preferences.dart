import 'package:material_ui/material_ui.dart';

/// User-selectable theme modes (system follows the device setting).
enum AppThemeChoice { light, dark, system }

/// Holds the current app language in a ValueNotifier so the root widget can
/// rebuild when it changes. Arabic is the default.
class AppLocaleController {
  AppLocaleController._();

  static final ValueNotifier<Locale> current = ValueNotifier<Locale>(
    const Locale('ar'),
  );

  // Only Arabic and English have translations, so reject anything else.
  static void setLocale(Locale locale) {
    if (locale.languageCode != 'ar' && locale.languageCode != 'en') {
      throw ArgumentError.value(
        locale,
        'locale',
        'Only Arabic and English are supported.',
      );
    }
    current.value = Locale(locale.languageCode);
  }
}

/// Holds the current theme choice; listeners rebuild MaterialApp when it changes.
class AppThemeController {
  AppThemeController._();

  static final ValueNotifier<AppThemeChoice> current =
      ValueNotifier<AppThemeChoice>(AppThemeChoice.light);

  static void setTheme(AppThemeChoice theme) {
    current.value = theme;
  }
}
