import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/authentication/presentation/auth_strings.dart';
import 'package:sanad/features/type_selection/role_model.dart';
import 'package:sanad/features/type_selection/type_provider.dart';

/// First screen after onboarding: the user picks whether they are a customer
/// or a service provider, then continues to the matching login page.
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  // Both roles share the login flow but use different routes.
  void _continue(BuildContext context, UserRoleType role) {
    context.go(
      role == UserRoleType.provider ? '/login/provider' : '/login/customer',
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AuthStrings.of(context);
    // watch() rebuilds this screen whenever the selected role changes.
    final roleProvider = context.watch<RoleSelectionProvider>();

    // Layout direction follows the language (Arabic is right-to-left).
    return Directionality(
      textDirection: strings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppThemes.cremeyColor,
        body: SafeArea(
          child: Center(
            // Centered with a max width so it looks fine on tablets and web too.
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      strings.appName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppThemes.greenColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
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
                    Text(
                      strings.chooseRoleSubtitle,
                      style: const TextStyle(color: AppThemes.hiAccount),
                    ),
                    const SizedBox(height: 28),
                    // Customer card; texts are hardcoded per language here.
                    _RoleCard(
                      title: strings.isArabic ? 'محتاج خدمة' : strings.customer,
                      subtitle: strings.isArabic
                          ? 'اطلب صيانة، اختار متخصص، وتابع الزيارة.'
                          : 'Request a service, choose a specialist and track the visit.',
                      icon: Icons.home_repair_service_outlined,
                      selected:
                          roleProvider.selectedRole == UserRoleType.client,
                      selectedLabel: strings.isArabic
                          ? 'العميل - محدد'
                          : 'Customer - selected',
                      onTap: () => roleProvider.selectRole(UserRoleType.client),
                    ),
                    const SizedBox(height: 14),
                    // Provider card.
                    _RoleCard(
                      title: strings.isArabic
                          ? 'أنا مقدم خدمة'
                          : strings.provider,
                      subtitle: strings.isArabic
                          ? 'حدد صنعتك واستقبل طلبات تناسب خبرتك.'
                          : 'Set your specialty and receive matching requests.',
                      icon: Icons.handyman_outlined,
                      selected:
                          roleProvider.selectedRole == UserRoleType.provider,
                      selectedLabel: strings.isArabic
                          ? 'مقدم الخدمة - محدد'
                          : 'Provider - selected',
                      onTap: () =>
                          roleProvider.selectRole(UserRoleType.provider),
                    ),
                    const SizedBox(height: 24),
                    // The button label and destination depend on the currently selected role.
                    SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: () =>
                            _continue(context, roleProvider.selectedRole),
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

/// Selectable card for one role. Highlights with a red border when selected.
class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.selectedLabel,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final String selectedLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppThemes.greenColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? AppThemes.redColor : AppThemes.greenColor,
              width: selected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppThemes.darkGreen.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 30, color: AppThemes.cremeyColor),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppThemes.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(color: AppThemes.privacyColor),
                    ),
                    // The "selected" badge only shows on the chosen card.
                    if (selected) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppThemes.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          selectedLabel,
                          style: const TextStyle(
                            color: AppThemes.redColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Radio-style indicator on the trailing side.
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: AppThemes.cremeyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
