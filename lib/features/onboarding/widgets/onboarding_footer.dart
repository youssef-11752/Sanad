
import 'package:flutter/material.dart';

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
          color: Colors.grey,
        ),
      ),
    );
  }
}
