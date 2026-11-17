
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';

/// Top row of the onboarding screen: skip/welcome text on one side, app name and logo on the other.
class OnboardingAppbar extends StatelessWidget {
  final VoidCallback onSkip; // skip function
  final int currentIndex; // it takes current ndex as it changes the skip word to welcome

  const OnboardingAppbar({
    super.key,
    required this.onSkip,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    // children are laid out for RTL by the parent Directionality
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          // if we are in page 1 or 2 "not the last one 3" , show skip word and when we press it skip function work
          if (currentIndex < 2)
            TextButton(
              onPressed: onSkip,
              child: Text(
                'تخطي',
                style: const TextStyle(color: AppThemes.hiAccount),
              ),
            )
          else
          // if we are in the last page "3" show thw word welcome
            Text(
              'أهلاً بيك',
              style: TextStyle(
                fontSize: 16,
                color: AppThemes.hiAccount,
                fontWeight: FontWeight.bold,
              ),
            ),

          // pushes the brand name and logo to the opposite edge
          const Spacer(),

          Text(
            'سند',
            style: TextStyle(
              color: AppThemes.greenColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 10),

          // red rounded square acting as the logo mark
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppThemes.redColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.home_outlined,
              size: 27,
              color: AppThemes.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
