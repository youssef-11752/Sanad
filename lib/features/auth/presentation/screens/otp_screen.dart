import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/data/repo/auth.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_Button.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_appbarText.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_textFormField.dart';
import 'package:sanad/features/auth/presentation/widgets/custom_textLabel.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});
  final String email;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final globKey = GlobalKey<FormState>();

  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
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
          title: CustomAppbartext(text: AppLocalizations.of(context)!.otpTitle),
        ),

        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Email Field
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CustomTextlabel(
                    text: AppLocalizations.of(context)!.otpMessage,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Form(
                    key: globKey,
                    child: CustomTextformfield(
                      validator: (value) {
                        if (value == null || value.length != 6) {
                          return 'Enter the 6 digit code';
                        }
                        return null;
                      },
                      controller: otpController,
                      bordercolor: AppThemes.redColor,
                      text: '384591',
                      fillcolor: AppThemes.whiteColor,
                    ),
                  ),
                ),
            
                SizedBox(height: 10.h),
                //  Verify OTP Button
                GestureDetector(
                  onTap: () async {
                    if (globKey.currentState!.validate()) {
                      await Auth().verifyOtp(
                        widget.email,
                        otpController.text,
                        context,
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CustomButton(
                      text: AppLocalizations.of(context)!.verifyOtpButton,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
