import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad/features/authentication/presentation/screens/finish_otp_screen.dart';
import 'package:sanad/features/authentication/presentation/screens/forget_password.dart';
import 'package:sanad/features/authentication/presentation/screens/login_Provider.dart';
import 'package:sanad/features/authentication/presentation/screens/login_User_screen.dart';
import 'package:sanad/features/authentication/presentation/screens/new_Password.dart';
import 'package:sanad/features/authentication/presentation/screens/otp_screen.dart';
import 'package:sanad/features/authentication/presentation/screens/signUp_Screen.dart';
import 'package:sanad/features/splash/splash_Screen.dart';
import 'package:sanad/features/client/client_home/client_home_provider.dart';
import 'package:sanad/features/client/client_home/screens/client_home_screen.dart';
import 'package:sanad/features/onboarding/screens/onboarding_screen.dart';
import 'package:sanad/features/profile/provider_profile_screen.dart';
import 'package:sanad/features/profile/user_profile_screen.dart';
import 'package:sanad/features/provider/provider_home/screens/provider_home.dart';
import 'package:sanad/features/client/client_requests/screens/my_requests_screen.dart';
import 'package:sanad/features/client/client_requests/screens/new_request_screen.dart';
import 'package:sanad/features/client/client_services_categories/screens/service_categories_screen.dart';
import 'package:sanad/features/type_selection/role_selection_screen.dart';

// Reads the :role path parameter and fails fast if it is not a known auth role.
String _authRoleFromPath(GoRouterState state) {
  final role = state.pathParameters['role'];
  if (role != 'customer' && role != 'provider') {
    throw StateError('Unsupported authentication role: $role');
  }
  return role!;
}

/// App-wide router. Starts at the splash screen; flows go splash -> onboarding
/// -> role selection -> login/signup, then to the customer or provider area.
final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    // Splash, onboarding and role selection
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    // Login routes: both the older flat paths and the role-based ones are kept
    // so existing navigation calls keep working.
    GoRoute(
      path: '/login/customer',
      builder: (context, state) => const LoginUserScreen(),
    ),
    GoRoute(
      path: '/loginUser',
      builder: (context, state) => const LoginUserScreen(),
    ),
    GoRoute(
      path: '/login/provider',
      builder: (context, state) => const LoginProvider(),
    ),
    GoRoute(
      path: '/loginProvider',
      builder: (context, state) => const LoginProvider(),
    ),
    // Signup (customers only)
    GoRoute(path: '/signUp', builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: '/signup/customer',
      builder: (context, state) => const SignupScreen(),
    ),
    // Password recovery flow: forgot password -> OTP -> new password -> done.
    // The role-less paths default to customer.
    GoRoute(
      path: '/forgetPassword',
      builder: (context, state) => const ForgetPassword(role: 'customer'),
    ),
    GoRoute(
      path: '/forgot-password/:role',
      builder: (context, state) =>
          ForgetPassword(role: _authRoleFromPath(state)),
    ),
    // The email is passed through `extra` from the previous screen.
    GoRoute(
      path: '/otpScreen',
      builder: (context, state) =>
          OtpScreen(email: state.extra as String? ?? '', role: 'customer'),
    ),
    GoRoute(
      path: '/otpScreen/:role',
      builder: (context, state) => OtpScreen(
        email: state.extra as String? ?? '',
        role: _authRoleFromPath(state),
      ),
    ),
    GoRoute(
      path: '/newPassword',
      builder: (context, state) => const NewPassword(),
    ),
    GoRoute(
      path: '/newPassword/:role',
      builder: (context, state) => NewPassword(role: _authRoleFromPath(state)),
    ),
    GoRoute(
      path: '/finishOtp',
      builder: (context, state) => const FinishOtpScreen(),
    ),
    GoRoute(
      path: '/finishOtp/:role',
      builder: (context, state) =>
          FinishOtpScreen(role: _authRoleFromPath(state)),
    ),
    // Customer area. The home route creates its provider here so its state is
    // scoped to this screen.
    GoRoute(
      path: '/customer/management',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => ClientHomeProvider(),
        child: const ClientHomeScreen(),
      ),
    ),
    // Optional ?q= pre-fills the category search.
    GoRoute(
      path: '/customer/categories',
      builder: (context, state) => ServiceCategoriesScreen(
        initialSearchQuery: state.uri.queryParameters['q'] ?? '',
      ),
    ),
    // The ?refresh= value is used as the key so the list rebuilds and reloads
    // after a new request is created.
    GoRoute(
      path: '/customer/requests',
      builder: (context, state) =>
          MyRequestsScreen(key: ValueKey(state.uri.queryParameters['refresh'])),
    ),
    // An optional category can be passed via `extra` to pre-select it.
    GoRoute(
      path: '/customer/new-request',
      builder: (context, state) =>
          NewRequestScreen(initialCategory: state.extra as String?),
    ),
    GoRoute(
      path: '/customer/profile',
      builder: (context, state) => const UserProfileScreen(),
    ),
    // Provider (service provider) area
    GoRoute(
      path: '/provider/profile',
      builder: (context, state) => const ProviderProfileScreen(),
    ),
    GoRoute(
      path: '/provider/dashboard',
      builder: (context, state) => const ProviderHomePage(),
    ),
  ],
);
