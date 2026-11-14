import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:sanad/core/widgets/custom_SnakBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final supa = Supabase.instance.client.auth;

  // Login
  Future<bool> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await supa.signInWithPassword(email: email, password: password);
      if (!context.mounted) return false;
      customSnakbar(context, 'Success', Colors.green);
      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;
      customSnakbar(context, e.message, Colors.red);
      return false;
    } catch (e) {
      if (!context.mounted) return false;
      customSnakbar(context, 'Failed To Login', Colors.red);
      return false;
    }
  }

  // SignUp
  Future<bool> signup(
    String name,
    String email,
    String city,
    String region,
    String password,
    BuildContext context,
  ) async {
    try {
      await supa.signUp(
        password: password,
        email: email,
        data: {'name': name, 'city': city, 'region': region},
      );

      if (!context.mounted) return false;

      customSnakbar(context, 'Success', Colors.green);

      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;

      customSnakbar(context, e.message, Colors.red);

      return false;
    } catch (e) {
      if (!context.mounted) return false;

      customSnakbar(context, 'Failed To SignUp', Colors.red);

      return false;
    }
  }

  // Send Otp
  Future<bool> sendOtp(String email, BuildContext context) async {
    try {
      await supa.resetPasswordForEmail(email);
      if (!context.mounted) return false;

      customSnakbar(context, 'Success', Colors.green);

      return true;
    } on AuthException catch (e) {
      if (!context.mounted) return false;

      customSnakbar(context, e.message, Colors.red);

      return false;
    } catch (e) {
      if (!context.mounted) return false;

      customSnakbar(context, 'Failed To Send OTP', Colors.red);

      return false;
    }
  }

  // verifyOtp
  Future<void> verifyOtp(String email, String otp, BuildContext context) async {
    try {
      await supa.verifyOTP(email: email, token: otp, type: OtpType.recovery);
      context.go('/newPassword');
    } on AuthException catch (e) {
      customSnakbar(context, e.message, Colors.red);
    } catch (e) {
      customSnakbar(context, 'Failed To Verify OTP', Colors.red);
    }
  }

  // Reset Password
  resetPassword(String newpass, BuildContext context) async {
    try {
      await supa.updateUser(UserAttributes(password: newpass));
      customSnakbar(context, "Password Updated Successfully", Colors.green);
      context.go('/finishOtp');
    } on AuthException catch (e) {
      customSnakbar(context, e.message, Colors.red);
    } catch (e) {
      customSnakbar(context, 'Failed To Update Password', Colors.red);
    }
  }
}
