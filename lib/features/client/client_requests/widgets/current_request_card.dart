import 'package:material_ui/material_ui.dart';
import 'package:sanad/features/client/client_requests/models/request_item.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_badge.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_colors.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

class CurrentRequestCard extends StatelessWidget {
  const CurrentRequestCard({
    required this.request,
    required this.statusLabel,
    this.onDelete,
    this.isDeleting = false,
    super.key,
  });

  final RequestItem request;
  final String statusLabel;
  final VoidCallback? onDelete;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

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
              if (request.canDelete && onDelete != null)
                IconButton(
                  tooltip: localizations.deleteRequestTooltip,
                  onPressed: isDeleting ? null : onDelete,
                  icon: isDeleting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(
                          Icons.delete_outline,
                          color: requestMutedColor,
                          size: 18,
                        ),
                ),
              const Spacer(),
              RequestStatusBadge(
                label: statusLabel,
                backgroundColor: requestStatusColor,
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
