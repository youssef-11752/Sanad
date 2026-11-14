import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad/core/theme/colors.dart';

class CustomTextlabel extends StatelessWidget {
  const CustomTextlabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Text(
        textAlign: TextAlign.start,
        text,
        style: TextStyle(
          color: AppThemes.greenColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
