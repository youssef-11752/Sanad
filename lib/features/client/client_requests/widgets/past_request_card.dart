import 'package:material_ui/material_ui.dart';
import 'package:sanad/features/client/client_requests/models/request_item.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_badge.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_colors.dart';

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
                  child: RequestStatusBadge(
                    label: statusLabel,
                    backgroundColor: requestStatusColor,
                    foregroundColor: requestTealColor,
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
            style: const TextStyle(color: requestMutedColor, fontSize: 9),
          ),
        ],
      ),
    );
  }
}
