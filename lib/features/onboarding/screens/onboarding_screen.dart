import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/onboarding/models/onboarding_model.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_appbar.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_btn.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_footer.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:sanad/features/onboarding/widgets/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Intro slides shown on first launch. Finishing or skipping goes to customer login.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  // shared_preferences key used to remember that onboarding was already seen
  static const String completedKey = 'has_completed_onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  bool _isCompleting = false;

  // slide content (Arabic copy), one entry per page
  final List<OnboardingModel> _onboardingPages = [
    OnboardingModel(
      title: 'كل صنعة لها سند',
      description: 'من غسالتك لكهرباء بيتك، ومن النجارة لصيانة مركبتك، اطلب الخدمة المناسبة من مكان واحد.',
      icon: Icons.home_repair_service_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
    OnboardingModel(
      title: 'أهل خبرة قريبين منك',
      description: 'اختار متخصص موثوق حسب نوع العطل، وشوف خبرته وتقييماته ورسوم الزيارة قبل ما تحجز.',
      icon: Icons.engineering_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
    OnboardingModel(
      title: 'سند معاك لحد ما الشغل يخلص',
      description: 'احكي المشكلة، حدد الزيارة، وتابع طلبك خطوة بخطوة. سند معاك لحد ما الشغل يخلص.',
      icon: Icons.assignment_outlined,
      badge: 'سند · لكل بيت صنعة',
    ),
  ];

  /// Saves the "completed" flag and moves on to customer login.
  /// The guard stops double taps from running it twice.
  Future<void> _completeOnboarding() async {
    if (_isCompleting) return;
    setState(() => _isCompleting = true);

    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setBool(OnboardingScreen.completedKey, true);
    } catch (_) {
      // the flag is a convenience only, so a storage failure must not block the user
      // Continue to login even if local persistence is unavailable.
    }

    // the widget may have been disposed while waiting for storage
    if (!mounted) return;
    context.go('/login/customer');
  }

  // slides to the next page, or finishes when already on the last one
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

  // skip behaves exactly like finishing
  void _skipOnboarding() => _completeOnboarding();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // the app copy is Arabic, so this screen is forced to RTL
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
                // swiping or button taps both end up in onPageChanged, which keeps the index in sync
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
              // dots below the pager
              OnboardingIndicator(
                currentIndex: _currentIndex,
                totalPages: _onboardingPages.length,
              ),
              const SizedBox(height: 18),
              OnboardingBtn(
                // ignore taps while already navigating away
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
