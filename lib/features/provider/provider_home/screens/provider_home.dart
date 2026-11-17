import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/constants/colors.dart';
import 'package:sanad/features/provider/provider_home/widgets/AppBarActions.dart';
import 'package:sanad/features/provider/provider_home/widgets/BottomNavigationBarWidget.dart';
import 'package:sanad/features/provider/provider_home/widgets/Dashboard.dart';
import 'package:sanad/features/provider/provider_home/widgets/NotificationButton.dart';
import 'package:sanad/features/provider/provider_home/widgets/ProviderInfo.dart';

class ProviderHomePage extends StatelessWidget {
  const ProviderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cream,

      appBar: AppBar(
        backgroundColor: Cream,

        leadingWidth: 70,
        leading: NotificationButton(onPressed: () {}),

        actionsPadding: EdgeInsets.only(right: 15, top: 3),
        actions: [AppBarActions()],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

            child: Column(
              children: [
                SizedBox(height: 20),

                Providerinfo(),

                SizedBox(height: 25),

                Dashboard(),

                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,

                  children: [
                    Text(
                      " ٠ طلبات مناسبة لصنعتك",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Boxshadowcolor,
                            offset: Offset(5, 5),
                            blurRadius: 5,
                          ),
                        ],
                        fontSize: 19,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                        color: DimGray,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, "");
                      },
                      child: Text(
                        "تحديث",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w600,
                          color: Rust,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                Container(
                  width: double.infinity,
                  height: 63,

                  padding: EdgeInsets.only(right: 20, top: 10),

                  decoration: BoxDecoration(
                    color: StoneWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Rust),
                    boxShadow: [
                      BoxShadow(
                        color: Boxshadowcolor,
                        offset: Offset(5, 5),
                        blurRadius: 4,
                      ),
                    ],
                  ),

                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.shield_outlined, color: DarkTeal),

                      SizedBox(width: 10),

                      SizedBox(
                        width: 250,
                        child: Text(
                          "الطلبات هنا مطابقة لتخصصك والمنطقة والمواعيد . فعّلت غسالات وثلاجات فقط.",
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w400,
                            color: DarkTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                Container(
                  width: double.infinity,
                  height: 278,

                  padding: EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: DimGray,
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
                    textDirection: TextDirection.rtl,
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            "SN-2048",
                            style: TextStyle(
                              color: StoneWhite,
                              fontSize: 11,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          Container(
                            width: 105,
                            height: 24,

                            decoration: BoxDecoration(
                              color: Ivory,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Boxshadowcolor,
                                  offset: Offset(5, 5),
                                  blurRadius: 3,
                                ),
                              ],
                            ),

                            child: Center(
                              child: Text(
                                "جديد • بانتظار ردك",

                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      color: Boxshadowcolor,
                                      offset: Offset(5, 5),
                                      blurRadius: 5,
                                    ),
                                  ],
                                  color: Rust,
                                  fontSize: 11,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      Container(
                        alignment: Alignment.centerRight,

                        child: Text(
                          "غسالة لا تصرف المياه",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Boxshadowcolor,
                                offset: Offset(5, 5),
                                blurRadius: 5,
                              ),
                            ],
                            fontSize: 18,
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
                          "مريم حسن • مدينة نصر • على بُعد ٢ كم",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w400,
                            color: StoneWhite,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Container(
                        alignment: Alignment.centerRight,

                        child: Text(
                          "الأحد ٨ نوفمبر • ٤–٦ مساءً",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w400,
                            color: StoneWhite,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Row(
                        textDirection: TextDirection.rtl,

                        children: [
                          Container(
                            width: 93,
                            height: 22,

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

                            child: Center(
                              child: Text(
                                "✓  داخل نطاقك",
                                textDirection: TextDirection.rtl,
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
                            ),
                          ),

                          SizedBox(width: 15),

                          Container(
                            width: 72,
                            height: 22,

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

                            child: Center(
                              child: Text(
                                "✓  غسالات ",
                                textDirection: TextDirection.rtl,
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
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Boxshadowcolor,
                              offset: Offset(5, 5),
                              blurRadius: 3,
                            ),
                          ],
                        ),

                        child: ElevatedButton(
                          onPressed: () {},

                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Rust),
                            minimumSize: WidgetStatePropertyAll(Size(334, 65)),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),

                          child: Text(
                            "عرض الطلب والرد",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Boxshadowcolor,
                                  offset: Offset(5, 5),
                                  blurRadius: 5,
                                ),
                              ],
                              color: Cream,
                              fontSize: 15,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                Container(
                  width: double.infinity,
                  height: 245,

                  padding: EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: StoneWhite,
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
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 84,
                        height: 24,

                        decoration: BoxDecoration(
                          color: Ivory,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Boxshadowcolor,
                              offset: Offset(5, 5),
                              blurRadius: 3,
                            ),
                          ],
                        ),

                        child: Center(
                          child: Text(
                            "جديد • ثلاجات",

                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Boxshadowcolor,
                                  offset: Offset(5, 5),
                                  blurRadius: 5,
                                ),
                              ],
                              color: Rust,
                              fontSize: 11,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Container(
                        alignment: Alignment.centerRight,

                        child: Text(
                          "الثلاجة لا تبرد بشكل كافٍ",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Boxshadowcolor,
                                offset: Offset(5, 5),
                                blurRadius: 5,
                              ),
                            ],
                            fontSize: 18,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w700,
                            color: DarkTeal,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Container(
                        alignment: Alignment.centerRight,

                        child: Text(
                          "نور خالد • مصر الجديدة • SN-2051",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w400,
                            color: DimGray,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Container(
                        alignment: Alignment.centerRight,

                        child: Text(
                          "الاثنين ٩ نوفمبر • ١٢–٢ ظهرًا",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w400,
                            color: DimGray,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(width: 2, color: Cream),
                          color: Beige,
                          boxShadow: [
                            BoxShadow(
                              color: Boxshadowcolor,
                              offset: Offset(5, 5),
                              blurRadius: 3,
                            ),
                          ],
                        ),

                        child: ElevatedButton(
                          onPressed: () {},

                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Beige),
                            minimumSize: WidgetStatePropertyAll(Size(334, 65)),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),

                          child: Text(
                            "عرض التفاصيل",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Boxshadowcolor,
                                  offset: Offset(5, 5),
                                  blurRadius: 5,
                                ),
                              ],
                              color: DimGray,
                              fontSize: 15,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "جودة شغلك هي أحسن توصية. سَنَد معاك.",
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
              
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
