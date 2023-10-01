import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/vehicle_store/presentation/screens/home_screen.dart';
import '../../features/vehicle_store/presentation/screens/vehicle_details_screen.dart';

class RouteNames {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String vehicles = '/vehicles';
  static const String details = '/details';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(path: RouteNames.signup, builder: (context, state) => const SignUpScreen()),
    GoRoute(
      path: '/',
      redirect: (context, state) => RouteNames.vehicles,
    ),
    GoRoute(
      path: RouteNames.vehicles,
      name: RouteNames.vehicles,
      builder: (context, state) => const HomeScreen(),
      routes: [
        // pass the id in url to show in web
        GoRoute(
          path: ':vehicleId',
          name: '/details',
          builder: (context, state) => VehicleDetailsScreen(
            vehicleId: int.parse(state.pathParameters['vehicleId']!),
          ),
        )
      ],
    ),
  ],
  initialLocation: RouteNames.vehicles,
);
