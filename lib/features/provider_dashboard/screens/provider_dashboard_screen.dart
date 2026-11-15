import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/data/repo/auth.dart';
import 'package:sanad/features/auth/presentation/auth_strings.dart';

class ProviderDashboardScreen extends StatelessWidget {
  const ProviderDashboardScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await Auth().signOut();
    if (context.mounted) context.go('/role-selection');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    return Directionality(
      textDirection: strings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(strings.providerDashboard),
          actions: [
            IconButton(
              tooltip: strings.isArabic ? 'تسجيل الخروج' : 'Sign out',
              icon: const Icon(Icons.logout),
              onPressed: () => _signOut(context),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                strings.providerDashboard,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppThemes.greenColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(strings.providerDashboardPending),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppThemes.privacyColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  strings.demoPlaceholder,
                  style: const TextStyle(
                    color: AppThemes.darkGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _MetricCard(
                title: strings.isArabic ? 'الطلبات المتطابقة' : 'Matching requests',
                icon: Icons.inbox_outlined,
              ),
              _MetricCard(
                title: strings.isArabic ? 'زيارات الأسبوع' : 'Visits this week',
                icon: Icons.calendar_month_outlined,
              ),
              _MetricCard(
                title: strings.isArabic ? 'التقييم' : 'Rating',
                icon: Icons.star_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppThemes.greenColor),
        title: Text(title),
        trailing: const Text('—', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
