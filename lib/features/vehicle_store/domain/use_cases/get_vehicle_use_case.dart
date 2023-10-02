import '../../../../shared/domain/entities/result.dart';
import '../entities/vehicle_entity.dart';
import '../repositories/vehicle_repository.dart';

abstract class GetVehiclesUseCase {
  Future<Result<List<VehicleEntity>>> call(int page);
}

class GetVehiclesUseCaseImp implements GetVehiclesUseCase {
  final VehicleReaderRepository _vehicleRepository;

  const GetVehiclesUseCaseImp({
    required VehicleReaderRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  @override
  Future<Result<List<VehicleEntity>>> call(int page) => _vehicleRepository.getVehicles(page);
}
