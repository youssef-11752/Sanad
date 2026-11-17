import 'package:material_ui/material_ui.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';

/// Shared privacy and service-policy screen for both customer and provider accounts.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final primary = Theme.of(context).colorScheme.primary;
    final muted = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : AppColors.teal.withValues(alpha: 0.82);
    final subtitleColor = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.65);

    // policy text blocks, rendered in this order below the notice
    final sections = <_PolicySectionData>[
      _PolicySectionData(l10n.privacyDataHeading, l10n.privacyDataBody),
      _PolicySectionData(l10n.privacyPhotosHeading, l10n.privacyPhotosBody),
      _PolicySectionData(l10n.privacyBookingHeading, l10n.privacyBookingBody),
      _PolicySectionData(
        l10n.privacyResponsibilitiesHeading,
        l10n.privacyResponsibilitiesBody,
      ),
      _PolicySectionData(
        l10n.privacyCancellationHeading,
        l10n.privacyCancellationBody,
      ),
      _PolicySectionData(
        l10n.privacyRetentionHeading,
        l10n.privacyRetentionBody,
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Directionality(
          // Make policy alignment follow the selected language even when this
          // screen is embedded under a widget with a different direction.
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // title row with back button; order flips in RTL
                      Row(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: isRtl
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: isRtl
                            ? [
                                Text(
                                  l10n.privacyTitle,
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: primary,
                                    size: 18,
                                  ),
                                ),
                              ]
                            : [
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: primary,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.privacyTitle,
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.privacySubtitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: subtitleColor, fontSize: 9),
                      ),
                      const SizedBox(height: 17),
                      // highlighted notice box at the top
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                            color: AppColors.coral,
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Row(
                          textDirection: isRtl
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.shield_outlined,
                              color: primary,
                              size: 16,
                            ),
                            const SizedBox(width: 9),
                            Expanded(
                              child: Text(
                                l10n.privacyNotice,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: muted,
                                  fontSize: 9,
                                  height: 1.55,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 17),
                      // one block per policy section
                      ...sections.map(
                        (section) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _PolicySection(
                            title: section.title,
                            body: section.body,
                            titleColor: primary,
                            bodyColor: muted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // bottom button just closes the screen
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
                child: SizedBox(
                  width: double.infinity,
                  height: 39,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      side: const BorderSide(
                        color: AppColors.coral,
                        width: 0.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      l10n.privacyBack,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple heading/body pair for one policy section.
class _PolicySectionData {
  final String title;
  final String body;
  const _PolicySectionData(this.title, this.body);
}

/// Renders one policy section: bold heading followed by its text.
class _PolicySection extends StatelessWidget {
  final String title;
  final String body;
  final Color titleColor;
  final Color bodyColor;

  const _PolicySection({
    required this.title,
    required this.body,
    required this.titleColor,
    required this.bodyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: titleColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          body,
          textAlign: TextAlign.start,
          style: TextStyle(color: bodyColor, fontSize: 9, height: 1.55),
        ),
      ],
    );
  }
}
