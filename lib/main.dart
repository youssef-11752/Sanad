import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sanad/core/routes/app_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/presentation/auth_strings.dart';
import 'package:sanad/features/type_selection/type_provider.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
    _supabaseInitialization =
        widget.supabaseInitialization ?? _initializeSupabase();
  }

  Future<void> _initializeSupabase() async {
    const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    const supabasePublishableKey = String.fromEnvironment(
      'SUPABASE_PUBLISHABLE_KEY',
    );
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

  void _retryInitialization() {
    setState(() => _supabaseInitialization = _initializeSupabase());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      locale: widget.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
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
            return ChangeNotifierProvider(
              create: (_) => RoleSelectionProvider(),
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}

class StartupLoadingScreen extends StatelessWidget {
  const StartupLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

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
            padding: const EdgeInsets.all(24),
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
                  FilledButton(
                    onPressed: onRetry,
                    child: Text(strings.retry),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
