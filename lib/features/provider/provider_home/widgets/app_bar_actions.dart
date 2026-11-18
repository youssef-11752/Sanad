import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/constants/colors.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 100,
      child: FittedBox(
        alignment: Alignment.centerRight,
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "حساب مقدّم خدمة",
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                    color: DimGray,
                  ),
                ),
                Text(
                  "٠ صباح الخير، أحمد",
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Boxshadowcolor,
                        offset: Offset(5, 5),
                        blurRadius: 5,
                      ),
                    ],
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Cairo",
                    color: DarkTeal,
                  ),
                ),
              ],
            ),
            SizedBox(width: 11),
          ],
        ),
      ),
    );
  }
}
