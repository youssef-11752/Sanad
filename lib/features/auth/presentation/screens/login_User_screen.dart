import 'package:flutter/material.dart';
import 'package:sanad/features/auth/presentation/role_login_screen.dart';

class LoginUserScreen extends StatelessWidget {
  const LoginUserScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const RoleLoginScreen(role: 'customer');
}
