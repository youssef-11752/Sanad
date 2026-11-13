
import 'package:flutter/material.dart';

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
                  ? const Color.fromARGB(255, 155, 31, 22)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
