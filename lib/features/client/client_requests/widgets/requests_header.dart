import 'package:material_ui/material_ui.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_colors.dart';

/// Top bar of the requests screen: back button plus title and subtitle.
class RequestsHeader extends StatelessWidget {
  const RequestsHeader({
    required this.title,
    required this.subtitle,
    required this.isArabic,
    required this.backLabel,
    required this.onBack,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool isArabic;
  final String backLabel;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: backLabel,
          onPressed: onBack,
          icon: Icon(
            // Flip the back arrow in Arabic so it points in the reading direction.
            isArabic ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
            color: requestTealColor,
            size: 19,
          ),
        ),
        const SizedBox(width: 8),
        // Expanded lets the text block take the remaining width next to the button.
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
              // Subtitle stays on one line and is cut with an ellipsis if it is too long.
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
