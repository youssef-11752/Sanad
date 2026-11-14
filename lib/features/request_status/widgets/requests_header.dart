import 'package:flutter/material.dart';
import 'package:sanad/features/request_status/widgets/request_status_colors.dart';

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
