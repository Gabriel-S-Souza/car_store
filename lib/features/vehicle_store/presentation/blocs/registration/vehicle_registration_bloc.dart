import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/toast/toast_controller.dart';
import '../../../domain/entities/vehicle_details_entity.dart';
import '../../../domain/use_cases/get_vehicle_details_use_case.dart';
import '../../../domain/use_cases/register_vehicle_use_case.dart';
import '../../../domain/use_cases/update_vehicle_use_case.dart';
import 'vehicle_registration_state.dart';

class VehicleRegistrationBloc extends Cubit<VehicleRegistrationState> {
  final RegisterVehicleUseCase _registerVehicle;
  final UpdateVehicleUseCase _updateVehicle;

  VehicleRegistrationBloc({
    required RegisterVehicleUseCase registerVehicle,
    required UpdateVehicleUseCase updateVehicle,
    required GetVehicleDetailsUseCase getVehicleDetails,
  })  : _registerVehicle = registerVehicle,
        _updateVehicle = updateVehicle,
        super(VehicleRegistrationInitial());

  Future<void> writeVehicle(VehicleDetailsEntity vehicle, bool isUpdate) async {
    emit(VehicleRegistrationLoading());
    final result = isUpdate
        ? await _updateVehicle(vehicle) //
        : await _registerVehicle(vehicle);

    result.when(
      onSuccess: (res) {
        Toast.show('Veículo registrado com sucesso!', backgroundColor: Colors.green);
        emit(VehicleRegistrationSuccess());
      },
      onFailure: (error, _) {
        Toast.show(error.message);
        emit(VehicleRegistrationError(error.message));
      },
    );
  }
}
