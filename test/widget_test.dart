import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sanad/main.dart';

void main() {
  testWidgets('counter increments and language can be changed', (
    WidgetTester tester,
  ) async {
    tester.binding.platformDispatcher.localeTestValue = const Locale('en');
    addTearDown(tester.binding.platformDispatcher.clearLocaleTestValue);

    await tester.pumpWidget(const MyApp());

    expect(find.text('Sanad home'), findsOneWidget);
    expect(
      find.text('You have pushed the button this many times:'),
      findsOneWidget,
    );
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byTooltip('Change language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();

    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('عدد مرات الضغط على الزر:'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
