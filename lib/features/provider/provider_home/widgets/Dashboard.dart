import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/constants/colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,

      children: [

        Container(
          width: 115,
          height: 100,
          decoration: BoxDecoration(
            color: StoneWhite,
            border: Border.all(width: 2, color: Cream),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Boxshadowcolor,
                offset: Offset(5, 5),
                blurRadius: 4,
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "٤.٩",
                style: TextStyle(
                  color: DimGray,
                  fontSize: 24,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 5),

              Text(
                "تقييمك",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: DimGray,
                  fontSize: 13,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        Container(
          width: 115,
          height: 100,
          decoration: BoxDecoration(
            color: StoneWhite,
            border: Border.all(width: 2, color: Cream),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Boxshadowcolor,
                offset: Offset(5, 5),
                blurRadius: 4,
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "٣",
                style: TextStyle(
                  color: DimGray,
                  fontSize: 24,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 5),

              Text(
                "زيارات الأسبوع",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: DimGray,
                  fontSize: 13,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        Container(
          width: 115,
          height: 100,
          decoration: BoxDecoration(
            color: StoneWhite,
            border: Border.all(width: 2, color: Cream),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Boxshadowcolor,
                offset: Offset(5, 5),
                blurRadius: 4,
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "٢",
                style: TextStyle(
                  color: DimGray,
                  fontSize: 24,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 5),

              Text(
                "طلبات متطابقة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: DimGray,
                  fontSize: 13,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      
      ],
    );
  }
}
