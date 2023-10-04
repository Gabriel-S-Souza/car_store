import '../../../../shared/domain/entities/result.dart';
import '../repositories/vehicle_writer_repositoty.dart';

abstract class DeleteVehicleUseCase {
  Future<Result<VoidSuccess>> call(int vehicleId);
}

class DeleteVehicleUseCaseImp implements DeleteVehicleUseCase {
  final VehicleWriterRepository _vehicleRepository;

  const DeleteVehicleUseCaseImp({
    required VehicleWriterRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  @override
  Future<Result<VoidSuccess>> call(int vehicleId) => _vehicleRepository.deleteVehicle(vehicleId);
}
