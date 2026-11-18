import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/widgets/custom_snak_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final supa = Supabase.instance.client.auth;

  Future<void> signOut() => supa.signOut();

  Future<String?> currentUserRole() async {
    final user = supa.currentUser;
    if (user == null) return null;

    final profile = await Supabase.instance.client
        .from('users')
        .select('user_type_id')
        .eq('id', user.id)
        .maybeSingle();
    final userTypeId = profile?['user_type_id'];
    if (userTypeId is! num) return null;

    final userType = await Supabase.instance.client
        .from('user_types')
        .select('name')
        .eq('id', userTypeId)
        .maybeSingle();
    final name = userType?['name']?.toString().trim().toLowerCase();
    if (name == null) return null;
    if (name == 'customer' ||
        name == 'client' ||
        name == 'محتاج خدمة' ||
        name == 'محتاج خدمه' ||
        name == 'عميل') {
      return 'customer';
    }
    if (name == 'provider' ||
        name == 'service provider' ||
        name == 'مقدم الخدمة' ||
        name == 'مقدم خدمه') {
      return 'provider';
    }
    return null;
  }

  // Login
  Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
    String? expectedRole,
  }) async {
    try {
      await supa.signInWithPassword(email: email, password: password);
      if (!context.mounted) return false;
      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;

      String message;
      if (e.code == 'invalid_credentials' ||
          e.message.toLowerCase().contains('invalid login credentials')) {
        message = 'Incorrect email or password.';
      } else if (e.code == 'email_not_confirmed' ||
          e.message.toLowerCase().contains('email not confirmed')) {
        message = 'Please confirm your email first. Check your inbox.';
      } else {
        message = 'Login failed. Please try again.';
      }

      customSnakbar(context, message, Colors.red);
      return false;
    } catch (e) {
      if (!context.mounted) return false;
      customSnakbar(
        context,
        'Login failed. Please check your connection and try again.',
        Colors.red,
      );
      return false;
    }
  }

  // SignUp
  Future<bool> signup({
    required String name,
    required String email,
    required String city,
    required String region,
    required String password,
    required BuildContext context,
    String role = 'customer',
  }) async {
    try {
      final res = await supa.signUp(
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

      // إيميل متسجل قبل كده
      if (res.user != null && (res.user!.identities?.isEmpty ?? false)) {
        customSnakbar(
          context,
          'This email is already registered. Try logging in instead.',
          Colors.red,
        );
        return false;
      }

      customSnakbar(
        context,
        'Account created. Please check your email to confirm it.',
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
        'Sign up failed. Please check your connection and try again.',
        Colors.red,
      );
      return false;
    }
  }

  // Send Otp
  Future<bool> sendOtp(String email, BuildContext context) async {
    try {
      await supa.resetPasswordForEmail(email);
      if (!context.mounted) return false;

      customSnakbar(context, 'We sent a code to your email', Colors.green);

      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;

      customSnakbar(context, e.message, Colors.red);

      return false;
    } catch (e) {
      if (!context.mounted) return false;

      customSnakbar(
        context,
        'Could not send the code. Please check your connection and try again.',
        Colors.red,
      );

      return false;
    }
  }

  // verifyOtp
  Future<bool> verifyOtp(String email, String otp, BuildContext context) async {
    try {
      await supa.verifyOTP(email: email, token: otp, type: OtpType.recovery);
      if (!context.mounted) return false;
      context.go('/newPassword');
      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;
      customSnakbar(context, e.message, Colors.red);
      return false;
    } catch (e) {
      if (!context.mounted) return false;
      customSnakbar(
        context,
        'Could not verify the code. Please check your connection and try again.',
        Colors.red,
      );
      return false;
    }
  }

  // Reset Password
  Future<bool> resetPassword(String newpass, BuildContext context) async {
    try {
      await supa.updateUser(UserAttributes(password: newpass));
      await supa.signOut();
      if (!context.mounted) return false;
      customSnakbar(context, 'Password updated successfully', Colors.green);
      context.go('/finishOtp');
      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;
      customSnakbar(context, e.message, Colors.red);
      return false;
    } catch (e) {
      if (!context.mounted) return false;
      customSnakbar(
        context,
        'Could not update your password. Please check your connection and try again.',
        Colors.red,
      );
      return false;
    }
  }
}
