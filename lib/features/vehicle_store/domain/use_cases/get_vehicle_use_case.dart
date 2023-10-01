import '../../../../shared/domain/entities/result.dart';
import '../entities/vehicle_entity.dart';
import '../repositories/vehicle_repository.dart';

abstract class GetVehiclesUseCase {
  Future<Result<List<VehicleEntity>>> call(int page);
}

class GetVehiclesUseCaseImp implements GetVehiclesUseCase {
  final VehicleRepository _vehicleRepository;

  const GetVehiclesUseCaseImp({
    required VehicleRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  @override
  Future<Result<List<VehicleEntity>>> call(int page) => _vehicleRepository.getVehicles(page);
}
