import 'package:flutter/material.dart';
import 'package:sanad/features/request_status/widgets/request_status_colors.dart';

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
