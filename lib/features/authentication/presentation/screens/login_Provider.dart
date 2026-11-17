import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/authentication/data/repo/auth.dart';
import 'package:sanad/features/authentication/presentation/auth_strings.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_Button.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_appbar.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_appbarText.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_textFormField.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_textLabel.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Login screen for service providers. There is no signup link because
/// provider accounts are created by the admin.
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

  bool isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    idController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // expectedRole makes Auth reject accounts that are not providers.
  Future<void> _login() async {
    if (isLoading) return;
    if (!globKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    final ok = await Auth().login(
      email: emailController.text.trim(),
      password: passwordController.text,
      expectedRole: 'provider',
      context: context,
    );
    if (!mounted) return;
    setState(() => isLoading = false);

    // Verified provider: go to the dashboard.
    if (ok) context.go('/provider/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppThemes.cremeyColor,
          title: Row(
            children: [
              const CustomAppbar(),
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
                      SizedBox(height: 10.h),
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.email,
                      ),
                      SizedBox(height: 8.h),
                      CustomTextformfield(
                        validator: Validators.email,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        bordercolor: AppThemes.redColor,
                        icon: Icons.email_outlined,
                        text: 'example@gmail.com',
                        fillcolor: AppThemes.whiteColor,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextlabel(
                        text: AppLocalizations.of(context)!.password,
                      ),
                      SizedBox(height: 8.h),
                      CustomTextformfield(
                        validator: Validators.loginPassword,
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
              GestureDetector(
                onTap: () => context.push('/forgot-password/provider'),
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
              Padding(
                padding: EdgeInsets.all(8.w),
                child: GestureDetector(
                  onTap: _login,
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.loginButton,
                    isLoading: isLoading,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Small notice box explaining how the user's data is protected.
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
                      SizedBox(
                        height: 25.h,
                        width: 25.w,
                        child: Icon(
                          Icons.shield_outlined,
                          color: AppThemes.greenColor,
                          size: 22.sp,
                        ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  AuthStrings.of(context).providerSignupManaged,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppThemes.hiAccount, fontSize: 12.sp),
                ),
              ),
              SizedBox(height: 15.h),
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
