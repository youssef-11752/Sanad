import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:sanad/features/authentication/data/repo/auth.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_button.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_appbar_text.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:sanad/features/authentication/presentation/widgets/custom_text_label.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final globKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (isLoading) return;
    if (!globKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    await Auth().verifyOtp(widget.email, otpController.text, context);
    if (!mounted) return;
    setState(() => isLoading = false);
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
                      validator: Validators.otp,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      controller: otpController,
                      bordercolor: AppThemes.redColor,
                      text: '384591',
                      fillcolor: AppThemes.whiteColor,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: _verify,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CustomButton(
                      text: AppLocalizations.of(context)!.verifyOtpButton,
                      isLoading: isLoading,
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
