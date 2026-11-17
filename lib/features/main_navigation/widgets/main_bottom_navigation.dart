import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

// the four tabs of the bottom bar, in display order
enum MainNavigationDestination { home, categories, requests, account }

/// Shared bottom navigation bar for customer and provider shells.
/// The same four slots are used for both roles; only the labels and routes differ.
class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({
    required this.selectedDestination,
    this.isProvider = false,
    super.key,
  });

  final MainNavigationDestination selectedDestination;
  final bool isProvider;

  @override
  Widget build(BuildContext context) {
    // labels and icons are index-aligned with MainNavigationDestination.values
    final localizations = AppLocalizations.of(context)!;
    const destinations = MainNavigationDestination.values;
    final labels = [
      localizations.homeNavigation,
      isProvider
          ? localizations.providerServicesNavigation
          : localizations.categoriesNavigation,
      isProvider
          ? localizations.providerOrdersNavigation
          : localizations.myRequestsNavigation,
      localizations.accountNavigation,
    ];
    const icons = [
      Icons.home_outlined,
      Icons.grid_view_outlined,
      Icons.receipt_long_outlined,
      Icons.person_outline,
    ];

    // white bar with a thin top border, padded for the system gesture area
    return Container(
      decoration: const BoxDecoration(
        color: AppThemes.whiteColor,
        border: Border(top: BorderSide(color: AppThemes.darkCremey)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              // build one tab per destination
              for (var index = 0; index < destinations.length; index++)
                Expanded(
                  child: _NavigationItem(
                    icon: icons[index],
                    label: labels[index],
                    isSelected: selectedDestination == destinations[index],
                    onTap: () => _selectDestination(
                      context,
                      destinations[index],
                      localizations,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the route that matches the tapped tab, depending on the user role.
  void _selectDestination(
    BuildContext context,
    MainNavigationDestination destination,
    AppLocalizations localizations,
  ) {
    switch (destination) {
      case MainNavigationDestination.home:
        context.go(isProvider ? '/provider/dashboard' : '/customer/management');
        return;
      // providers do not have this page yet, so they only get a snackbar
      case MainNavigationDestination.categories:
        if (isProvider) {
          _showComingSoon(context, localizations);
        } else {
          context.go('/customer/categories');
        }
        return;
      case MainNavigationDestination.requests:
        if (isProvider) {
          _showComingSoon(context, localizations);
        } else {
          context.go('/customer/requests');
        }
        return;
      case MainNavigationDestination.account:
        context.go(isProvider ? '/provider/profile' : '/customer/profile');
    }
  }

  // placeholder feedback for provider tabs that are not built yet
  void _showComingSoon(BuildContext context, AppLocalizations localizations) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(localizations.navigationComingSoon)));
  }
}

// single tab item: icon + label, with a small underline when selected
class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // selected tab uses the brand green, the others a muted color
    const selectedColor = AppThemes.greenColor;
    const inactiveColor = AppThemes.hiAccount;
    final color = isSelected ? selectedColor : inactiveColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 48,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
              // small indicator bar under the label of the active tab
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  width: 14,
                  height: 2,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
