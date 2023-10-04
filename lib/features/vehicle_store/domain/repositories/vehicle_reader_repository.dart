import '../../../../shared/domain/entities/result.dart';
import '../entities/vehicle_details_entity.dart';
import '../entities/vehicle_entity.dart';

abstract class VehicleReaderRepository {
  Future<Result<List<VehicleEntity>>> getVehicles(int page);
  Future<Result<VehicleDetailsEntity>> getDetails(int ivehicleId);
}
