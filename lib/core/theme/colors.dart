import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/constants/colors.dart';

/// Central place for app colors and the light/dark ThemeData.
abstract final class AppThemes {
  // Role-based aliases over the raw palette constants.
  static const Color greenColor = DarkTeal;
  static const Color redColor = Rust;
  static const Color cremeyColor = Cream;
  static const Color darkCremey = Champagane;
  static const Color darkGreen = Color(0xFF123F37);
  static const Color mediumGreen = Color(0xFF17483E);
  static const Color whiteColor = SeaShell;
  static const Color privacyColor = StoneWhite;
  static const Color hiAccount = DimGray;
  static const Color splashText = darkGreen;

  // Light theme: cream background, teal primary, rust as accent/error.
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: cremeyColor,
    colorScheme: const ColorScheme.light(
      primary: greenColor,
      secondary: redColor,
      surface: whiteColor,
      error: redColor,
      onPrimary: whiteColor,
      onSurface: darkGreen,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkGreen),
      bodyMedium: TextStyle(color: darkGreen),
      bodySmall: TextStyle(color: hiAccount),
      titleLarge: TextStyle(color: greenColor),
      titleMedium: TextStyle(color: greenColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: cremeyColor,
      foregroundColor: darkGreen,
      elevation: 0,
    ),
    // Rounded, filled text fields shared by all forms.
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: whiteColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(color: hiAccount),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkCremey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkCremey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: greenColor, width: 1.5),
      ),
    ),
  );

  // Dark theme: dark green background with a champagne primary.
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: darkGreen,
    colorScheme: const ColorScheme.dark(
      primary: darkCremey,
      secondary: redColor,
      surface: mediumGreen,
      error: redColor,
      onPrimary: darkGreen,
      onSurface: whiteColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkGreen,
      foregroundColor: whiteColor,
      elevation: 0,
    ),
  );
}
