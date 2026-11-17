import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Small fixed-size icon box used as the leading logo in the auth screens' app bars.
class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Fixed box so the icon stays centered regardless of the parent's constraints.
    return Container(
      height: 40.h,
      width: 40.w,
      alignment: Alignment.center,
      child: Icon(Icons.home_repair_service_outlined, size: 24.sp),
    );
  }
}
