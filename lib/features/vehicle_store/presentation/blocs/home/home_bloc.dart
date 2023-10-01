import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/failure.dart';
import '../../../../../shared/presentation/toast/toast_controller.dart';
import '../../../domain/use_cases/get_vehicle_use_case.dart';
import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  final GetVehiclesUseCase _getVehicles;

  HomeBloc({
    required GetVehiclesUseCase getVehicles,
  })  : _getVehicles = getVehicles,
        super(HomeState.initial());

  int _page = 1;

  Future<void> nextPage() async {
    _page++;
    await getVehicles(_page);
    if (state.hasError) {
      _page--;
    }
  }

  Future<void> getVehicles(int page) async {
    emit(state.loading());
    final result = await _getVehicles(page);
    result.when(
      onSuccess: (data) {
        emit(state.success(data));
      },
      onFailure: (failure, cachedVehicles) {
        Toast.show(failure.message);
        emit(
          state.failure(
            vehicles: failure is NotFoundFailure //
                ? state.vehicles
                : cachedVehicles,
            message: failure.message,
          ),
        );
      },
    );
  }
}
