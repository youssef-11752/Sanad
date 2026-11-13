
import 'package:flutter/material.dart';

class OnboardingBtn extends StatelessWidget {
  final VoidCallback onPressed; // when you press the btn the function runs "go to next page for now"
  final bool isLastPage; // to know if this is the last page or not

  const OnboardingBtn({
    super.key,
    required this.onPressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: onPressed, // call function
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 155, 31, 22),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text( 
            isLastPage ? 'ابدأ الآن' : 'التالي', // if it is last page show start now , if not show next
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
