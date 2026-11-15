import 'package:flutter/material.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/data/model/user_role.dart';
import 'package:sanad/features/auth/presentation/auth_strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles Supabase authentication and Sanad's database-backed user roles.
///
/// The profile trigger creates public.users after Supabase Auth sign-up;
/// this repository reads that profile to validate the selected role at login.
class Auth {
  SupabaseClient get _client => Supabase.instance.client;

  Future<bool> login(
    String email,
    String password, {
    required String expectedRole,
    required BuildContext context,
  }) async {
    final strings = AuthStrings.of(context);
    try {
      // First authenticate the credentials with Supabase Auth.
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        _showMessage(context, strings.genericAuthError, isError: true);
        return false;
      }

      // Resolve the account type from the existing public.users ->
      // public.user_types relationship. Never authorize using user_metadata.
      // Compare the requested role with the trusted database assignment.
      final assignedRole = await _assignedRole(user.id);

      if (assignedRole == null) {
        await _rejectSession();
        if (!context.mounted) return false;
        _showMessage(context, strings.accountRoleMissing, isError: true);
        return false;
      }

      if (assignedRole != AuthRole.normalize(expectedRole)) {
        await _rejectSession();
        if (!context.mounted) return false;
        _showMessage(context, strings.wrongAccountRole, isError: true);
        return false;
      }

      if (!context.mounted) return false;
      _showMessage(
        context,
        strings.isArabic ? 'تم تسجيل الدخول بنجاح' : 'Signed in successfully',
      );
      return true;
    } on AuthException catch (error) {
      if (!context.mounted) return false;
      _showMessage(context, error.message, isError: true);
      return false;
    } catch (_) {
      await _rejectSession();
      if (!context.mounted) return false;
      _showMessage(context, strings.genericAuthError, isError: true);
      return false;
    }
  }

  // Resolve users.user_type_id through the related user_types row.
  Future<String?> _assignedRole(String userId) async {
    final profile = await _client
        .from('users')
        .select('user_type_id, user_types!inner(name)')
        .eq('id', userId)
        .maybeSingle();

    if (profile == null) return null;

    final userType = profile['user_types'];
    if (userType is Map) {
      return AuthRole.normalize(userType['name']);
    }
    return null;
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String city,
    required String area,
    required String password,
    required String role,
    required BuildContext context,
  }) async {
    final strings = AuthStrings.of(context);
    try {
      final normalizedRole = AuthRole.normalize(role);
      if (normalizedRole == null) {
        _showMessage(context, strings.genericAuthError, isError: true);
        return false;
      }

      // Provider accounts are pre-created by the Sanad admin with assigned
      // credentials and provider data; only customers may self-register here.
      if (normalizedRole != 'customer') {
        _showMessage(context, strings.providerSignupManaged, isError: true);
        return false;
      }

      // The database trigger consumes this metadata and creates public.users.
      // The role is normalized before it reaches the trigger.
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name,
          'name': name,
          'city': city,
          'region': area,
          // The database trigger accepts only customer/provider role values
          // and resolves the matching user_types.id on the server.
          'role': normalizedRole,
        },
      );

      // A null user means Supabase did not create an account successfully.
      // With email confirmation enabled, user is present even when session is null.
      if (response.user == null) {
        if (!context.mounted) return false;
        _showMessage(context, strings.genericAuthError, isError: true);
        return false;
      }

      if (!context.mounted) return false;
      _showMessage(
        context,
        strings.isArabic
            ? 'تم إنشاء الحساب. يمكنك تسجيل الدخول بعد تأكيد البريد إذا كان التحقق مفعّلاً.'
            : 'Account created. You can sign in after email confirmation if it is enabled.',
      );
      return true;
    } on AuthException catch (error) {
      if (!context.mounted) return false;
      _showMessage(context, error.message, isError: true);
      return false;
    } catch (_) {
      if (!context.mounted) return false;
      _showMessage(context, strings.genericAuthError, isError: true);
      return false;
    }
  }

  Future<bool> sendOtp(String email, BuildContext context) async {
    final strings = AuthStrings.of(context);
    try {
      // Supabase's recovery email template controls whether it sends a link or OTP.
      await _client.auth.resetPasswordForEmail(email);
      if (!context.mounted) return false;
      _showMessage(
        context,
        strings.isArabic ? 'تم إرسال تعليمات الاستعادة' : 'Password recovery instructions sent',
      );
      return true;
    } on AuthException catch (error) {
      if (!context.mounted) return false;
      _showMessage(context, error.message, isError: true);
      return false;
    } catch (_) {
      if (!context.mounted) return false;
      _showMessage(context, strings.genericAuthError, isError: true);
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String otp, BuildContext context) async {
    final strings = AuthStrings.of(context);
    try {
      // Verify the recovery code and establish a password-recovery session.
      await _client.auth.verifyOTP(email: email, token: otp, type: OtpType.recovery);
      return true;
    } on AuthException catch (error) {
      if (!context.mounted) return false;
      _showMessage(context, error.message, isError: true);
      return false;
    } catch (_) {
      if (!context.mounted) return false;
      _showMessage(context, strings.genericAuthError, isError: true);
      return false;
    }
  }

  Future<bool> resetPassword(String newPassword, BuildContext context) async {
    final strings = AuthStrings.of(context);
    try {
      // A valid recovery session is required before changing the password.
      await _client.auth.updateUser(UserAttributes(password: newPassword));
      if (!context.mounted) return false;
      _showMessage(context, strings.passwordResetDone);
      return true;
    } on AuthException catch (error) {
      if (!context.mounted) return false;
      _showMessage(context, error.message, isError: true);
      return false;
    } catch (_) {
      if (!context.mounted) return false;
      _showMessage(context, strings.genericAuthError, isError: true);
      return false;
    }
  }

  Future<void> signOut() => _client.auth.signOut();

  Future<void> _rejectSession() async {
    try {
      await _client.auth.signOut();
    } catch (_) {
      // Preserve the original authentication/role error.
    }
  }

  void _showMessage(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red.shade800 : AppThemes.greenColor,
        ),
      );
  }
}
