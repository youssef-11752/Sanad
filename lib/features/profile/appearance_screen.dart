import 'package:material_ui/material_ui.dart';

import '../../core/app_colors.dart';
import '../../core/app_preferences.dart';
import '../../l10n/app_localizations.dart';

/// Lets the user pick light, dark or system theme. The choice is applied instantly
/// through AppThemeController, so the Save button only closes the screen.
class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // rebuild whenever the selected theme changes so the cards and radio stay in sync
    return ValueListenableBuilder<AppThemeChoice>(
      valueListenable: AppThemeController.current,
      builder: (context, selectedTheme, child) {
        // the layout is mirrored by hand for RTL because several rows are forced to LTR
        final isRtl = Directionality.of(context) == TextDirection.rtl;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 34, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context, l10n, isRtl),
                  const SizedBox(height: 24),
                  // the two preview cards: dark on the left, light on the right, regardless of locale
                  Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Expanded(
                        child: _buildThemeCard(
                          context,
                          l10n,
                          AppThemeChoice.dark,
                          selectedTheme,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildThemeCard(
                          context,
                          l10n,
                          AppThemeChoice.light,
                          selectedTheme,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildSystemOption(context, l10n, selectedTheme, isRtl),
                  const SizedBox(height: 16),
                  _buildInfoNote(context, l10n, isRtl),
                  const SizedBox(height: 16),
                  // the theme is already saved on tap, so this just goes back
                  SizedBox(
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Text(
                        l10n.saveAppearance,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Back button, title and subtitle. Order of title/back button flips in RTL.
  Widget _buildHeader(BuildContext context, AppLocalizations l10n, bool isRtl) {
    final primary = Theme.of(context).colorScheme.primary;
    final muted = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.65);
    final backButton = IconButton(
      onPressed: () => Navigator.pop(context),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        isRtl ? Icons.arrow_forward : Icons.arrow_back,
        color: primary,
        size: 18,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: isRtl
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: isRtl
              ? [
                  Text(
                    l10n.appearance,
                    style: TextStyle(
                      color: primary,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  backButton,
                ]
              : [
                  backButton,
                  const SizedBox(width: 8),
                  Text(
                    l10n.appearance,
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
          l10n.appearanceSubtitle,
          textAlign: isRtl ? TextAlign.end : TextAlign.start,
          style: TextStyle(color: muted, fontSize: 10),
        ),
      ],
    );
  }

  /// One preview card (mini mock screen + label + selected badge) for the dark or light theme.
  Widget _buildThemeCard(
    BuildContext context,
    AppLocalizations l10n,
    AppThemeChoice theme,
    AppThemeChoice selectedTheme,
  ) {
    final isDark = theme == AppThemeChoice.dark;
    final brightness = Theme.of(context).brightness;
    // when "system" is chosen, highlight the card that matches the device brightness
    final isSelected =
        selectedTheme == theme ||
        (selectedTheme == AppThemeChoice.system &&
            ((isDark && brightness == Brightness.dark) ||
                (!isDark && brightness == Brightness.light)));
    // hard-coded preview colors so each card looks the same whatever the active theme is
    final previewBackground = isDark
        ? const Color(0xFF0C302B)
        : AppColors.cream;
    final previewBlock = isDark ? const Color(0xFF194B41) : AppColors.card;
    final previewText = isDark ? AppColors.cream : AppColors.teal;
    final previewAccent = isDark ? AppColors.lightTeal : AppColors.teal;
    final borderColor = Theme.of(context).dividerColor;
    final selectedBadgeColor = isDark
        ? const Color(0xFF263D35)
        : const Color(0xFFE4EAD5);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        // tapping the card applies the theme immediately
        onTap: () => AppThemeController.setTheme(theme),
        borderRadius: BorderRadius.circular(15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? previewAccent : borderColor,
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Column(
            children: [
              // miniature mock screen showing how the theme looks
              Container(
                height: 164,
                width: double.infinity,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: previewBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isDark
                          ? Icons.nightlight_outlined
                          : Icons.wb_sunny_outlined,
                      color: previewText,
                      size: 15,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 7,
                      width: 61,
                      decoration: BoxDecoration(
                        color: previewText,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 46,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: previewBlock,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 28,
                            decoration: BoxDecoration(
                              color: previewBlock,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            height: 28,
                            decoration: BoxDecoration(
                              color: previewBlock,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Container(
                      height: 18,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 9),
              Text(
                isDark ? l10n.themeDark : l10n.themeLight,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: selectedBadgeColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    isSelected ? l10n.selected : l10n.notSelected,
                    style: TextStyle(
                      color: previewAccent,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
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

  /// Row for following the device theme setting, with a radio button.
  Widget _buildSystemOption(
    BuildContext context,
    AppLocalizations l10n,
    AppThemeChoice selectedTheme,
    bool isRtl,
  ) {
    final isSelected = selectedTheme == AppThemeChoice.system;
    final primary = Theme.of(context).colorScheme.primary;
    final borderColor = Theme.of(context).dividerColor;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => AppThemeController.setTheme(AppThemeChoice.system),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primary : borderColor,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          // RadioGroup handles the selection state; icon/radio swap sides for RTL
          child: RadioGroup<AppThemeChoice>(
            groupValue: selectedTheme,
            onChanged: (value) {
              if (value != null) {
                AppThemeController.setTheme(value);
              }
            },
            child: Row(
              children: isRtl
                  ? [
                      Icon(
                        Icons.phone_iphone,
                        color: Theme.of(context).colorScheme.primary,
                        size: 17,
                      ),
                      const SizedBox(width: 7),
                      Expanded(child: _systemOptionText(context, l10n)),
                      Radio<AppThemeChoice>(
                        value: AppThemeChoice.system,
                        activeColor: primary,
                        visualDensity: VisualDensity.compact,
                      ),
                    ]
                  : [
                      Radio<AppThemeChoice>(
                        value: AppThemeChoice.system,
                        activeColor: primary,
                        visualDensity: VisualDensity.compact,
                      ),
                      Expanded(child: _systemOptionText(context, l10n)),
                      const SizedBox(width: 7),
                      Icon(
                        Icons.phone_iphone,
                        color: Theme.of(context).colorScheme.primary,
                        size: 17,
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }

  // title and description text of the system option
  Widget _systemOptionText(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.themeSystem,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          l10n.themeSystemDescription,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  /// Small note at the bottom explaining the appearance privacy message.
  Widget _buildInfoNote(
    BuildContext context,
    AppLocalizations l10n,
    bool isRtl,
  ) {
    final noteColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF263D35)
        : const Color(0xFFE5EBD8);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      decoration: BoxDecoration(
        color: noteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Expanded(
            child: Text(
              l10n.appearancePrivacyNote,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 9,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Icon(
            Icons.shield_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 17,
          ),
        ],
      ),
    );
  }
}
