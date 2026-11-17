import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanad/features/auth/presentation/role_login_screen.dart';
import 'package:sanad/features/auth/presentation/screens/login_Provider.dart';
import 'package:sanad/features/auth/presentation/auth_flow_screens.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

void main() {
  // These widget tests validate the forms without making network calls to Supabase.
  // Live auth integration still needs to be verified against the target Supabase project.

  // Customer and provider share one login screen; only the icon and sign-up option differ.
  testWidgets('customer login opens the shared login form', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: RoleLoginScreen(role: 'customer')),
    );

    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.text('Welcome back to Sanad'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('provider login uses the provider-specific visual cue', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: RoleLoginScreen(role: 'provider')),
    );

    expect(find.byIcon(Icons.handyman_outlined), findsOneWidget);
    expect(find.text('Welcome back to Sanad'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    // Provider accounts are admin-provisioned, so this screen must not offer sign-up.
    expect(find.text('First time here?'), findsNothing);
    expect(find.text('Create a new account'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  // Uses the provider-specific login page, which has no sign-up link.
  testWidgets('provider login only offers sign-in for pre-created accounts', (
    tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: LoginProvider(),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(
      find.text(
        'Provider accounts are created by Sanad admin. Please use the credentials provided to you.',
      ),
      findsOneWidget,
    );
    expect(find.text('Create a new account'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  // Tapping login with empty fields should only trigger local validation errors.
  testWidgets('login validates required fields before contacting Supabase', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: RoleLoginScreen(role: 'customer')),
    );

    // Empty credentials must be rejected locally before Auth.login is called.
    final loginButton = find.text('Log in');
    await tester.ensureVisible(loginButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('This field is required'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  // Customers can register themselves, unlike providers.
  testWidgets('customer login keeps the customer self-signup option', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: RoleLoginScreen(role: 'customer')),
    );

    expect(find.text('First time here?'), findsOneWidget);
    expect(find.text('Create a new account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Same idea for the signup form.
  testWidgets('signup validates required profile fields before submission', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: SignupScreen(role: 'customer')),
    );

    // The submit action stays local until every required field is valid.
    final createButton = find.text('Create account');
    await tester.ensureVisible(createButton);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    // Four text fields are required; the password shows its own length rule.
    expect(find.text('This field is required'), findsNWidgets(4));
    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
