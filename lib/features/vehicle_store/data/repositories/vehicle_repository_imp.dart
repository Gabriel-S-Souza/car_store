import '../../../../shared/domain/entities/result.dart';
import '../../domain/entities/vehicle_details_entity.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../data_sources/remoto/vehicle_data_source.dart';

class VehicleRepositoryImp implements VehicleRepository {
  final VehicleDataSource _vehicleDataSource;

  VehicleRepositoryImp({
    required VehicleDataSource vehicleDataSource,
  }) : _vehicleDataSource = vehicleDataSource;

  @override
  Future<Result<List<VehicleEntity>>> getVehicles([int page = 1]) =>
      _vehicleDataSource.getVehicles(page);

  @override
  Future<Result<VehicleDetailsEntity>> getDetails(int vehicleId) =>
      _vehicleDataSource.getDetails(vehicleId);
}
