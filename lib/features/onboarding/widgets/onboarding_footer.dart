
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';

/// Small "step X of Y" caption at the bottom of the onboarding screen.
class OnboardingFooter extends StatelessWidget {
  final int currentIndex; // to know the current index
  final int totalPages; // to nknow the total page number

  const OnboardingFooter({
    super.key,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        // if there is 3 pages and i am i page 1 so "step 1 of 3" appears
        'خطوة ${currentIndex + 1} من $totalPages',
        style: const TextStyle(
          fontSize: 14,
          color: AppThemes.hiAccount,
        ),
      ),
    );
  }
}
