import '../../../../shared/domain/entities/result.dart';
import '../entities/vehicle_details_entity.dart';
import '../repositories/vehicle_writer_repositoty.dart';

abstract class RegisterVehicleUseCase {
  Future<Result<VoidSuccess>> call(VehicleDetailsEntity vehicle);
}

class RegisterVehicleUseCaseImp implements RegisterVehicleUseCase {
  final VehicleWriterRepository _vehicleRepository;

  const RegisterVehicleUseCaseImp({
    required VehicleWriterRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  @override
  Future<Result<VoidSuccess>> call(VehicleDetailsEntity vehicle) =>
      _vehicleRepository.registerVehicle(vehicle);
}
