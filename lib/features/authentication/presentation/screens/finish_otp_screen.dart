import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_Button.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_sentince.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Last step of the password reset: confirms success and sends the user
/// back to the login screen for their role.
class FinishOtpScreen extends StatelessWidget {
  const FinishOtpScreen({this.role = 'customer', super.key});

  final String role;

  // Provider and customer have separate login routes.
  String get _loginRoute =>
      role == 'provider' ? '/login/provider' : '/login/customer';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppThemes.cremeyColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSentince(
              onTap: () {
                context.go(_loginRoute);
              },
              text1: AppLocalizations.of(context)!.passwordResetSuccessPrefix,
              text2: AppLocalizations.of(context)!.loginButton,
            ),
            SizedBox(height: 10.h),

            GestureDetector(
              onTap: () {
                context.go(_loginRoute);
              },
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomButton(
                  text: AppLocalizations.of(context)!.goToLoginButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
