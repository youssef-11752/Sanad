import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/auth/presentation/auth_strings.dart';
import 'package:sanad/features/type_selection/role_model.dart';
import 'package:sanad/features/type_selection/type_provider.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _continue(BuildContext context, UserRoleType role) {
    context.go(role == UserRoleType.provider ? '/login/provider' : '/login/customer');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    final roleProvider = context.watch<RoleSelectionProvider>();

    return Directionality(
      textDirection: strings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppThemes.cremeyColor,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        strings.appName,
                        style: const TextStyle(
                          color: AppThemes.greenColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      strings.chooseRole,
                      style: const TextStyle(
                        color: AppThemes.greenColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(strings.chooseRoleSubtitle),
                    const SizedBox(height: 28),
                    _RoleCard(
                      title: strings.customer,
                      subtitle: strings.isArabic
                          ? 'اطلب صيانة، اختار متخصص، وتابع الزيارة.'
                          : 'Request a service, choose a specialist and track the visit.',
                      icon: Icons.home_repair_service_outlined,
                      selected: roleProvider.selectedRole == UserRoleType.client,
                      onTap: () => roleProvider.selectRole(UserRoleType.client),
                    ),
                    const SizedBox(height: 14),
                    _RoleCard(
                      title: strings.provider,
                      subtitle: strings.isArabic
                          ? 'حدد صنعتك واستقبل طلبات تناسب خبرتك.'
                          : 'Set your specialty and receive matching requests.',
                      icon: Icons.handyman_outlined,
                      selected: roleProvider.selectedRole == UserRoleType.provider,
                      onTap: () => roleProvider.selectRole(UserRoleType.provider),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: () => _continue(context, roleProvider.selectedRole),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppThemes.redColor,
                          foregroundColor: AppThemes.whiteColor,
                        ),
                        child: Text(
                          roleProvider.selectedRole == UserRoleType.provider
                              ? strings.continueAsProvider
                              : strings.continueAsCustomer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      strings.isArabic
                          ? 'بيوت متطمنة، وصنايعية محل ثقة'
                          : 'Trusted professionals for every home',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppThemes.hiAccount),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFE3E8D4) : AppThemes.whiteColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppThemes.greenColor : AppThemes.darkCremey,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 30, color: AppThemes.greenColor),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    const SizedBox(height: 6),
                    Text(subtitle, style: const TextStyle(color: AppThemes.hiAccount)),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? AppThemes.greenColor : AppThemes.hiAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
