import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/toast/toast_controller.dart';
import '../../../domain/use_cases/get_vehicle_details_use_case.dart';
import 'vehicle_detail_state.dart';

class VehicleDetailsBloc extends Cubit<VehicleDetailsState> {
  final GetVehicleDetailsUseCase _getVehicleDetails;

  VehicleDetailsBloc({
    required GetVehicleDetailsUseCase getVehicleDetails,
  })  : _getVehicleDetails = getVehicleDetails,
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
}
