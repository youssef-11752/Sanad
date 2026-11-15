import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/onboarding/models/onboarding_model.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_appbar.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_btn.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_footer.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String completedKey = 'has_completed_onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  bool _isCompleting = false;

  final List<OnboardingModel> _onboardingPages = [
    OnboardingModel(
      title: 'كل صنعة لها سند',
      description:
          'من غسالتك لكهرباء بيتك، ومن النجارة لصيانة مركبتك، اطلب الخدمة المناسبة من مكان واحد.',
      icon: Icons.home_repair_service_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
    OnboardingModel(
      title: 'أهل خبرة قريبين منك',
      description:
          'اختار متخصص موثوق حسب نوع العطل، وشوف خبرته وتقييماته ورسوم الزيارة قبل ما تحجز.',
      icon: Icons.engineering_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
    OnboardingModel(
      title: 'سند معاك لحد ما الشغل يخلص',
      description:
          'احكي المشكلة، حدد الزيارة، وتابع طلبك خطوة بخطوة. سند معاك لحد ما الشغل يخلص.',
      icon: Icons.assignment_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
  ];

  Future<void> _completeOnboarding() async {
    if (_isCompleting) return;
    setState(() => _isCompleting = true);

    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setBool(OnboardingScreen.completedKey, true);
    } catch (_) {
      // Continue to role selection even if local persistence is unavailable.
    }

    if (!mounted) return;
    context.go('/role-selection');
  }

  void _nextPage() {
    if (_currentIndex < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }
    _completeOnboarding();
  }

  void _skipOnboarding() => _completeOnboarding();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppThemes.cremeyColor,
        body: SafeArea(
          child: Column(
            children: [
              OnboardingAppbar(
                onSkip: _skipOnboarding,
                currentIndex: _currentIndex,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: _onboardingPages
                      .map((page) => OnboardingPage(model: page))
                      .toList(),
                ),
              ),
              OnboardingIndicator(
                currentIndex: _currentIndex,
                totalPages: _onboardingPages.length,
              ),
              const SizedBox(height: 18),
              OnboardingBtn(
                onPressed: _isCompleting ? () {} : _nextPage,
                isLastPage: _currentIndex == _onboardingPages.length - 1,
              ),
              OnboardingFooter(
                currentIndex: _currentIndex,
                totalPages: _onboardingPages.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
