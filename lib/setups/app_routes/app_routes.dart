import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/vehicle_store/presentation/screens/home_screen.dart';

class RouteNames {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String vehicles = '/vehicles';
  static const String details = '/vehicles/:id';
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
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '${RouteNames.vehicles}/:id',
      name: RouteNames.details,
      builder: (context, state) => Scaffold(
        body: Center(
          child: Text('Details of vehicle: ${state.pathParameters['id'] ?? 'id not found'}'),
        ),
      ),
    ),
  ],
  initialLocation: RouteNames.vehicles,
);
