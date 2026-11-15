import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/features/auth/presentation/screens/splash_Screen.dart';
import 'package:sanad/features/onboarding/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        path: '/role-selection',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Role selection destination')),
        ),
      ),
    ],
  );
  return MaterialApp.router(routerConfig: router);
}

Future<void> _openFirstRunOnboarding(WidgetTester tester) async {
  await tester.pumpWidget(_testApp());
  await tester.pump(const Duration(milliseconds: 1800));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('shows splash first and then opens onboarding on first launch', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('كل صنعة لها سند'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows splash then skips onboarding after it was completed', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      OnboardingScreen.completedKey: true,
    });

    await tester.pumpWidget(_testApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Role selection destination'), findsNothing);

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.text('Role selection destination'), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);
    expect(tester.takeException(), isNull);
  });

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

  testWidgets('start now completes onboarding and opens role selection', (
    tester,
  ) async {
    await _openFirstRunOnboarding(tester);

    await tester.tap(find.text('التالي'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('التالي'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ابدأ الآن'));
    await tester.pumpAndSettle();

    expect(find.text('Role selection destination'), findsOneWidget);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool(OnboardingScreen.completedKey), isTrue);
  });

  testWidgets('skip completes onboarding and opens role selection', (
    tester,
  ) async {
    await _openFirstRunOnboarding(tester);

    await tester.tap(find.text('تخطي'));
    await tester.pumpAndSettle();

    expect(find.text('Role selection destination'), findsOneWidget);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool(OnboardingScreen.completedKey), isTrue);
  });
}
