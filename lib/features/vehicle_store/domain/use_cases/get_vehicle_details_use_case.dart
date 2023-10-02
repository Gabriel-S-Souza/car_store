import '../../../../shared/domain/entities/result.dart';
import '../entities/vehicle_details_entity.dart';
import '../repositories/vehicle_repository.dart';

abstract class GetVehicleDetailsUseCase {
  Future<Result<VehicleDetailsEntity>> call(int vehicleId);
}

class GetVehicleDetailsUseCaseImp implements GetVehicleDetailsUseCase {
  final VehicleReaderRepository _vehicleRepository;

  const GetVehicleDetailsUseCaseImp({
    required VehicleReaderRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  @override
  Future<Result<VehicleDetailsEntity>> call(int vehicleId) =>
      _vehicleRepository.getDetails(vehicleId);
}
