import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/app_colors.dart';
import 'package:sanad/core/app_preferences.dart';
import 'package:sanad/core/models/profile_data.dart';
import 'package:sanad/features/authentication/data/repo/auth.dart';
import 'package:sanad/features/main_navigation/widgets/main_bottom_navigation.dart';
import 'package:sanad/features/profile/data/profile_repository.dart';
import 'package:sanad/l10n/app_localizations.dart';

import 'appearance_screen.dart';
import 'help_support_screen.dart';
import 'language_screen.dart';
import 'personal_profile_screen.dart';
import 'privacy_policy_screen.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/settings_tile.dart';

// decides the back route, bottom bar items and whether profile editing is allowed
enum ProfileAccountType { customer, provider }

/// Account/settings page shared by customers and providers.
/// Loads the profile from the repository and links to the sub-screens.
class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({
    super.key,
    required this.accountType,
    this.repository,
  });

  final ProfileAccountType accountType;
  // optional so tests can inject a fake repository
  final ProfileRepository? repository;

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  // kept in a field so rebuilds do not trigger a new request
  late final ProfileRepository _repository;
  late Future<ProfileData> _profileFuture;
  // local toggle only, not persisted anywhere yet
  bool _notificationsEnabled = true;

  bool get isProvider => widget.accountType == ProfileAccountType.provider;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? SupabaseProfileRepository();
    _profileFuture = _repository.loadCurrentProfile();
  }

  // re-run the request after a failed load
  void _retryLoadingProfile() {
    setState(() {
      _profileFuture = _repository.loadCurrentProfile();
    });
  }

  /// Saves the edited customer profile, then updates the displayed data without reloading.
  Future<void> _saveProfile(ProfileData profile) async {
    await _repository.saveCustomerProfile(profile);
    if (!mounted) return;
    setState(() {
      _profileFuture = Future.value(profile);
    });
  }

  // fall back to the role home when there is nothing to pop (e.g. opened via go)
  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(isProvider ? '/provider/dashboard' : '/customer/management');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // loading, error and loaded states are handled separately
    return FutureBuilder<ProfileData>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
            bottomNavigationBar: _bottomNavigation(),
          );
        }

        // show the error with a retry button
        if (snapshot.hasError) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${l10n.profileLoadError}\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: _retryLoadingProfile,
                        child: Text(l10n.retryButton),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: _bottomNavigation(),
          );
        }

        // profile loaded, show the settings list
        final profile = snapshot.requireData;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(19, 12, 19, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildPageTitle(context, l10n),
                        const SizedBox(height: 18),
                        // summary card with name, phone and location
                        ProfileHeaderCard(
                          name: profile.fullName,
                          phone: profile.phoneNumber,
                          location: profile.location.isEmpty
                              ? '—'
                              : profile.location,
                          accountLabel: isProvider
                              ? l10n.accountProvider
                              : l10n.accountCustomer,
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(context, l10n.yourAccount),
                        const SizedBox(height: 11),
                        SettingsTile(
                          iconAsset: 'assets/icons/user-round.svg',
                          title: l10n.personalProfile,
                          subtitle: l10n.personalProfileSubtitle,
                          // providers see their profile read-only; customers can edit and save
                          onTap: () => Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => PersonalProfileScreen(
                                profile: profile,
                                canEdit: !isProvider,
                                onSave: isProvider ? null : _saveProfile,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SettingsTile(
                          iconAsset: 'assets/icons/bell.svg',
                          title: l10n.notifications,
                          subtitle: _notificationsEnabled
                              ? l10n.notificationsEnabled
                              : l10n.notificationsDisabled,
                          // tapping toggles the notifications switch text
                          onTap: () => setState(
                            () =>
                                _notificationsEnabled = !_notificationsEnabled,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(context, l10n.appPreferences),
                        const SizedBox(height: 11),
                        SettingsTile(
                          iconAsset: 'assets/icons/sun.svg',
                          title: l10n.appearance,
                          subtitle: _appearanceSubtitle(l10n),
                          // the screen is awaited in _openAppearanceScreen so this subtitle refreshes on return
                          onTap: _openAppearanceScreen,
                        ),
                        const SizedBox(height: 10),
                        SettingsTile(
                          iconAsset: 'assets/icons/languages.svg',
                          title: l10n.language,
                          subtitle: l10n.languageSubtitle,
                          onTap: () => Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => const LanguageScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SettingsTile(
                          iconAsset: 'assets/icons/shield-check.svg',
                          title: l10n.privacyAndServicePolicy,
                          onTap: () => Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => const PrivacyPolicyScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SettingsTile(
                          iconAsset: 'assets/icons/circle-help.svg',
                          title: l10n.helpAndSupport,
                          subtitle: l10n.helpAndSupportSubtitle,
                          onTap: () => Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => const HelpSupportScreen(),
                            ),
                          ),
                        ),
                        // logout asks for confirmation first
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 38,
                          child: OutlinedButton(
                            onPressed: () => _confirmLogout(l10n),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.teal,
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: AppColors.coral),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              l10n.logout,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _bottomNavigation(),
        );
      },
    );
  }

  // account tab is always the selected one on this screen
  Widget _bottomNavigation() => MainBottomNavigation(
    selectedDestination: MainNavigationDestination.account,
    isProvider: isProvider,
  );

  /// Page title with back button, mirrored for RTL.
  Widget _buildPageTitle(BuildContext context, AppLocalizations l10n) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: isRtl
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: isRtl
          ? [
              Text(
                l10n.profileSettingsTitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 7),
              IconButton(
                tooltip: l10n.backButtonTooltip,
                onPressed: () => _goBack(context),
                icon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ]
          : [
              IconButton(
                tooltip: l10n.backButtonTooltip,
                onPressed: () => _goBack(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                l10n.profileSettingsTitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
    );
  }

  /// Small section heading above a group of tiles.
  Widget _sectionTitle(BuildContext context, String title) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // shows the current theme name as the tile subtitle
  String _appearanceSubtitle(AppLocalizations l10n) {
    switch (AppThemeController.current.value) {
      case AppThemeChoice.dark:
        return l10n.themeDark;
      case AppThemeChoice.light:
        return l10n.themeLight;
      case AppThemeChoice.system:
        return l10n.themeSystem;
    }
  }

  // rebuild after returning so the subtitle shows the newly selected theme
  Future<void> _openAppearanceScreen() async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute<void>(builder: (_) => const AppearanceScreen()),
    );
    if (!mounted) return;
    setState(() {});
  }

  /// Confirmation dialog, then signs out and returns to customer login.
  void _confirmLogout(AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutPrompt),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              // close the dialog before the async sign out
              Navigator.pop(dialogContext);
              try {
                await Auth().signOut();
                // check mounted before using the context after the await
                if (mounted) context.go('/login/customer');
              } catch (error) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${l10n.logoutError}\n$error')),
                );
              }
            },
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}
