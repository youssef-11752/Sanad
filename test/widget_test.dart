import 'dart:ui' show Locale, Size;

import 'package:flutter_test/flutter_test.dart';

import 'package:sanad/main.dart';

void main() {
  testWidgets('shows current requests and switches to previous visits', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(279, 774);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp(locale: Locale('ar')));
    expect(tester.takeException(), isNull);

    expect(find.text('طلباتي').first, findsOneWidget);
    expect(find.text('الطلبات الجارية'), findsOneWidget);
    expect(find.text('متابعة SN-2048'), findsOneWidget);

    await tester.tap(find.text('السابقة (٣)'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    expect(find.text('من زياراتك السابقة'), findsOneWidget);
    expect(find.text('الطلبات الجارية'), findsNothing);
    expect(find.text('إصلاح تسريب حوض المطبخ'), findsOneWidget);

    await tester.tap(find.text('الجارية (١)'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    expect(find.text('الطلبات الجارية'), findsOneWidget);
  });

  testWidgets('shows requests in English when English is selected', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(279, 774);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp(locale: Locale('en')));

    expect(find.text('My requests'), findsNWidgets(2));
    expect(find.text('Current requests'), findsOneWidget);
    expect(find.text('Track SN-2048'), findsOneWidget);
    expect(find.text('Your previous visits'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
