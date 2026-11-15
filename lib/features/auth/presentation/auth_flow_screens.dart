import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/data/repo/auth.dart';
import 'package:sanad/features/auth/presentation/auth_strings.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({required this.role, super.key});
  final String role;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _city = TextEditingController();
  final _area = TextEditingController();
  final _password = TextEditingController();
  bool _acceptedTerms = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _city.dispose();
    _area.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final strings = AuthStrings.of(context);
    if (!_formKey.currentState!.validate() || _isSubmitting) return;
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.agreeTermsError)),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    final success = await Auth().signup(
      name: _name.text.trim(),
      email: _email.text.trim(),
      city: _city.text.trim(),
      area: _area.text.trim(),
      password: _password.text,
      role: widget.role,
      context: context,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (success) {
      context.go(widget.role == 'provider' ? '/login/provider' : '/login/customer');
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return _AuthPage(
      title: strings.signupTitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(strings.signupSubtitle),
            const SizedBox(height: 12),
            Text(
              widget.role == 'provider' ? strings.provider : strings.customer,
              style: const TextStyle(
                color: AppThemes.greenColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _AuthInput(
              controller: _name,
              label: strings.fullName,
              hint: strings.hintName,
              validator: (value) => value == null || value.trim().isEmpty
                  ? strings.requiredField
                  : null,
            ),
            _AuthInput(
              controller: _email,
              label: strings.email,
              hint: strings.hintEmail,
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return strings.requiredField;
                if (!value.contains('@') || !value.contains('.')) return strings.invalidEmail;
                return null;
              },
            ),
            _AuthInput(
              controller: _city,
              label: strings.city,
              hint: strings.hintCity,
              validator: (value) => value == null || value.trim().isEmpty
                  ? strings.requiredField
                  : null,
            ),
            _AuthInput(
              controller: _area,
              label: strings.area,
              hint: strings.hintArea,
              validator: (value) => value == null || value.trim().isEmpty
                  ? strings.requiredField
                  : null,
            ),
            _AuthInput(
              controller: _password,
              label: strings.password,
              hint: strings.hintPassword,
              obscureText: true,
              validator: (value) => value == null || value.length < 8
                  ? strings.shortPassword
                  : null,
            ),
            CheckboxListTile(
              value: _acceptedTerms,
              onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(strings.acceptTerms),
            ),
            const SizedBox(height: 12),
            _AuthPrimaryButton(
              text: strings.create,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.go(
                widget.role == 'provider' ? '/login/provider' : '/login/customer',
              ),
              child: Text(strings.haveAccount),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({required this.role, super.key});
  final String role;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;
    setState(() => _isSubmitting = true);
    final success = await Auth().sendOtp(_email.text.trim(), context);
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (success) {
      context.push('/verify-code/' + widget.role, extra: _email.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return _AuthPage(
      title: strings.forgotTitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AuthInput(
              controller: _email,
              label: strings.enterEmail,
              hint: strings.hintEmail,
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return strings.requiredField;
                if (!value.contains('@') || !value.contains('.')) return strings.invalidEmail;
                return null;
              },
            ),
            const SizedBox(height: 12),
            _AuthPrimaryButton(
              text: strings.sendCode,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({required this.email, required this.role, super.key});
  final String email;
  final String role;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;
    setState(() => _isSubmitting = true);
    final success = await Auth().verifyOtp(widget.email, _code.text.trim(), context);
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (success) context.go('/new-password/' + widget.role);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return _AuthPage(
      title: strings.otpTitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.email, textDirection: TextDirection.ltr),
            const SizedBox(height: 12),
            Text(strings.otpMessage),
            const SizedBox(height: 16),
            _AuthInput(
              controller: _code,
              label: strings.otpTitle,
              hint: '000000',
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) => value == null || value.length != 6
                  ? (strings.isArabic ? 'أدخل الرمز المكوّن من 6 أرقام' : 'Enter the 6-digit code')
                  : null,
            ),
            const SizedBox(height: 12),
            _AuthPrimaryButton(
              text: strings.verify,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({required this.role, super.key});
  final String role;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;
    setState(() => _isSubmitting = true);
    final success = await Auth().resetPassword(_password.text, context);
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (success) context.go('/password-reset-done/' + widget.role);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return _AuthPage(
      title: strings.newPasswordTitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AuthInput(
              controller: _password,
              label: strings.enterNewPassword,
              hint: strings.hintPassword,
              obscureText: true,
              validator: (value) => value == null || value.length < 8
                  ? strings.shortPassword
                  : null,
            ),
            _AuthInput(
              controller: _confirmPassword,
              label: strings.confirmPassword,
              hint: strings.hintPassword,
              obscureText: true,
              validator: (value) => value != _password.text
                  ? strings.passwordsMismatch
                  : null,
            ),
            const SizedBox(height: 12),
            _AuthPrimaryButton(
              text: strings.savePassword,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class FinishOtpScreen extends StatelessWidget {
  const FinishOtpScreen({required this.role, super.key});
  final String role;

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return _AuthPage(
      title: strings.passwordResetDone,
      child: SizedBox(
        width: double.infinity,
        child: _AuthPrimaryButton(
          text: strings.goToLogin,
          onPressed: () => context.go(
            role == 'provider' ? '/login/provider' : '/login/customer',
          ),
        ),
      ),
    );
  }
}

class _AuthPage extends StatelessWidget {
  const _AuthPage({required this.title, required this.child});
  final String title;
  final Widget child;

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
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppThemes.greenColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 24),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthInput extends StatelessWidget {
  const _AuthInput({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.textDirection,
    this.obscureText = false,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            textDirection: textDirection,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(hintText: hint),
          ),
        ],
      ),
    );
  }
}

class _AuthPrimaryButton extends StatelessWidget {
  const _AuthPrimaryButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppThemes.redColor,
          foregroundColor: AppThemes.whiteColor,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(text),
      ),
    );
  }
}
