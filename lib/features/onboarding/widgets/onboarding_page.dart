
import 'package:flutter/material.dart';
import 'package:flutter_intern_sprint_one/features/onBoarding/data/model/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;  // take model from model file 

  const OnboardingPage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 220,
            width: 220,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 242, 241),
              shape: BoxShape.circle,
            ),
            child: Icon(
              model.icon,
              size: 100,
              color: const Color.fromARGB(255, 155, 31, 22),
            ),
          ),

          SizedBox(height: 35),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 140,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      model.badge, // badge data from modl
                       textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.teal[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12),

              Text(
                model.title, // title from model
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),

              SizedBox(height: 15),

              Text(
                model.description, // descripton from model
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
