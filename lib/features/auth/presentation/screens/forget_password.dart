import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/data/repo/auth.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_Button.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_appbarText.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_textFormField.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_textLabel.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  final globKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.cremeyColor,
        //AppBar
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppThemes.cremeyColor,
          title: CustomAppbartext(
            text: AppLocalizations.of(context)!.forgotPasswordTitle,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Email Field
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
                            validator: (value) {
  if (value == null || !value.contains('@') || !value.contains('.')) {
    return 'Enter a valid email';
  }
  return null;
},
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
                      //  Send OTP Button
                      GestureDetector(
                        onTap: () async {
                          if (globKey.currentState!.validate()) {
                            bool ok = await Auth().sendOtp(
                              emailController.text.trim(),
                              context,
                            );
                            if (ok && mounted) {
                              context.push(
                                '/otpScreen',
                                extra: emailController.text.trim(),
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: CustomButton(
                            text: AppLocalizations.of(context)!.sendOtpButton,
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
