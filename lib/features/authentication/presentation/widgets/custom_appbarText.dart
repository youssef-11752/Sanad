import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Large green title text for the app bar area of auth screens.
class CustomAppbartext extends StatelessWidget {
  const CustomAppbartext({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Text(
        // Follow the ambient text direction so Arabic (RTL) and English (LTR) both align correctly.
        textAlign: TextAlign.start,
        textDirection: Directionality.of(context),
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppThemes.greenColor,
          fontSize: 25.sp,
        ),
      ),
    );
  }
}
