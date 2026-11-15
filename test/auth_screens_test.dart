import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanad/features/auth/presentation/role_login_screen.dart';
import 'package:sanad/features/auth/presentation/auth_flow_screens.dart';

void main() {
  // These widget tests validate the forms without making network calls to Supabase.
  // Live auth integration still needs to be verified against the target Supabase project.

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
    // Provider accounts are admin-provisioned, so this screen must not offer sign-up.
    expect(find.text('First time here?'), findsNothing);
    expect(find.text('Create a new account'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login validates required fields before contacting Supabase', (tester) async {
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

  testWidgets('customer login keeps the customer self-signup option', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: RoleLoginScreen(role: 'customer')),
    );

    expect(find.text('First time here?'), findsOneWidget);
    expect(find.text('Create a new account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('signup validates required profile fields before submission', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SignupScreen(role: 'customer')),
    );

    // The submit action stays local until every required field is valid.
    final createButton = find.text('Create account');
    await tester.ensureVisible(createButton);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    expect(find.text('This field is required'), findsNWidgets(5));
    expect(tester.takeException(), isNull);
  });
}
