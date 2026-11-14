import 'package:flutter/material.dart';

enum MainNavigationDestination { home, categories, requests, account }

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({
    required this.selectedDestination,
    required this.onDestinationSelected,
    required this.homeLabel,
    required this.categoriesLabel,
    required this.requestsLabel,
    required this.accountLabel,
    super.key,
  });

  final MainNavigationDestination selectedDestination;
  final ValueChanged<MainNavigationDestination> onDestinationSelected;
  final String homeLabel;
  final String categoriesLabel;
  final String requestsLabel;
  final String accountLabel;

  @override
  Widget build(BuildContext context) {
    const destinations = MainNavigationDestination.values;
    final labels = [homeLabel, categoriesLabel, requestsLabel, accountLabel];
    const icons = [
      Icons.home_outlined,
      Icons.grid_view_outlined,
      Icons.receipt_long_outlined,
      Icons.person_outline,
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFCF5),
        border: Border(top: BorderSide(color: Color(0xFFE8D9B9))),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              for (var index = 0; index < destinations.length; index++)
                Expanded(
                  child: _NavigationItem(
                    icon: icons[index],
                    label: labels[index],
                    isSelected: selectedDestination == destinations[index],
                    onTap: () => onDestinationSelected(destinations[index]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    const selectedColor = Color(0xFFC63A26);
    const inactiveColor = Color(0xFF888A7F);
    final color = isSelected ? selectedColor : inactiveColor;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
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
    );
  }
}
