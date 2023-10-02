import '../../../../shared/domain/entities/result.dart';
import '../entities/vehicle_details_entity.dart';
import '../repositories/vehicle_writer_repositoty.dart';

abstract class UpdateVehicleUseCase {
  Future<Result<VoidSuccess>> call(VehicleDetailsEntity vehicle);
}

class UpdateVehicleUseCaseImp implements UpdateVehicleUseCase {
  final VehicleWriterRepository _vehicleRepository;

  const UpdateVehicleUseCaseImp({
    required VehicleWriterRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  @override
  Future<Result<VoidSuccess>> call(VehicleDetailsEntity vehicle) =>
      _vehicleRepository.updateVehicle(vehicle);
}
