import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad/features/type_selection/role_selection_screen.dart';
import 'package:sanad/features/type_selection/type_provider.dart';

// Router with the role selection screen and dummy login pages to land on.
Widget _roleSelectionTestApp() {
  final router = GoRouter(
    initialLocation: '/role-selection',
    routes: [
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/login/customer',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Customer login destination')),
        ),
      ),
      GoRoute(
        path: '/login/provider',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Provider login destination')),
        ),
      ),
    ],
  );

  // Provide the role state the same way the app does at startup.
  return ChangeNotifierProvider(
    create: (_) => RoleSelectionProvider(),
    child: MaterialApp.router(
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    ),
  );
}

void main() {
  // Client is selected by default, so its continue button goes to customer login.
  testWidgets('customer role opens customer authentication route', (tester) async {
    await tester.pumpWidget(_roleSelectionTestApp());

    expect(find.text('متابعة كعميل'), findsOneWidget);
    await tester.tap(find.text('متابعة كعميل'));
    await tester.pumpAndSettle();

    expect(find.text('Customer login destination'), findsOneWidget);
    expect(find.text('Provider login destination'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  // Pick the provider card first, then continue to the provider login route.
  testWidgets('provider role opens provider authentication route', (tester) async {
    await tester.pumpWidget(_roleSelectionTestApp());

    final providerOption = find.text('أنا مقدم خدمة');
    await tester.ensureVisible(providerOption);
    await tester.tap(providerOption);
    await tester.pumpAndSettle();

    final continueButton = find.text('متابعة كمقدم خدمة');
    await tester.ensureVisible(continueButton);
    await tester.tap(continueButton);
    await tester.pumpAndSettle();

    expect(find.text('Provider login destination'), findsOneWidget);
    expect(find.text('Customer login destination'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
