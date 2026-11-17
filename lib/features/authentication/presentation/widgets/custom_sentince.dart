import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// One-line prompt with a tappable action, e.g. "Don't have an account? Sign up".
/// text1 is the plain prompt, text2 is the green link-style button.
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
          // Zero padding and shrink-wrapped tap target so the link sits right next to the plain text.
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
