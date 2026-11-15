import 'package:flutter/material.dart';
import 'package:sanad/features/auth/presentation/role_login_screen.dart';

class LoginProvider extends StatelessWidget {
  const LoginProvider({super.key});

  @override
  Widget build(BuildContext context) =>
      const RoleLoginScreen(role: 'provider');
}
