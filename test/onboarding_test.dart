import 'dart:convert';

import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/features/splash/splash_screen.dart';
import 'package:sanad/features/onboarding/screens/onboarding_screen.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Fake asset bundle so the splash screen does not need the real logo file.
class _SplashTestAssetBundle extends CachingAssetBundle {
  // A 1x1 transparent PNG stands in for the image.
  static final Uint8List _pixel = base64.decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=',
  );

  @override
  Future<ByteData> load(String key) async {
    // Serve the stub only for the splash image; everything else loads normally.
    if (key == 'assets/images/Sanad house · Soft rise.png') {
      return ByteData.sublistView(_pixel);
    }
    return rootBundle.load(key);
  }
}

// Minimal router with the splash, onboarding and a dummy customer login page.
Widget _testApp() {
  final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login/customer',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Customer login destination')),
        ),
      ),
    ],
  );
  // ScreenUtil and localization are wrapped around the router like in the real app.
  return DefaultAssetBundle(
    bundle: _SplashTestAssetBundle(),
    child: ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp.router(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        routerConfig: router,
      ),
    ),
  );
}

// Runs the splash delay and lands on the first onboarding page.
Future<void> _openFirstRunOnboarding(WidgetTester tester) async {
  await tester.pumpWidget(_testApp());
  await tester.pump(const Duration(milliseconds: 4800));
  await tester.pumpAndSettle();
}

void main() {
  // Start each test as a first launch with no saved preferences.
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // First launch: splash, then onboarding after the splash delay.
  testWidgets('shows splash first and then opens onboarding on first launch', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);

    await tester.pump(const Duration(milliseconds: 4800));
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('كل صنعة لها سند'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Once onboarding is marked completed, the splash goes straight to customer login.
  testWidgets('shows splash then skips onboarding after it was completed', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      OnboardingScreen.completedKey: true,
    });

    await tester.pumpWidget(_testApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Customer login destination'), findsNothing);

    await tester.pump(const Duration(milliseconds: 4800));
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.text('Customer login destination'), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);
    expect(tester.takeException(), isNull);
  });

  // Walk through all three pages with the Next button.
  testWidgets('shows exactly three onboarding pages and advances in order', (
    tester,
  ) async {
    await _openFirstRunOnboarding(tester);

    expect(find.text('كل صنعة لها سند'), findsOneWidget);
    expect(find.text('خطوة 1 من 3'), findsOneWidget);

    await tester.tap(find.text('التالي'));
    await tester.pumpAndSettle();

    expect(find.text('أهل خبرة قريبين منك'), findsOneWidget);
    expect(find.text('خطوة 2 من 3'), findsOneWidget);

    await tester.tap(find.text('التالي'));
    await tester.pumpAndSettle();

    expect(find.text('سند معاك لحد ما الشغل يخلص'), findsOneWidget);
    expect(find.text('خطوة 3 من 3'), findsOneWidget);
    expect(find.text('ابدأ الآن'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Use a small phone size to make sure nothing overflows; content must scroll.
  testWidgets('onboarding content remains scrollable on a small screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _openFirstRunOnboarding(tester);

    expect(find.text('كل صنعة لها سند'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  // Finishing the last page saves the completed flag and navigates on.
  testWidgets('start now completes onboarding and opens customer login', (
    tester,
  ) async {
    await _openFirstRunOnboarding(tester);

    await tester.tap(find.text('التالي'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('التالي'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ابدأ الآن'));
    await tester.pumpAndSettle();

    expect(find.text('Customer login destination'), findsOneWidget);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool(OnboardingScreen.completedKey), isTrue);
  });

  // Skipping also counts as completing onboarding.
  testWidgets('skip completes onboarding and opens customer login', (
    tester,
  ) async {
    await _openFirstRunOnboarding(tester);

    await tester.tap(find.text('تخطي'));
    await tester.pumpAndSettle();

    expect(find.text('Customer login destination'), findsOneWidget);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool(OnboardingScreen.completedKey), isTrue);
  });
}
