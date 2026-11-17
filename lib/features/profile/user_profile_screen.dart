import 'package:material_ui/material_ui.dart';
import 'package:sanad/features/profile/profile_settings_screen.dart';

/// Customer profile tab; reuses the shared settings screen in customer mode.
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSettingsScreen(
      accountType: ProfileAccountType.customer,
    );
  }
}
