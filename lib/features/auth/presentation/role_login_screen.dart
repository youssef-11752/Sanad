import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/data/repo/auth.dart';
import 'package:sanad/features/auth/presentation/auth_strings.dart';

class RoleLoginScreen extends StatefulWidget {
  const RoleLoginScreen({required this.role, super.key});
  final String role;

  @override
  State<RoleLoginScreen> createState() => _RoleLoginScreenState();
}

class _RoleLoginScreenState extends State<RoleLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;

  bool get _isProvider => widget.role == 'provider';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Reuse one login form while validating customer/provider roles separately.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;
    setState(() => _isSubmitting = true);
    final success = await Auth().login(
      _emailController.text.trim(),
      _passwordController.text,
      expectedRole: widget.role,
      context: context,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (success) {
      // Route to the destination that matches the verified database role.
      context.go(_isProvider ? '/provider/dashboard' : '/customer/management');
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return Directionality(
      textDirection: strings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(strings.appName),
          leading: IconButton(
            tooltip: strings.isArabic ? 'رجوع' : 'Back',
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/role-selection'),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        _isProvider ? Icons.handyman_outlined : Icons.home_outlined,
                        size: 56,
                        color: AppThemes.greenColor,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        strings.loginTitle,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppThemes.greenColor,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(strings.loginSubtitle),
                      const SizedBox(height: 28),
                      Text(strings.email, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(hintText: strings.hintEmail),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return strings.requiredField;
                          if (!value.contains('@') || !value.contains('.')) return strings.invalidEmail;
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(strings.password, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: strings.hintPassword),
                        validator: (value) => value == null || value.isEmpty
                            ? strings.requiredField
                            : null,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () => context.push('/forgot-password/' + widget.role),
                          child: Text(strings.forgotPassword),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 52,
                        child: FilledButton(
                          onPressed: _isSubmitting ? null : _submit,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppThemes.redColor,
                            foregroundColor: AppThemes.whiteColor,
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(strings.login),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(strings.securityNote, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      // Only customers can create an account from the public app.
                      // Providers receive their credentials from the Sanad admin.
                      if (!_isProvider)
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(strings.noAccount),
                            TextButton(
                              onPressed: () => context.push('/signup/customer'),
                              child: Text(strings.createAccount),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      Text(strings.termsNote, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
