import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/core/widgets/custom_SnakBar.dart';
import 'package:sanad/features/auth/data/repo/auth.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_Button.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_appbarText.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_sentince.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_textFormField.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_textLabel.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final globKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final regionController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cityController.dispose();
    regionController.dispose();
    passwordController.dispose();
    super.dispose();
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
            text: AppLocalizations.of(context)!.registerTitle,
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  AppLocalizations.of(context)!.registerSubtitle,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Form(
                key: globKey,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name Field
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.fullName,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        controller: nameController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.person,
                        text: AppLocalizations.of(context)!.hintFullName,
                        fillcolor: AppThemes.whiteColor,
                      ),

                      SizedBox(height: 15.h),

                      // Email Field
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.email,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        controller: emailController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.email_outlined,
                        text: AppLocalizations.of(context)!.hintEmail,
                        fillcolor: AppThemes.whiteColor,
                      ),

                      SizedBox(height: 15.h),

                      // City Field
                      CustomTextlabel(text: AppLocalizations.of(context)!.city),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        controller: cityController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.location_on_outlined,
                        text: AppLocalizations.of(context)!.hintCity,
                        fillcolor: AppThemes.whiteColor,
                      ),

                      SizedBox(height: 15.h),

                      // Region Field
                      CustomTextlabel(text: AppLocalizations.of(context)!.area),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        controller: regionController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.location_on_outlined,
                        text: AppLocalizations.of(context)!.hintArea,
                        fillcolor: AppThemes.whiteColor,
                      ),

                      SizedBox(height: 15.h),

                      // Password Field
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.password,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                        isPassword: true,
                        controller: passwordController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.visibility_off_outlined,
                        text: '••••••••',
                        fillcolor: AppThemes.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              // Privacy Checkbox
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        AppLocalizations.of(context)!.agreeToPrivacyAndTerms,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppThemes.greenColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Create Account Button
              Padding(
                padding: EdgeInsets.all(8.w),
                child: GestureDetector(
                  onTap: () async {
                    if (globKey.currentState!.validate()) {
                      if (!isChecked) {
                        customSnakbar(
                          context,
                          'Please Accept Privacy Policy',
                          Colors.red,
                        );
                        return;
                      }
                      bool ok = await Auth().signup(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        cityController.text.trim(),
                        regionController.text.trim(),
                        passwordController.text,
                        context,
                      );
                      if (ok && mounted) {
                        context.push('/loginUser');
                      }
                    }
                  },
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.createAccountButton,
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // Do You Have Account
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomSentince(
                  onTap: () => context.go('/loginUser'),
                  text1: AppLocalizations.of(context)!.haveAccount,
                  text2: AppLocalizations.of(context)!.loginButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
