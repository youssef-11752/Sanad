import 'package:material_ui/material_ui.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_colors.dart';

/// Two-tab switcher between current and previous requests.
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
        // Each tab gets half the row; the second one is selected when the first is not.
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

/// Single pill-shaped tab; the selected one is filled red, the other outlined.
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
