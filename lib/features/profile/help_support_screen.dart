import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';

/// Help and support page showing the hotline number with a button to call it.
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const String _supportPhoneNumber = '19555';

  /// Opens the phone dialer. Shows a snackbar if the device cannot place the call.
  Future<void> _callSupport(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final phoneUri = Uri(scheme: 'tel', path: _supportPhoneNumber);

    try {
      final launched = await launchUrl(phoneUri);
      // check mounted because the context may be gone after the await
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.supportCallUnavailable)));
      }
    // launchUrl can throw on devices without a dialer, treat it the same way
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.supportCallUnavailable)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // header row with back button and title, mirrored in RTL
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(18, 5, 18, 0),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: isRtl
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: isRtl
                    ? [
                        _title(context, l10n),
                        const SizedBox(width: 4),
                        IconButton(
                          tooltip: l10n.backButtonTooltip,
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.arrow_forward, size: 19),
                          color: primary,
                        ),
                      ]
                    : [
                        IconButton(
                          tooltip: l10n.backButtonTooltip,
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.arrow_back, size: 19),
                          color: primary,
                        ),
                        const SizedBox(width: 4),
                        _title(context, l10n),
                      ],
              ),
            ),
            // LayoutBuilder + minHeight lets the content center vertically but still scroll on small screens
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.fromSTEB(19, 0, 19, 0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            l10n.supportMessage,
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: 1.35,
                                ).copyWith(
                                  color: primary,
                                  shadows: [
                                    Shadow(
                                      color: isDark
                                          ? Colors.black38
                                          : const Color(0x558A948F),
                                      offset: const Offset(1, 2),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                          ),
                          // the number is always shown left-to-right so the digits are not reversed in Arabic
                          const SizedBox(height: 16),
                          Text(
                            _supportPhoneNumber,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: isDark
                                  ? theme.colorScheme.onSurface
                                  : const Color(0xFF60766D),
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 42),
                          // call button
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () => _callSupport(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red,
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shadowColor: const Color(0x66000000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                              child: Text(
                                l10n.callUs,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Page title with the support subtitle underneath.
  Widget _title(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: Directionality.of(context) == TextDirection.rtl
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          l10n.helpAndSupport,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          l10n.supportSubtitle,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
