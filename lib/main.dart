import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad/core/routes/app_router.dart';
import 'package:sanad/features/request_status/screens/my_requests_screen.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kdzvfetkbgicvfgedpuc.supabase.co',
    publishableKey: 'sb_publishable_r3XiLkp2Ny-9pay-MbEtBg_1mY4Z1TT',
  );
  runApp(DevicePreview(builder: (context) => const MyApp()));
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
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        builder: DevicePreview.appBuilder,
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
              routerConfig: router,
      ),
    );
  }
}
