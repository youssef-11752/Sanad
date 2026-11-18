import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_colors.dart';

/// A tappable row for the settings list: icon, title and optional subtitle.
class SettingsTile extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.iconAsset,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Icon and text swap sides in RTL, so the order is decided manually below.
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    // Secondary text needs a lighter colour on the dark theme to stay readable.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryTextColor = isDark ? Colors.white60 : AppColors.grey;

    // Title plus optional subtitle; Expanded lets the text take the remaining width.
    final text = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              textAlign: TextAlign.start,
              style: TextStyle(color: secondaryTextColor, fontSize: 9),
            ),
          ],
        ],
      ),
    );

    // Small faded icon shown on the leading side of the row.
    final tileIcon = SvgPicture.asset(
      iconAsset,
      width: 16,
      height: 16,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.65),
        BlendMode.srcIn,
      ),
    );

    // Material + InkWell gives the rounded border and a ripple on tap.
    return Material(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
        side: const BorderSide(color: AppColors.coral, width: 0.8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Row(
            // Icon-first in LTR, text-first in RTL.
            children: isRtl
                ? [text, const SizedBox(width: 10), tileIcon]
                : [tileIcon, const SizedBox(width: 10), text],
          ),
        ),
      ),
    );
  }
}
