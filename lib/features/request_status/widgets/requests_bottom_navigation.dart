import 'package:flutter/material.dart';
import 'package:sanad/features/request_status/widgets/request_status_colors.dart';

class RequestsBottomNavigation extends StatelessWidget {
  const RequestsBottomNavigation({
    required this.homeLabel,
    required this.categoriesLabel,
    required this.requestsLabel,
    required this.accountLabel,
    super.key,
  });

  final String homeLabel;
  final String categoriesLabel;
  final String requestsLabel;
  final String accountLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: requestCardColor,
        border: Border(top: BorderSide(color: requestBorderColor)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          _BottomNavigationItem(icon: Icons.home_outlined, label: homeLabel),
          _BottomNavigationItem(
            icon: Icons.grid_view_outlined,
            label: categoriesLabel,
          ),
          _BottomNavigationItem(
            icon: Icons.receipt_long_outlined,
            label: requestsLabel,
            isSelected: true,
          ),
          _BottomNavigationItem(
            icon: Icons.person_outline,
            label: accountLabel,
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? requestRedColor : requestMutedColor;

    return Expanded(
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
                color: requestRedColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}
