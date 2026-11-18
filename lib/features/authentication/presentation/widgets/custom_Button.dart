import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.isLoading = false});

  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 54.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppThemes.redColor,
      ),
      child: isLoading
          ? SizedBox(
              height: 24.h,
              width: 24.h,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppThemes.cremeyColor,
              ),
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppThemes.cremeyColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
