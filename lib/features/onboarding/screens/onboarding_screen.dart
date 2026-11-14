import 'package:flutter/material.dart';
import 'package:sanad/features/onboarding/models/onboarding_model.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_appbar.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_btn.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_footer.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // initial index for the start
  int currentIndex = 0;
// page controller that controls going from screen to another one
  final PageController pageController = PageController();
// list of data for the three screens
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'كل صنعة، لها سند',
      description:
          'من غسالتك لكهرباء بيتك, ومن النجارة لصيانة مركبتك, اطلب الخدمة المناسبة من مكان واحد',
      icon: Icons.home_repair_service_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
    OnboardingModel(
      title: 'أهل خبرة، قريبين منك',
      description:
          'اختار متخصص موثق حسب نوع العطل, وشوف خبرته وتقييماته ورسوم الزيارة قبل ما تحجز',
      icon: Icons.engineering_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
    OnboardingModel(
      title: 'من أول طلب، لحد ما تطمن',
      description:
          'احكي المشكلة، حدد الزيارة، وتابع طلبك خطوة بخطوة, سند معاك لحد ما الشغل يخلص',
      icon: Icons.assignment_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
  ];
// function that run when i press to go to the next page
  void nextPage() {
    if (currentIndex < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
// skip function that runs when we press skip btn
  void skipOnboarding() {
    pageController.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
// to delete the controller from memory when we go out from the page
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 245, 231),
      body: SafeArea(
        child: Column(
          children: [ 
            // calling appbat widget
            OnboardingAppbar(
              onSkip: skipOnboarding, // calling skip function
              currentIndex: currentIndex, // calling currentindex 
            ),

            Expanded(
              child: PageView(
                controller: pageController,
                reverse: true, // Make pages move from right to left
                // change the index of the page when we go to another one
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index; // reasign the index
                  });
                },
                // convert the onboarding list into widgets then convert it again to list
                children: onboardingPages.map((page) {
                  return OnboardingPage(model: page); 
                }).toList(),
              ),
            ),
            // calling indicator widget
            OnboardingIndicator(
              currentIndex: currentIndex,
              totalPages: onboardingPages.length, // totla length for the pages "3"
            ),

            SizedBox(height: 18),
            // calling btn for the next page then for start "at the last page"
            OnboardingBtn(
              onPressed: nextPage, // calling next function
              isLastPage: currentIndex == onboardingPages.length - 1, 
            ),
            // calling footer part that tells us which step are we in now
            OnboardingFooter(
              currentIndex: currentIndex, 
              totalPages: onboardingPages.length, // total length of the pages "3"
            ),
          ],
        ),
      ),
    );
  }
}
