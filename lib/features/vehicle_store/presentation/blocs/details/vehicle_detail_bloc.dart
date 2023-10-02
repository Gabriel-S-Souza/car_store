import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/toast/toast_controller.dart';
import '../../../domain/use_cases/delete_vehicle_use_case.dart';
import '../../../domain/use_cases/get_vehicle_details_use_case.dart';
import 'vehicle_detail_state.dart';

class VehicleDetailsBloc extends Cubit<VehicleDetailsState> {
  final GetVehicleDetailsUseCase _getVehicleDetails;
  final DeleteVehicleUseCase _deleteVehicle;

  VehicleDetailsBloc({
    required GetVehicleDetailsUseCase getVehicleDetails,
    required DeleteVehicleUseCase deleteVehicle,
  })  : _getVehicleDetails = getVehicleDetails,
        _deleteVehicle = deleteVehicle,
        super(VehicleDetailsInitial());

  Future<void> getDetails(int vehicleId) async {
    emit(VehicleDetailsLoading());
    final result = await _getVehicleDetails(vehicleId);

    result.when(onSuccess: (details) {
      emit(VehicleDetailsSuccess(details));
    }, onFailure: (failure, _) {
      Toast.show(failure.message);
      emit(VehicleDetailsError(failure.message));
    });
  }

  Future<void> deleteVehicle(int vehicleId) async {
    if (state is! VehicleDetailsSuccess) return;
    emit(VehicleDetailsLoading());
    final result = await _deleteVehicle(vehicleId);

    result.when(onSuccess: (res) {
      Toast.show('Veículo deletado');
      emit((state as VehicleDetailsSuccess).deleted());
    }, onFailure: (failure, _) {
      Toast.show(failure.message);
      emit(VehicleDetailsError(failure.message));
    });
  }
}
