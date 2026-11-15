import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad/features/auth/presentation/auth_flow_screens.dart';
import 'package:sanad/features/auth/presentation/role_login_screen.dart';
import 'package:sanad/features/auth/presentation/screens/splash_Screen.dart';
import 'package:sanad/features/customer_management/client_home_provider.dart';
import 'package:sanad/features/customer_management/screens/client_home_screen.dart';
import 'package:sanad/features/provider_dashboard/screens/provider_dashboard_screen.dart';
import 'package:sanad/features/service_categories/screens/service_categories_screen.dart';
import 'package:sanad/features/type_selection/role_selection_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/login/customer',
      builder: (context, state) => const RoleLoginScreen(role: 'customer'),
    ),
    GoRoute(
      path: '/login/provider',
      builder: (context, state) => const RoleLoginScreen(role: 'provider'),
    ),
    GoRoute(
      path: '/signup/:role',
      builder: (context, state) => SignupScreen(
        role: state.pathParameters['role'] == 'provider' ? 'provider' : 'customer',
      ),
    ),
    GoRoute(
      path: '/forgot-password/:role',
      builder: (context, state) => ForgotPasswordScreen(
        role: state.pathParameters['role'] == 'provider' ? 'provider' : 'customer',
      ),
    ),
    GoRoute(
      path: '/verify-code/:role',
      builder: (context, state) => OtpScreen(
        role: state.pathParameters['role'] == 'provider' ? 'provider' : 'customer',
        email: state.extra as String? ?? '',
      ),
    ),
    GoRoute(
      path: '/new-password/:role',
      builder: (context, state) => NewPasswordScreen(
        role: state.pathParameters['role'] == 'provider' ? 'provider' : 'customer',
      ),
    ),
    GoRoute(
      path: '/password-reset-done/:role',
      builder: (context, state) => FinishOtpScreen(
        role: state.pathParameters['role'] == 'provider' ? 'provider' : 'customer',
      ),
    ),
    GoRoute(
      path: '/customer/management',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => ClientHomeProvider(),
        child: const ClientHomeScreen(),
      ),
    ),
    GoRoute(
      path: '/customer/categories',
      builder: (context, state) => const ServiceCategoriesScreen(),
    ),
    GoRoute(
      path: '/provider/dashboard',
      builder: (context, state) => const ProviderDashboardScreen(),
    ),
  ],
);
