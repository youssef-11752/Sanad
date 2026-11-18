import 'package:material_ui/material_ui.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sanad/core/app_preferences.dart';
import 'package:sanad/core/routes/app_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/authentication/AuthLoggedUser.dart';
import 'package:sanad/features/authentication/presentation/auth_strings.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// App entry point. Supabase is initialized later inside MyApp so a failure can be shown on screen.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthLoggedUser(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.locale, this.supabaseInitialization});

  final Locale? locale;
  final Future<void>? supabaseInitialization;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _supabaseInitialization;

  @override
  void initState() {
    super.initState();
    // Started once here; the future drives the loading/error screens in build().
    _supabaseInitialization =
        widget.supabaseInitialization ?? _initializeSupabase();
  }

  // Credentials come from --dart-define so no keys are committed to the repo.
  Future<void> _initializeSupabase() async {
    const supabaseUrl = String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://kdzvfetkbgicvfgedpuc.supabase.co',
    );
    const supabasePublishableKey = String.fromEnvironment(
      'SUPABASE_PUBLISHABLE_KEY',
      defaultValue: 'sb_publishable_r3XiLkp2Ny-9pay-MbEtBg_1mY4Z1TT',
    );
    // Fail early with a clear message when the config is missing.
    if (supabaseUrl.isEmpty || supabasePublishableKey.isEmpty) {
      throw StateError(
        'Pass SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY using --dart-define.',
      );
    }

    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: supabasePublishableKey,
    );
  }

  // Re-run the initialization after a failure; rebuilding makes the FutureBuilder start over.
  void _retryInitialization() {
    setState(() => _supabaseInitialization = _initializeSupabase());
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil scales sizes from the 360x690 design size.
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Rebuild when the user changes the app language.
      builder: (context, _) => ValueListenableBuilder<Locale>(
        valueListenable: AppLocaleController.current,
        builder: (context, selectedLocale, child) =>
            // Rebuild when the user changes the theme choice.
            ValueListenableBuilder<AppThemeChoice>(
              valueListenable: AppThemeController.current,
              builder: (context, selectedTheme, child) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  onGenerateTitle: (context) =>
                      AppLocalizations.of(context)!.appTitle,
                  locale: widget.locale ?? selectedLocale,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    ...GlobalMaterialLocalizations.delegates,
                  ],
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  // Map the stored theme choice onto Flutter's ThemeMode.
                  themeMode: switch (selectedTheme) {
                    AppThemeChoice.light => ThemeMode.light,
                    AppThemeChoice.dark => ThemeMode.dark,
                    AppThemeChoice.system => ThemeMode.system,
                  },
                  // All navigation is handled by the shared go_router config.
                  routerConfig: appRouter,
                  // Wrap every page: show loading/error until Supabase is ready.
                  builder: (context, child) {
                    return FutureBuilder<void>(
                      future: _supabaseInitialization,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const StartupLoadingScreen();
                        }
                        if (snapshot.hasError) {
                          return StartupErrorScreen(
                            message: snapshot.error.toString(),
                            onRetry: _retryInitialization,
                          );
                        }
                        return child ?? const SizedBox.shrink();
                      },
                    );
                  },
                );
              },
            ),
      ),
    );
  }
}

/// Simple spinner shown while Supabase initializes.
class StartupLoadingScreen extends StatelessWidget {
  const StartupLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/// Shown when startup fails (e.g. missing config), with a retry button.
class StartupErrorScreen extends StatelessWidget {
  const StartupErrorScreen({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return Directionality(
      textDirection: strings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const widgets.EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_outlined, size: 48),
                  const SizedBox(height: 16),
                  Text(strings.startupError, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  SelectableText(message, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  FilledButton(onPressed: onRetry, child: Text(strings.retry)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
