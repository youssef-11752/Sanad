import 'package:material_ui/material_ui.dart';
import 'package:sanad/features/authentication/data/repo/auth.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_button.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_appbar_text.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_sentince.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_text_label.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/core/widgets/custom_snak_bar.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cityController.dispose();
    regionController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (isLoading) return;
    if (!globKey.currentState!.validate()) return;

    if (!isChecked) {
      customSnakbar(context, 'Please Accept Privacy Policy', Colors.red);
      return;
    }

    setState(() => isLoading = true);
    final ok = await Auth().signup(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      city: cityController.text.trim(),
      region: regionController.text.trim(),
      password: passwordController.text,
      context: context,
    );
    if (!mounted) return;
    setState(() => isLoading = false);

    if (ok) {
      if (Supabase.instance.client.auth.currentUser != null) {
        context.go('/customer/management');
      } else {
        context.go('/loginUser');
      }
    }
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
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.fullName,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        validator: Validators.name,
                        controller: nameController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.person,
                        text: AppLocalizations.of(context)!.hintFullName,
                        fillcolor: AppThemes.whiteColor,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.email,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        validator: Validators.email,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.email_outlined,
                        text: AppLocalizations.of(context)!.hintEmail,
                        fillcolor: AppThemes.whiteColor,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextlabel(text: AppLocalizations.of(context)!.city),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        validator: Validators.city,
                        controller: cityController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.location_on_outlined,
                        text: AppLocalizations.of(context)!.hintCity,
                        fillcolor: AppThemes.whiteColor,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextlabel(text: AppLocalizations.of(context)!.area),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        validator: Validators.area,
                        controller: regionController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.location_on_outlined,
                        text: AppLocalizations.of(context)!.hintArea,
                        fillcolor: AppThemes.whiteColor,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.password,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        validator: Validators.password,
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
              Padding(
                padding: EdgeInsets.all(8.w),
                child: GestureDetector(
                  onTap: _signup,
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.createAccountButton,
                    isLoading: isLoading,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
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
