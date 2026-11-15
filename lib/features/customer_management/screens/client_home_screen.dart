import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad/features/customer_management/client_home_provider.dart';
import 'package:sanad/features/customer_management/widgets/home_header.dart';
import 'package:sanad/features/customer_management/widgets/order_card.dart';
import 'package:sanad/features/customer_management/widgets/provider_card.dart';
import 'package:sanad/features/customer_management/widgets/service_card.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<ClientHomeProvider>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F0DC),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const HomeHeader(),
                const SizedBox(height: 17),
                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00564F),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'سند أهل الصنعة جنبك',
                        style: TextStyle(color: Color(0xFFBFF598), fontSize: 14),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'كل عطل، وله أهل صنعة',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'متخصصين موثوقين لكل خدماتك المنزلية',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Color(0xFFD5E7DE), fontSize: 10),
                      ),
                      const SizedBox(height: 13),
                      SizedBox(
                        height: 43,
                        child: FilledButton(
                          onPressed: () => context.go('/customer/categories'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFC63922),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('اطلب خدمة دلوقتي'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'محتاج إيه النهارده؟',
                      style: TextStyle(
                        color: Color(0xFFC63922),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.go('/customer/categories'),
                      child: const Text('كل الخدمات'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ServiceCards(services: homeProvider.services),
                const SizedBox(height: 22),
                const Text(
                  'طلباتك الحالية',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFFC63922),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                OrderCards(orders: homeProvider.orders),
                const SizedBox(height: 22),
                const Text(
                  'أهل خبرة قريبين منك',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFFC63922),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ProviderCards(providers: homeProvider.providers),
                const SizedBox(height: 12),
                const Text(
                  'ملاحظة: بيانات الطلبات ومقدمي الخدمة المعروضة هنا تجريبية لحين ربطها بـ Supabase.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
