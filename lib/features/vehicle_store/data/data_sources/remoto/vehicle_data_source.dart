import '../../../../../shared/domain/entities/result.dart';
import '../../models/vehicle_details_model.dart';
import '../../models/vehicle_model.dart';

abstract class VehicleDataSource {
  Future<Result<List<VehicleModel>>> getVehicles(int page);
  Future<Result<VehicleDetailsModel>> getDetails(int ivehicleId);
}
