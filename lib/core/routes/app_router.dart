import 'package:sanad/features/authentication/presentation/screens/finish_otp_screen.dart';
import 'package:sanad/features/authentication/presentation/screens/forget_password.dart';
import 'package:sanad/features/authentication/presentation/screens/home_screen.dart';
import 'package:sanad/features/authentication/presentation/screens/login_Provider.dart';
import 'package:sanad/features/authentication/presentation/screens/login_User_screen.dart';
import 'package:sanad/features/authentication/presentation/screens/new_Password.dart';
import 'package:sanad/features/authentication/presentation/screens/otp_screen.dart';
import 'package:sanad/features/authentication/presentation/screens/signUp_Screen.dart';
import 'package:sanad/features/splash/splash_Screen.dart';
import 'package:sanad/features/onboarding/screens/onboarding_screen.dart';
import 'package:sanad/features/client/client_home/screens/client_home_screen.dart';
import 'package:sanad/features/client/client_home/client_home_provider.dart';
import 'package:sanad/features/client/client_requests/screens/my_requests_screen.dart';
import 'package:sanad/features/client/client_requests/screens/new_request_screen.dart';
import 'package:sanad/features/client/client_services_categories/screens/service_categories_screen.dart';
import 'package:sanad/features/profile/provider_profile_screen.dart';
import 'package:sanad/features/profile/user_profile_screen.dart';
import 'package:sanad/features/provider/provider_home/screens/provider_home.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/customer/management',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => ClientHomeProvider(),
        child: const ClientHomeScreen(),
      ),
    ),
    GoRoute(
      path: '/provider/dashboard',
      builder: (context, state) => const ProviderHomePage(),
    ),
    GoRoute(
      path: '/customer/categories',
      builder: (context, state) => ServiceCategoriesScreen(
        initialSearchQuery: state.uri.queryParameters['q'] ?? '',
      ),
    ),
    GoRoute(
      path: '/customer/requests',
      builder: (context, state) =>
          MyRequestsScreen(key: ValueKey(state.uri.queryParameters['refresh'])),
    ),
    GoRoute(
      path: '/customer/new-request',
      builder: (context, state) =>
          NewRequestScreen(initialCategory: state.extra as String?),
    ),
    GoRoute(
      path: '/customer/profile',
      builder: (context, state) => const UserProfileScreen(),
    ),
    GoRoute(
      path: '/provider/profile',
      builder: (context, state) => const ProviderProfileScreen(),
    ),
    GoRoute(
      path: '/login/customer',
      builder: (context, state) => const LoginUserScreen(),
    ),
    GoRoute(
      path: '/login/provider',
      builder: (context, state) => const LoginProvider(),
    ),
    GoRoute(
      path: '/signup/customer',
      builder: (context, state) => const SignupScreen(),
    ),

    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/signUp', builder: (context, state) => SignupScreen()),
    GoRoute(
      path: '/otpScreen',
      builder: (context, state) =>
          OtpScreen(email: (state.extra as String?) ?? ''),
    ),
    GoRoute(path: '/newPassword', builder: (context, state) => NewPassword()),
    GoRoute(path: '/loginUser', builder: (context, state) => LoginUserScreen()),
    GoRoute(
      path: '/loginProvider',
      builder: (context, state) => LoginProvider(),
    ),
    GoRoute(
      path: '/forgetPassword',
      builder: (context, state) => ForgetPassword(),
    ),
    GoRoute(path: '/finishOtp', builder: (context, state) => FinishOtpScreen()),
  ],
);
