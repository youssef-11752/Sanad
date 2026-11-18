import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/routes/app_router.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('application router opens customer categories', (tester) async {
    final router = appRouter;
    addTearDown(router.dispose);
    router.go('/customer/categories?q=Painting');

    await tester.pumpWidget(
      MaterialApp.router(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        routerConfig: router,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Painting'), findsNWidgets(2));
    expect(
      router.routeInformationProvider.value.uri.path,
      '/customer/categories',
    );
    expect(tester.takeException(), isNull);
  });
}
