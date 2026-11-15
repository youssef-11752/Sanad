import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad/features/type_selection/role_selection_screen.dart';
import 'package:sanad/features/type_selection/type_provider.dart';

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

  return ChangeNotifierProvider(
    create: (_) => RoleSelectionProvider(),
    child: MaterialApp.router(
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      routerConfig: router,
    ),
  );
}

void main() {
  testWidgets('customer role opens customer authentication route', (tester) async {
    await tester.pumpWidget(_roleSelectionTestApp());

    expect(find.text('متابعة كعميل'), findsOneWidget);
    await tester.tap(find.text('متابعة كعميل'));
    await tester.pumpAndSettle();

    expect(find.text('Customer login destination'), findsOneWidget);
    expect(find.text('Provider login destination'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('provider role opens provider authentication route', (tester) async {
    await tester.pumpWidget(_roleSelectionTestApp());

    final providerOption = find.text('مقدم الخدمة');
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
