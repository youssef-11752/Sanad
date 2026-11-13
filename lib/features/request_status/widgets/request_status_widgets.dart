import 'package:flutter/material.dart';
import 'package:sanad/features/request_status/models/request_item.dart';

const requestPageColor = Color(0xFFFBF3DF);
const requestCardColor = Color(0xFFFFFCF5);
const requestTealColor = Color(0xFF0D554E);
const requestRedColor = Color(0xFFC63A26);
const requestBorderColor = Color(0xFFE8D9B9);
const requestMutedColor = Color(0xFF888A7F);

class RequestsHeader extends StatelessWidget {
  const RequestsHeader({
    required this.title,
    required this.subtitle,
    required this.isArabic,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isArabic ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
          color: requestTealColor,
          size: 19,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: requestTealColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: requestMutedColor.withValues(alpha: 0.9),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RequestsTabs extends StatelessWidget {
  const RequestsTabs({
    required this.currentLabel,
    required this.previousLabel,
    required this.currentSelected,
    required this.onCurrentSelected,
    required this.onPreviousSelected,
    super.key,
  });

  final String currentLabel;
  final String previousLabel;
  final bool currentSelected;
  final VoidCallback onCurrentSelected;
  final VoidCallback onPreviousSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _RequestTabButton(
            label: currentLabel,
            isSelected: currentSelected,
            onTap: onCurrentSelected,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _RequestTabButton(
            label: previousLabel,
            isSelected: !currentSelected,
            onTap: onPreviousSelected,
          ),
        ),
      ],
    );
  }
}

class RequestSectionTitle extends StatelessWidget {
  const RequestSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: requestTealColor,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class CurrentRequestCard extends StatelessWidget {
  const CurrentRequestCard({
    required this.request,
    required this.statusLabel,
    super.key,
  });

  final RequestItem request;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: requestCardColor,
        border: Border.all(color: requestBorderColor),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                request.id,
                style: const TextStyle(color: requestMutedColor, fontSize: 9),
              ),
              const Spacer(),
              _StatusBadge(
                label: statusLabel,
                backgroundColor: const Color(0xFFE5EED9),
                foregroundColor: requestTealColor,
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            request.title,
            style: const TextStyle(
              color: requestTealColor,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            request.provider,
            style: const TextStyle(color: requestMutedColor, fontSize: 10),
          ),
          const SizedBox(height: 3),
          Text(
            request.date,
            style: const TextStyle(color: requestMutedColor, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class PastRequestCard extends StatelessWidget {
  const PastRequestCard({
    required this.request,
    required this.statusLabel,
    super.key,
  });

  final RequestItem request;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    final statusColor = request.isCancelled
        ? const Color(0xFFF9E0D0)
        : const Color(0xFFE5EED9);
    final statusTextColor = request.isCancelled
        ? requestRedColor
        : requestTealColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: requestCardColor,
        border: Border.all(color: requestBorderColor),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                request.id,
                style: const TextStyle(color: requestMutedColor, fontSize: 9),
              ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _StatusBadge(
                    label: statusLabel,
                    backgroundColor: statusColor,
                    foregroundColor: statusTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            request.title,
            style: const TextStyle(
              color: requestTealColor,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            request.provider,
            style: const TextStyle(color: requestMutedColor, fontSize: 9),
          ),
          const SizedBox(height: 2),
          Text(
            request.date,
            style: TextStyle(
              color: request.isCancelled ? requestRedColor : requestMutedColor,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

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

class _RequestTabButton extends StatelessWidget {
  const _RequestTabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : requestTealColor,
          backgroundColor: isSelected ? requestRedColor : requestCardColor,
          side: BorderSide(
            color: isSelected ? requestRedColor : requestBorderColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 8,
          fontWeight: FontWeight.w700,
        ),
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
