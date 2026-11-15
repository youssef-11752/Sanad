import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanad/features/auth/presentation/role_login_screen.dart';
import 'package:sanad/features/auth/presentation/auth_flow_screens.dart';

void main() {
  // These widget tests validate the forms without making network calls to Supabase.
  // Backend behavior is covered separately by the auth repository integration checks.

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

  testWidgets('provider login uses the provider-specific visual cue', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: RoleLoginScreen(role: 'provider')),
    );

    expect(find.byIcon(Icons.handyman_outlined), findsOneWidget);
    expect(find.text('Welcome back to Sanad'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login validates required fields before contacting Supabase', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: RoleLoginScreen(role: 'customer')),
    );

    // Empty credentials must be rejected locally before Auth.login is called.
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('This field is required'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('provider signup keeps the previously selected role', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SignupScreen(role: 'provider')),
    );

    expect(find.text('Service provider'), findsOneWidget);
    expect(find.text('New account'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('signup validates required profile fields before submission', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SignupScreen(role: 'customer')),
    );

    // The submit action stays local until every required field is valid.
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text('This field is required'), findsNWidgets(5));
    expect(tester.takeException(), isNull);
  });
}
