import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/routes/app_router.dart';
import 'package:sanad/features/provider/provider_home/widgets/BottomNavigationBarWidget.dart';
import 'package:sanad/features/provider/provider_home/screens/provider_home.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

void main() {
  // Opens the dashboard route and checks the page also fits a smaller screen.
  testWidgets('provider dashboard route opens the provider home page', (
    tester,
  ) async {
    // Fixed phone-sized window; reset after the test.
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    appRouter.go('/provider/dashboard');
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp.router(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          routerConfig: appRouter,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ProviderHomePage), findsOneWidget);
    expect(find.textContaining('طلبات مناسبة لصنعتك'), findsOneWidget);
    expect(tester.takeException(), isNull);

    // Shrink the window to check the page still builds without errors.
    tester.view.physicalSize = const Size(320, 568);
    await tester.pumpAndSettle();

    expect(find.byType(ProviderHomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Tapping the account icon in the bottom bar should go to the provider profile route.
  testWidgets('provider account tab opens the provider profile route', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/provider/dashboard',
      routes: [
        GoRoute(
          path: '/provider/dashboard',
          builder: (context, state) =>
              const Scaffold(bottomNavigationBar: BottomNavigationBarWidget()),
        ),
        GoRoute(
          path: '/provider/profile',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Provider profile destination')),
          ),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp.router(
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

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Provider profile destination'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
