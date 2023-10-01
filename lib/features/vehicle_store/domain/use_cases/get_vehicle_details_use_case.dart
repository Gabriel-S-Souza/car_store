import '../../../../shared/domain/entities/result.dart';
import '../entities/vehicle_details_entity.dart';
import '../repositories/vehicle_repository.dart';

abstract class GetVehicleDetailsUseCase {
  Future<Result<VehicleDetailsEntity>> getDetails(int vehicleId);
}

class GetVehicleDetailsUseCaseImp implements GetVehicleDetailsUseCase {
  final VehicleRepository _vehicleRepository;

  const GetVehicleDetailsUseCaseImp({
    required VehicleRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  @override
  Future<Result<VehicleDetailsEntity>> getDetails(int vehicleId) =>
      _vehicleRepository.getDetails(vehicleId);
}
