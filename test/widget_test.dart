import 'dart:async';
import 'dart:ui' show Locale, Size;

import 'package:flutter/material.dart' show MaterialApp, Widget;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sanad/features/request_status/models/request_item.dart';
import 'package:sanad/features/request_status/screens/my_requests_screen.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:sanad/main.dart';

Future<void> _pumpRequests(
  WidgetTester tester, {
  required Locale locale,
  required List<RequestItem> requests,
}) async {
  await tester.pumpWidget(_requestsApp(locale, Future.value(requests)));
  await tester.pumpAndSettle();
}

Widget _requestsApp(Locale locale, Future<List<RequestItem>> ordersFuture) {
  return MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    home: MyRequestsScreen(ordersFuture: ordersFuture),
  );
}

void main() {
  testWidgets('shows a dedicated startup error when Supabase setup is missing', (tester) async {
    final initialization = Completer<void>();
    await tester.pumpWidget(
      MyApp(
        locale: const Locale('en'),
        supabaseInitialization: initialization.future,
      ),
    );
    initialization.completeError(StateError('Missing Supabase setup'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(StartupErrorScreen), findsOneWidget);
    expect(find.textContaining('Missing Supabase setup'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.byType(MyRequestsScreen), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps the requests screen visible when loading fails', (
    tester,
  ) async {
    final orders = Completer<List<RequestItem>>();
    await tester.pumpWidget(_requestsApp(const Locale('en'), orders.future));
    orders.completeError(StateError('Database unavailable'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Current requests'), findsOneWidget);
    expect(find.textContaining('Database unavailable'), findsOneWidget);
    expect(find.text('No current orders.'), findsNothing);
    expect(find.text('Retry'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows current requests and switches to previous visits', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(279, 774);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _pumpRequests(
      tester,
      locale: const Locale('ar'),
      requests: const [
        RequestItem(
          id: 'pending-1',
          status: RequestStatus.pending,
          title: 'Pending request',
          provider: 'Provider 1',
          date: '2026-11-14',
        ),
        RequestItem(
          id: 'fulfilled-1',
          status: RequestStatus.fulfilled,
          title: 'Fulfilled request',
          provider: 'Provider 2',
          date: '2026-10-28',
        ),
      ],
    );
    expect(tester.takeException(), isNull);

    expect(find.text('طلباتي').first, findsOneWidget);
    expect(find.text('الطلبات الجارية'), findsOneWidget);
    expect(find.text('من زياراتك السابقة'), findsNothing);
    expect(find.text('Pending request'), findsOneWidget);
    expect(find.text('قيد الانتظار'), findsOneWidget);
    expect(find.text('Fulfilled request'), findsNothing);

    await tester.tap(find.textContaining('السابقة'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    expect(find.text('من زياراتك السابقة'), findsOneWidget);
    expect(find.text('الطلبات الجارية'), findsNothing);
    expect(find.text('Fulfilled request'), findsOneWidget);
    expect(find.text('تم التنفيذ'), findsOneWidget);
    expect(find.text('Pending request'), findsNothing);

    await tester.tap(find.textContaining('الجارية'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    expect(find.text('الطلبات الجارية'), findsOneWidget);
    expect(find.text('من زياراتك السابقة'), findsNothing);
    expect(find.text('Pending request'), findsOneWidget);
    expect(find.text('Fulfilled request'), findsNothing);
  });

  testWidgets('shows requests in English when English is selected', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(279, 774);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _pumpRequests(
      tester,
      locale: const Locale('en'),
      requests: const [
        RequestItem(
          id: 'pending-1',
          status: RequestStatus.pending,
          title: 'Pending request',
          provider: 'Provider 1',
          date: '2026-11-14',
        ),
        RequestItem(
          id: 'fulfilled-1',
          status: RequestStatus.fulfilled,
          title: 'Fulfilled request',
          provider: 'Provider 2',
          date: '2026-10-28',
        ),
      ],
    );

    expect(find.text('My requests'), findsNWidgets(2));
    expect(find.text('Current requests'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    expect(find.text('Your previous visits'), findsNothing);
    expect(find.text('Fulfilled request'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows the empty message for each tab with no orders', (
    tester,
  ) async {
    await _pumpRequests(tester, locale: const Locale('en'), requests: const []);

    expect(find.text('No current orders.'), findsOneWidget);
    expect(find.text('No previous orders.'), findsNothing);

    await tester.tap(find.text('Previous (0)'));
    await tester.pumpAndSettle();

    expect(find.text('No current orders.'), findsNothing);
    expect(find.text('No previous orders.'), findsOneWidget);
  });
}
