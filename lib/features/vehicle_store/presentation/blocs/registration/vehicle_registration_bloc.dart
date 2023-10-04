import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/toast/toast_controller.dart';
import '../../../domain/entities/vehicle_details_entity.dart';
import '../../../domain/use_cases/delete_vehicle_use_case.dart';
import '../../../domain/use_cases/register_vehicle_use_case.dart';
import '../../../domain/use_cases/update_vehicle_use_case.dart';
import 'vehicle_registration_state.dart';

class VehicleRegistrationBloc extends Cubit<VehicleRegistrationState> {
  final RegisterVehicleUseCase _registerVehicle;
  final UpdateVehicleUseCase _updateVehicle;
  final DeleteVehicleUseCase _deleteVehicle;

  VehicleRegistrationBloc({
    required RegisterVehicleUseCase registerVehicle,
    required UpdateVehicleUseCase updateVehicle,
    required DeleteVehicleUseCase deleteVehicle,
  })  : _registerVehicle = registerVehicle,
        _updateVehicle = updateVehicle,
        _deleteVehicle = deleteVehicle,
        super(VehicleRegistrationInitial());

  Future<void> writeVehicle(VehicleDetailsEntity vehicle, bool isUpdate) async {
    emit(VehicleRegistrationLoading());
    final result = isUpdate
        ? await _updateVehicle(vehicle) //
        : await _registerVehicle(vehicle);

    result.when(
      onSuccess: (res) {
        Toast.show(
          isUpdate ? 'Veículo atualizado com sucesso' : 'Veículo cadastrado com sucesso',
          backgroundColor: Colors.green,
        );
        emit(VehicleRegistrationSuccess(isUpdateOrRegister: true));
      },
      onFailure: (error, _) {
        Toast.show(error.message);
        emit(VehicleRegistrationError(error.message));
      },
    );
  }

  Future<bool> delete(int vehicleId) async {
    emit(VehicleRegistrationLoading());

    final result = await _deleteVehicle(vehicleId);

    if (result.isSuccess) {
      Toast.show('Veículo excluído');
      emit(VehicleRegistrationSuccess(isDelete: true));
    } else {
      Toast.show(result.failure.message);
    }
    return result.isSuccess;
  }

  void buy(int vehicleId) {
    Toast.show('Pedido enviado');
  }
}
