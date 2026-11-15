import 'package:flutter/material.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/presentation/auth_strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      // user_metadata is used here for initial client-side routing. Production
      // authorization must use trusted server-side role claims and RLS policies.
      final assignedRole = _normalizeRole(
        user?.appMetadata['role'] ?? user?.userMetadata?['role'],
      );

      if (assignedRole == null) {
        await _client.auth.signOut();
        _showMessage(context, strings.accountRoleMissing, isError: true);
        return false;
      }
      if (assignedRole != expectedRole) {
        await _client.auth.signOut();
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
      if (!context.mounted) return false;
      _showMessage(context, strings.genericAuthError, isError: true);
      return false;
    }
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
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'city': city,
          'region': area,
          'role': role,
        },
      );
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

  String? _normalizeRole(Object? value) {
    switch (value?.toString().toLowerCase()) {
      case 'customer':
      case 'client':
        return 'customer';
      case 'provider':
        return 'provider';
      default:
        return null;
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
