import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/vehicle_store/presentation/screens/create_vehicle_screen.dart';
import '../../features/vehicle_store/presentation/screens/home_screen.dart';
import '../../features/vehicle_store/presentation/screens/vehicle_details_screen.dart';

enum RouteName {
  login('/login'),
  signup('/signup'),
  vehicles('/vehicles'),
  details('/details'),
  createVehicle('create-vehicle');

  final String name;

  const RouteName(this.name);
}

class AppRouter {
  static RouteName getRouteNameByNavIndex(int index) {
    if (index == 0) return RouteName.vehicles;
    if (index == 1) return RouteName.login;
    return RouteName.vehicles;
  }

  static final router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: '/',
        redirect: (context, state) => RouteName.vehicles.name,
      ),
      GoRoute(
        path: RouteName.login.name,
        name: RouteName.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteName.signup.name,
        name: RouteName.signup.name,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: RouteName.vehicles.name,
        name: RouteName.vehicles.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'details/:vehicleId',
            name: RouteName.details.name,
            builder: (context, state) => VehicleDetailsScreen(
              vehicleId: int.parse(state.pathParameters['vehicleId']!),
            ),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'edit',
                builder: (context, state) => CreateVehicleScreen(
                  vehicleId: state.pathParameters['vehicleId'] != null
                      ? int.parse(state.pathParameters['vehicleId']!)
                      : null,
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'create-vehicle',
            name: RouteName.createVehicle.name,
            builder: (context, state) => const CreateVehicleScreen(),
          ),
        ],
      ),
    ],
    initialLocation: RouteName.vehicles.name,
  );
}
