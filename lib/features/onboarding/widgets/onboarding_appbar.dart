
import 'package:flutter/material.dart';

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
              child: Text('تخطي' , style: TextStyle(color: Colors.grey),),
            )
          else
          // if we are in the last page "3" show thw word welcome
            Text(
              'أهلاً بيك',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

          const Spacer(),

          Text(
            'سند',
            style: TextStyle(
              color: Colors.teal[700],
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 10),

          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 155, 31, 22),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.home_outlined,
              size: 27,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
