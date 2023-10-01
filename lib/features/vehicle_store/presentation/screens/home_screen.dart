import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../app_controller.dart';
import '../../../../setups/app_routes/app_routes.dart';
import '../../../../setups/di/service_locator.dart';
import '../../../../shared/presentation/toast/toast_controller.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_state.dart';
import '../widgets/grid_vehicles_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = ServiceLocator.I.get<HomeBloc>();

  @override
  void initState() {
    super.initState();
    Toast.show('User role: ${AppController.I.role}');
    bloc.getVehicles(1);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Car Store'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: bloc,
            builder: (context, state) => LazyLoadScrollView(
              isLoading: state.isLoading,
              onEndOfPage: () {
                if (!state.isLoading &&
                    state.errorMessage?.contains('Não há mais veículos') != true) {
                  bloc.nextPage();
                }
              },
              child: GridVehiclesWidget(
                isLoading: state.isLoading,
                vehicles: state.vehicles,
                onVehicleTap: (vehicle) {
                  context.goNamed(
                    RouteName.details.name,
                    pathParameters: {'vehicleId': vehicle.id.toString()},
                  );
                },
              ),
            ),
          ),
        ),
      );
}
