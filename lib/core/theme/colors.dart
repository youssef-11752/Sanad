import 'package:flutter/material.dart';

abstract final class AppThemes {
  static const Color greenColor = Color(0xFF00564F);
  static const Color redColor = Color(0xFFC63922);
  static const Color cremeyColor = Color(0xFFF8F0DC);
  static const Color darkCremey = Color(0xFFE5D3A6);
  static const Color darkGreen = Color(0xFF0C302B);
  static const Color mediumGreen = Color(0xFF17483E);
  static const Color whiteColor = Color(0xFFFFFAEF);
  static const Color privacyColor = Color(0xFFE3E8D4);
  static const Color hiAccount = Color(0xFF607468);
  static const Color splashText = Color(0xFF153F36);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: cremeyColor,
        colorScheme: const ColorScheme.light(
          primary: greenColor,
          secondary: redColor,
          surface: whiteColor,
          error: redColor,
          onPrimary: whiteColor,
          onSurface: darkGreen,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: cremeyColor,
          foregroundColor: darkGreen,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
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
