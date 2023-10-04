import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../app_controller.dart';
import '../../../../setups/app_routes/app_routes.dart';
import '../../../../setups/di/service_locator.dart';
import '../../../../shared/domain/entities/roles.dart';
import '../../../../shared/presentation/widgets/header_screen_widget.dart';
import '../../../../shared/presentation/widgets/responsive_padding_widget.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_state.dart';
import '../blocs/registration/vehicle_registration_bloc.dart';
import '../blocs/registration/vehicle_registration_state.dart';
import '../widgets/grid_vehicles_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = ServiceLocator.I.get<HomeBloc>();
  final registrationBloc = ServiceLocator.I.get<VehicleRegistrationBloc>();

  @override
  void initState() {
    super.initState();
    bloc.getVehicles(1);
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ResponsivePadding(
        isScreenWrapper: true,
        child: Scaffold(
          appBar: HeaderScreenWidget(
            title: 'Car Store',
            onSecondaryTap: AppController.I.user.role == Roles.admin
                ? () {
                    AppController.I.setNavBarIndex(1);
                    AppController.I.logout();
                    context.goNamed(RouteName.login.name);
                  }
                : null,
          ),
          body: BlocListener<VehicleRegistrationBloc, VehicleRegistrationState>(
            bloc: registrationBloc,
            listener: (context, state) {
              if (state is VehicleRegistrationSuccess) {
                bloc.clearList();
                bloc.getVehicles(1);
              }
            },
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    bloc.clearList();
                    bloc.getVehicles(1);
                  },
                  edgeOffset: 20,
                  child: GridVehiclesWidget(
                    isLoading: state.isLoading,
                    vehicles: state.vehicles,
                    onVehicleTap: (vehicle) {
                      bloc.clearError();
                      context.goNamed(
                        RouteName.details.name,
                        pathParameters: {'vehicleId': vehicle.id.toString()},
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: AppController.I.user.role == Roles.admin
              ? FloatingActionButton(
                  onPressed: () {
                    bloc.clearError();
                    context.goNamed(RouteName.registerVehicle.name) as bool?;
                  },
                  child: const Icon(Icons.add),
                )
              : null,
        ),
      );
}
