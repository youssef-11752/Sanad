import 'package:material_ui/material_ui.dart';
import 'package:sanad/features/profile/profile_settings_screen.dart';

/// Provider profile tab; reuses the shared settings screen in provider mode.
class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSettingsScreen(
      accountType: ProfileAccountType.provider,
    );
  }
}
