import 'package:flutter/material.dart';
import 'package:sanad/l10n/app_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ar'),
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Text(AppLocalizations.of(context)!.appName),
          ),
        ),
      ),
    );
  }
}