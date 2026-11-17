import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/authentication/data/repo/auth.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_Button.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_appbarText.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_textFormField.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_textLabel.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Asks for the account email and sends a reset code (step 1 of password recovery).
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({this.role = 'customer', super.key});

  final String role;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final globKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // Ignore taps while a request is running, validate, then send the code.
  Future<void> _sendOtp() async {
    if (isLoading) return;
    if (!globKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    final email = emailController.text.trim();
    final ok = await Auth().sendOtp(email, context);
    if (!mounted) return;
    setState(() => isLoading = false);

    // Pass the email to the OTP screen so it knows what to verify.
    if (ok) context.push('/otpScreen/${widget.role}', extra: email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.cremeyColor,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppThemes.cremeyColor,
          title: CustomAppbartext(
            text: AppLocalizations.of(context)!.forgotPasswordTitle,
          ),
        ),
        // LayoutBuilder + minHeight lets the content center on tall screens but
        // still scroll on small ones.
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: CustomTextlabel(
                          text: AppLocalizations.of(context)!.enterYourEmail,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Form(
                          key: globKey,
                          child: CustomTextformfield(
                            validator: Validators.email,
                            keyboardType: TextInputType.emailAddress,
                            isPassword: false,
                            controller: emailController,
                            bordercolor: AppThemes.redColor,
                            text: 'example@gmail.com',
                            icon: Icons.email_outlined,
                            fillcolor: AppThemes.whiteColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: _sendOtp,
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: CustomButton(
                            text: AppLocalizations.of(context)!.sendOtpButton,
                            isLoading: isLoading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
