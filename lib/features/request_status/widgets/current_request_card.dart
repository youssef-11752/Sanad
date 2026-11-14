import 'package:flutter/material.dart';
import 'package:sanad/features/request_status/models/request_item.dart';
import 'package:sanad/features/request_status/widgets/request_status_badge.dart';
import 'package:sanad/features/request_status/widgets/request_status_colors.dart';

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
              RequestStatusBadge(
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
