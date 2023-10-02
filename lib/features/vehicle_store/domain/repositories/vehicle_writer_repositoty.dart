import '../../../../shared/domain/entities/result.dart';
import '../entities/vehicle_details_entity.dart';

abstract class VehicleWriterRepository {
  Future<Result<VoidSuccess>> registerVehicle(VehicleDetailsEntity vehicle);
  Future<Result<VoidSuccess>> updateVehicle(VehicleDetailsEntity vehicle);
  Future<Result<VoidSuccess>> deleteVehicle(int vehicleId);
}
