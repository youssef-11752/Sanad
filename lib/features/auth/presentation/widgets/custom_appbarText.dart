import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad/core/theme/colors.dart';

class CustomAppbartext extends StatelessWidget {
  const CustomAppbartext({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8.w),
      child: Text(
        textAlign: TextAlign.start,
        textDirection: Directionality.of(context),
        text ,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppThemes.greenColor,
          fontSize: 25.sp,
        ),
      ),
    );
  }
}
