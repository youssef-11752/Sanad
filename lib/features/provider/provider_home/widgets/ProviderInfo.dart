import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/constants/colors.dart';

class Providerinfo extends StatelessWidget {
  const Providerinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,

      padding: EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: DarkTeal,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Boxshadowcolor, offset: Offset(5, 5), blurRadius: 4),
        ],
      ),

      child: Column(
        // textDirection: TextDirection.rtl,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Icon(Icons.home_filled, color: Champagane, size: 35),

              Flexible(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 141),
                  height: 24,
                  decoration: BoxDecoration(
                    color: StoneWhite,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Boxshadowcolor,
                        offset: Offset(5, 5),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        " ●",
                        style: TextStyle(
                          color: Rust,
                          fontSize: 11,
                          shadows: [
                            Shadow(
                              color: Boxshadowcolor,
                              offset: Offset(5, 5),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "متاح لاستقبال الطلبات",
                        style: TextStyle(
                          shadows: [
                            Shadow(
                              color: Boxshadowcolor,
                              offset: Offset(5, 5),
                              blurRadius: 5,
                            ),
                          ],
                          color: DarkTeal,
                          fontSize: 11,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          Container(
            alignment: Alignment.centerRight,

            child: Text(
              "غسالات وثلاجات فقط",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                shadows: [
                  Shadow(
                    color: Boxshadowcolor,
                    offset: Offset(5, 5),
                    blurRadius: 5,
                  ),
                ],
                fontSize: 25,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700,
                color: Cream,
              ),
            ),
          ),

          SizedBox(height: 15),

          Container(
            alignment: Alignment.centerRight,

            child: Text(
              "الأجهزة المنزلية • مدينة نصر ومصر الجديدة",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w400,
                color: Cream,
              ),
            ),
          ),

          SizedBox(height: 15),

          Container(
            alignment: Alignment.centerRight,

            child: Text(
              "السبت–الخميس • ١٠ ص – ٨ م •",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w400,
                color: Cream,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
