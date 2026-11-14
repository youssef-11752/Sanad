import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/data/repo/auth.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_Button.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_appbar.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_appbarText.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_sentince.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_textFormField.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_textLabel.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

class LoginProvider extends StatefulWidget {
  const LoginProvider({super.key});

  @override
  State<LoginProvider> createState() => _LoginProviderState();
}

class _LoginProviderState extends State<LoginProvider> {
  final globKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final idController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    idController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // AppBar
        appBar: AppBar(
          backgroundColor: AppThemes.cremeyColor,
          title: Row(
            children: [
              CustomAppbar(image: 'assets/images/Sanad house · Soft rise.png'),
              CustomAppbartext(text: AppLocalizations.of(context)!.appName),
            ],
          ),
        ),
        backgroundColor: AppThemes.cremeyColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15.h),
              CustomAppbartext(text: AppLocalizations.of(context)!.loginTitle),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),

                child: Text(
                  AppLocalizations.of(context)!.loginSubtitle,
                  style: TextStyle(color: AppThemes.hiAccount),
                ),
              ),
              SizedBox(height: 30.h),
              Form(
                key: globKey,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 2.h,
                    children: [
                      //Email Field
                      SizedBox(height: 10.h),

                      // Email Field
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.email,
                      ),
                      SizedBox(height: 8.h),

                      CustomTextformfield(
                        validator: (value) {
                          if (value == null ||
                              !value.contains('@') ||
                              !value.contains('.')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        controller: emailController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.email_outlined,
                        text: 'example@gmail.com',
                        fillcolor: AppThemes.whiteColor,
                      ),
                      SizedBox(height: 10.h),

                      //Password Field
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.password,
                      ),
                      SizedBox(height: 8.h),
                      CustomTextformfield(
                        isPassword: true,
                        controller: passwordController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.visibility_off_outlined,
                        text: '••••••••',
                        fillcolor: AppThemes.whiteColor,
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),

              //Forget Password
              GestureDetector(
                onTap: () {
                  context.push('/forgetPassword');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    AppLocalizations.of(context)!.forgotPasswordLink,
                    style: TextStyle(
                      color: AppThemes.redColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Login Button
              Padding(
                padding: EdgeInsets.all(8.w),
                child: GestureDetector(
                  onTap: () async {
                    if (globKey.currentState!.validate()) {
                      bool ok = await Auth().login(
                        emailController.text.trim(),
                        passwordController.text,
                        context,
                      );
                      if (ok && mounted) {
                        context.go('/splash');
                      }
                    }
                  },
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.loginButton,
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              //  Privacy
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppThemes.privacyColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppThemes.redColor, width: 1.r),
                  ),
                  child: Row(
                    spacing: 2.h,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/shield-check.png',
                        height: 25.h,
                        width: 25.w,
                      ),
                      Expanded(
                        child: CustomTextlabel(
                          text: AppLocalizations.of(context)!.dataSecurityNote,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 5.h),

              //  New Account
              CustomSentince(
                onTap: () {
                  context.go('/signUp');
                },
                text1: AppLocalizations.of(context)!.firstTimeHere,
                text2: AppLocalizations.of(context)!.createNewAccount,
              ),

              SizedBox(height: 15.h),

              // CopyRight
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context)!.termsAgreementNote,
                  style: TextStyle(color: AppThemes.hiAccount),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
