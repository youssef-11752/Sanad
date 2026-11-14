import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad/core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text});

  final String text; 

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
      child: Text(
          textAlign: TextAlign.start,
        text,
        style: TextStyle(
          color: AppThemes.cremeyColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
