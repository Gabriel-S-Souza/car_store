import '../../../../../shared/domain/entities/result.dart';
import '../../models/vehicle_details_model.dart';
import '../../models/vehicle_model.dart';

abstract class VehicleReaderDataSource {
  Future<Result<List<VehicleModel>>> getVehicles(int page);
  Future<Result<VehicleDetailsModel>> getDetails(int ivehicleId);
}

abstract class VehicleWriterDataSource {
  Future<Result<VoidSuccess>> registerVehicle(VehicleDetailsModel vehicle);
  Future<Result<VoidSuccess>> updateVehicle(VehicleDetailsModel vehicle);
  Future<Result<VoidSuccess>> deleteVehicle(int vehicleId);
}
