import 'package:flutter/material.dart';
import 'package:flutter_intern_sprint_one/features/clientHomePage/presentation/manager/client_home_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/home_header.dart';
import '../widgets/order_card.dart';
import '../widgets/provider_card.dart';
import '../widgets/service_card.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // get data from the clienthomeprovider
    final homeProvider = context.watch<ClientHomeProvider>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 235, 222),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeHeader(),
                SizedBox(height: 17),
                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'سند اهل الصنعة جمبك',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 191, 245, 152),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.home_repair_service_outlined,
                              color: Color.fromARGB(255, 123, 235, 205),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            Text(
                              'كل عطل، وله أهل صنعة',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              'متخصصين موثوقين لكل خدماتك المنزلية',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFFD5E7DE),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 13),
                      SizedBox(
                        height: 43,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              147,
                              30,
                              21,
                            ),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: Text(
                            'اطلب خدمة دلوقتي',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    const Text(
                      'محتاج إيه النهارده؟',
                      style: TextStyle(
                        color: Color.fromARGB(255, 147, 30, 21),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'كل الخدمات',
                      style: TextStyle(
                        color: Color.fromARGB(255, 147, 30, 21),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                ServiceCards(services: homeProvider.services),

                const SizedBox(height: 22),

                Row(
                  children: [
                    const Text(
                      'طلباتك الحالي',
                      style: TextStyle(
                        color: Color.fromARGB(255, 147, 30, 21),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'متابعة الطلب',
                      style: TextStyle(
                        color: Color.fromARGB(255, 147, 30, 21),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                OrderCards(orders: homeProvider.orders),
                const SizedBox(height: 22),

                Row(
                  children: [
                    const Text(
                      'أفضل خبرة',
                      style: TextStyle(
                        color: Color.fromARGB(255, 147, 30, 21),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'عرض الكل',
                      style: TextStyle(
                        color: Color.fromARGB(255, 147, 30, 21),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                ProviderCards(providers: homeProvider.providers),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
