
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';

/// Page dots; the active one is wider and red, the rest are small and neutral.
class OnboardingIndicator extends StatelessWidget {
  final int currentIndex; 
  final int totalPages;

  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl, // to make it moves from right to left
      mainAxisAlignment: MainAxisAlignment.center,
      // one dot per page
      children: List.generate(
        totalPages, // 3 indiacator signs
        (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: currentIndex == index ? 24 : 8, // shape of the indicator changes if it is the current page or not
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppThemes.redColor
                  : AppThemes.darkCremey,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
