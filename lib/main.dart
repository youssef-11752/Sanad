import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sanad/features/request_status/screens/my_requests_screen.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
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
    setState(() {
      _supabaseInitialization = _initializeSupabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: FutureBuilder<void>(
        future: _supabaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return MyRequestsScreen(
              ordersLoadError: snapshot.error.toString(),
              onRetry: _retryInitialization,
            );
          }

          return const MyRequestsScreen();
        },
      ),
    );
  }
}
