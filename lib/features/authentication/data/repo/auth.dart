import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/widgets/custom_SnakBar.dart';
import 'package:sanad/features/authentication/data/model/user_role.dart';
import 'package:sanad/features/authentication/presentation/auth_strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Thin wrapper around Supabase auth. Each method shows its own error snackbar
/// and returns true/false so screens only need to react to the result.
class Auth {
  final supa = Supabase.instance.client.auth;

  Future<void> signOut() => supa.signOut();

  Future<String?> currentUserRole() => _currentUserRole();

  /// Signs in, and optionally checks the account really has [expectedRole].
  Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
    String? expectedRole,
  }) async {
    try {
      await supa.signInWithPassword(email: email, password: password);
      // The widget may be gone after an await, so check `mounted` before using context.
      if (!context.mounted) return false;

      // A customer must not log in through the provider screen (and vice versa),
      // so sign out again if the stored role does not match.
      if (expectedRole != null) {
        final actualRole = await _currentUserRole();
        if (!context.mounted) return false;
        if (actualRole == null) {
          await supa.signOut();
          if (!context.mounted) return false;
          customSnakbar(
            context,
            AuthStrings.of(context).accountRoleMissing,
            Colors.red,
          );
          return false;
        }
        if (actualRole != AuthRole.normalize(expectedRole)) {
          await supa.signOut();
          if (!context.mounted) return false;
          customSnakbar(
            context,
            AuthStrings.of(context).wrongAccountRole,
            Colors.red,
          );
          return false;
        }
      }

      return true;
      // Map known Supabase error codes to localized messages.
    } on AuthException catch (error) {
      if (!context.mounted) return false;
      final strings = AuthStrings.of(context);
      final message = switch (error.code) {
        'invalid_credentials' => strings.incorrectCredentials,
        'email_not_confirmed' => strings.emailNotConfirmed,
        _ => error.message,
      };
      customSnakbar(context, message, Colors.red);
      return false;
    } catch (error) {
      if (!context.mounted) return false;
      customSnakbar(
        context,
        AuthStrings.of(context).genericAuthError,
        Colors.red,
      );
      return false;
    }
  }

  // Looks up the role in two steps: users.user_type_id, then user_types.name.
  Future<String?> _currentUserRole() async {
    final user = supa.currentUser;
    if (user == null) return null;

    final client = Supabase.instance.client;
    final profile = await client
        .from('users')
        .select('user_type_id')
        .eq('id', user.id)
        .maybeSingle();
    final userTypeId = profile?['user_type_id'];
    if (userTypeId is! num) return null;

    final userType = await client
        .from('user_types')
        .select('name')
        .eq('id', userTypeId)
        .maybeSingle();
    return AuthRole.normalize(userType?['name']);
  }

  /// Creates a customer account. Providers cannot register from the app.
  Future<bool> signup({
    required String name,
    required String email,
    required String city,
    required String region,
    required String password,
    required BuildContext context,
    String role = 'customer',
  }) async {
    final strings = AuthStrings.of(context);
    if (AuthRole.normalize(role) != 'customer') {
      customSnakbar(context, strings.wrongAccountRole, Colors.red);
      return false;
    }

    // Extra profile fields go into user metadata.
    try {
      final response = await supa.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
          'full_name': name,
          'city': city,
          'region': region,
          'role': 'customer',
        },
      );
      if (!context.mounted) return false;

      // Supabase returns a user with no identities when the email is already
      // registered (to avoid leaking account existence), so detect that case.
      if (response.user != null &&
          (response.user!.identities?.isEmpty ?? false)) {
        customSnakbar(context, strings.emailAlreadyRegistered, Colors.red);
        return false;
      }

      customSnakbar(context, strings.accountCreatedCheckEmail, Colors.green);
      return true;
    } on AuthException catch (error) {
      if (!context.mounted) return false;
      customSnakbar(context, error.message, Colors.red);
      return false;
    } catch (error) {
      if (!context.mounted) return false;
      customSnakbar(context, strings.genericAuthError, Colors.red);
      return false;
    }
  }

  // Send Otp
  Future<bool> sendOtp(String email, BuildContext context) async {
    try {
      await supa.resetPasswordForEmail(email);
      if (!context.mounted) return false;

      customSnakbar(context, AuthStrings.of(context).otpSent, Colors.green);
      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;

      customSnakbar(context, e.message, Colors.red);
      return false;
    } catch (e) {
      if (!context.mounted) return false;

      customSnakbar(
        context,
        AuthStrings.of(context).genericAuthError,
        Colors.red,
      );
      return false;
    }
  }

  // Verifies the recovery code that was emailed to the user.
  Future<bool> verifyOtp(String email, String otp, BuildContext context) async {
    try {
      await supa.verifyOTP(email: email, token: otp, type: OtpType.recovery);
      if (!context.mounted) return false;
      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;
      customSnakbar(context, e.message, Colors.red);
      return false;
    } catch (e) {
      if (!context.mounted) return false;
      customSnakbar(
        context,
        AuthStrings.of(context).genericAuthError,
        Colors.red,
      );
      return false;
    }
  }

  // Sets the new password, then signs out so the user logs in again with it.
  Future<bool> resetPassword(String newPassword, BuildContext context) async {
    try {
      await supa.updateUser(UserAttributes(password: newPassword));
      await supa.signOut();
      if (!context.mounted) return false;
      customSnakbar(
        context,
        AuthStrings.of(context).passwordUpdated,
        Colors.green,
      );
      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;
      customSnakbar(context, e.message, Colors.red);
      return false;
    } catch (e) {
      if (!context.mounted) return false;
      customSnakbar(
        context,
        AuthStrings.of(context).genericAuthError,
        Colors.red,
      );
      return false;
    }
  }
}
