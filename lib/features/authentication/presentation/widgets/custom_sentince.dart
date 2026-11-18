import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSentince extends StatelessWidget {
  const CustomSentince({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  final String text1;
  final String text2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text1, style: TextStyle(fontSize: 11.sp)),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppThemes.greenColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
