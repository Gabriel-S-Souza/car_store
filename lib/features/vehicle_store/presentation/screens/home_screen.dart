import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../app_controller.dart';
import '../../../../setups/app_routes/app_routes.dart';
import '../../../../setups/di/service_locator.dart';
import '../../../../shared/domain/entities/roles.dart';
import '../../../../shared/presentation/widgets/header_screen_widget.dart';
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
    bloc.getVehicles(1);
    // AppRouter.router.routerDelegate.addListener(() {
    //   log(AppRouter.router.routerDelegate.currentConfiguration.uri.toString());
    // });
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 0),
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
        floatingActionButton: AppController.I.user.role == Roles.admin
            ? FloatingActionButton(
                onPressed: () => context.goNamed(RouteName.createVehicle.name),
                child: const Icon(Icons.add),
              )
            : null,
      );
}
