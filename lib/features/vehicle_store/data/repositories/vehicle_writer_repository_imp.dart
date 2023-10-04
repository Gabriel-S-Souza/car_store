import '../../../../shared/domain/entities/result.dart';
import '../../domain/entities/vehicle_details_entity.dart';
import '../../domain/repositories/vehicle_writer_repositoty.dart';
import '../data_sources/remoto/vehicle_data_source.dart';
import '../models/vehicle_details_model.dart';

class VehicleWriterRepositoryImp implements VehicleWriterRepository {
  final VehicleWriterDataSource _vehicleDataSource;

  VehicleWriterRepositoryImp({
    required VehicleWriterDataSource vehicleDataSource,
  }) : _vehicleDataSource = vehicleDataSource;

  @override
  Future<Result<VoidSuccess>> deleteVehicle(int vehicleId) =>
      _vehicleDataSource.deleteVehicle(vehicleId);

  @override
  Future<Result<VoidSuccess>> updateVehicle(VehicleDetailsEntity vehicle) =>
      _vehicleDataSource.updateVehicle(VehicleDetailsModel.fromEntity(vehicle));

  @override
  Future<Result<VoidSuccess>> registerVehicle(VehicleDetailsEntity vehicle) =>
      _vehicleDataSource.registerVehicle(VehicleDetailsModel.fromEntity(vehicle));
}
