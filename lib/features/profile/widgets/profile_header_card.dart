import 'package:material_ui/material_ui.dart';

import '../../../core/app_colors.dart';

/// Teal card at the top of the profile screen showing the user's name, phone,
/// location and an account-type badge.
class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String phone;
  final String location;
  final String accountLabel;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.phone,
    required this.location,
    required this.accountLabel,
  });

  @override
  Widget build(BuildContext context) {
    // Used to flip the badge to the opposite corner in RTL layouts.
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // Name, phone and location stacked; each line is truncated so long values
    // don't break the fixed card height.
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          phone,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
        const SizedBox(height: 2),
        Text(
          location,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white70, fontSize: 9),
        ),
      ],
    );

    // Fixed-height card: details at the top, badge pushed to the bottom corner.
    return Container(
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.teal,
        border: Border.all(color: AppColors.coral, width: 1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          details,
          // Spacer pushes the account badge to the bottom of the card.
          const Spacer(),
          Align(
            alignment: isRtl ? Alignment.bottomLeft : Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                accountLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.coral,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
