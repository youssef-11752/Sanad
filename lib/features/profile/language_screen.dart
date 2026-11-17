import 'package:material_ui/material_ui.dart';

import '../../core/app_colors.dart';
import '../../core/app_preferences.dart';
import '../../l10n/app_localizations.dart';

/// Language picker. The page previews the selected language right away (text and direction),
/// but the app locale only changes when the user presses save.
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // locale chosen on this screen, not yet applied app-wide
  late Locale selectedLocale;

  @override
  void initState() {
    super.initState();
    // start from whatever language the app is using now
    selectedLocale = AppLocaleController.current.value;
  }

  @override
  Widget build(BuildContext context) {
    // override localizations locally so the whole screen previews the selected language
    return Localizations.override(
      context: context,
      locale: selectedLocale,
      child: Builder(
        builder: (previewContext) {
          final l10n = AppLocalizations.of(previewContext)!;
          // Arabic is the only RTL language supported
          final isRtl = selectedLocale.languageCode == 'ar';
          final isDark = Theme.of(previewContext).brightness == Brightness.dark;
          final primaryColor = Theme.of(previewContext).colorScheme.primary;
          final textColor = Theme.of(previewContext).colorScheme.onSurface;
          final cardColor = Theme.of(previewContext).cardColor;

          // flip the layout direction to match the previewed language
          return Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              backgroundColor: Theme.of(previewContext).scaffoldBackgroundColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(previewContext, l10n, isRtl, primaryColor),
                      const SizedBox(height: 34),
                      Icon(Icons.translate, size: 48, color: primaryColor),
                      const SizedBox(height: 14),
                      Text(
                        l10n.languageSlogan,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.languageDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white60 : AppColors.grey,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 36),
                      // one option per supported language
                      _languageOption(
                        title: l10n.arabicLanguage,
                        subtitle: l10n.arabicLanguageDirection,
                        locale: const Locale('ar'),
                        isSelected: selectedLocale.languageCode == 'ar',
                        primaryColor: primaryColor,
                        cardColor: cardColor,
                        textColor: textColor,
                        isRtl: isRtl,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 14),
                      _languageOption(
                        title: l10n.englishLanguage,
                        subtitle: l10n.englishLanguageDirection,
                        locale: const Locale('en'),
                        isSelected: selectedLocale.languageCode == 'en',
                        primaryColor: primaryColor,
                        cardColor: cardColor,
                        textColor: textColor,
                        isRtl: isRtl,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 16),
                      // small sample text rendered in the selected language
                      _previewCard(previewContext, l10n, isDark),
                      const SizedBox(height: 16),
                      _privacyNote(
                        l10n,
                        isDark,
                        primaryColor,
                        textColor,
                        isRtl,
                      ),
                      const SizedBox(height: 16),
                      // save button applies the locale and closes the screen
                      SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _saveLanguage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: Text(
                            l10n.saveLanguage,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        l10n.languageFooter,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white54 : AppColors.grey,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Back button and title; their order is swapped for RTL.
  Widget _buildHeader(
    BuildContext context,
    AppLocalizations l10n,
    bool isRtl,
    Color primaryColor,
  ) {
    final backButton = IconButton(
      onPressed: () => Navigator.pop(context),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        isRtl ? Icons.arrow_forward : Icons.arrow_back,
        color: primaryColor,
        size: 19,
      ),
    );
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: isRtl
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: isRtl
          ? [
              Text(
                l10n.languageTitle,
                style: TextStyle(
                  color: primaryColor,
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
                l10n.languageTitle,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
    );
  }

  /// A selectable language row. Tapping only updates the local selection.
  Widget _languageOption({
    required String title,
    required String subtitle,
    required Locale locale,
    required bool isSelected,
    required Color primaryColor,
    required Color cardColor,
    required Color textColor,
    required bool isRtl,
    required bool isDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => selectedLocale = locale),
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF263C35) : const Color(0xFFE8EBD9))
                : cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? primaryColor : AppColors.coral,
              width: isSelected ? 1.2 : 0.8,
            ),
          ),
          child: Row(
            children: isRtl
                ? [
                    Expanded(
                      child: _languageText(title, subtitle, textColor, isDark),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      isSelected
                          ? Icons.check_circle_outline
                          : Icons.circle_outlined,
                      color: isSelected ? primaryColor : AppColors.grey,
                      size: 17,
                    ),
                  ]
                : [
                    Icon(
                      isSelected
                          ? Icons.check_circle_outline
                          : Icons.circle_outlined,
                      color: isSelected ? primaryColor : AppColors.grey,
                      size: 17,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _languageText(title, subtitle, textColor, isDark),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  /// Language name with its direction description underneath.
  Widget _languageText(
    String title,
    String subtitle,
    Color textColor,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: isDark ? Colors.white54 : AppColors.grey,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  /// Card that shows sample text so the user can see how the chosen language looks.
  Widget _previewCard(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    final theme = Theme.of(context);
    final previewBackground = isDark ? theme.cardColor : AppColors.teal;
    final previewText = isDark ? theme.colorScheme.onSurface : AppColors.cream;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: previewBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.textPreview,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: previewText,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.sampleGreeting,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: previewText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            l10n.sampleGreetingDescription,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: previewText.withValues(alpha: 0.8),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  /// Note about language settings and privacy.
  Widget _privacyNote(
    AppLocalizations l10n,
    bool isDark,
    Color primaryColor,
    Color textColor,
    bool isRtl,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF263C35) : const Color(0xFFE6EAD5),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: primaryColor, size: 17),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              l10n.languagePrivacyNote,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: textColor.withValues(alpha: 0.75),
                fontSize: 10,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Applies the chosen locale to the whole app and goes back.
  void _saveLanguage() {
    AppLocaleController.setLocale(selectedLocale);
    Navigator.pop(context);
  }
}
