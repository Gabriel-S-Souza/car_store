import '../../../../../shared/domain/entities/result.dart';
import '../../models/vehicle_details_model.dart';
import '../../models/vehicle_model.dart';
import '../remoto/vehicle_data_source.dart';

abstract class VehicleCachingDataSource implements VehicleReaderDataSource {
  final VehicleReaderDataSource _vehicleRemoteDataSource;

  VehicleCachingDataSource({
    required VehicleReaderDataSource vehicleRemoteDataSource,
  }) : _vehicleRemoteDataSource = vehicleRemoteDataSource;

  @override
  Future<Result<List<VehicleModel>>> getVehicles([int page = 1]) =>
      _vehicleRemoteDataSource.getVehicles(page);

  @override
  Future<Result<VehicleDetailsModel>> getDetails(int vehicleId) =>
      _vehicleRemoteDataSource.getDetails(vehicleId);

  Future<List<VehicleModel>> getVehiclesFromCache();

  void saveVehiclesToCache(List<VehicleModel> vehicles);
}
