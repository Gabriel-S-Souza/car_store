import '../../../../../setups/api_routes/api_routes.dart';
import '../../../../../setups/http/http_client.dart';
import '../../../../../shared/domain/entities/failure.dart';
import '../../../../../shared/domain/entities/result.dart';
import '../../models/vehicle_details_model.dart';
import '../../models/vehicle_model.dart';
import 'vehicle_data_source.dart';

class VehicleReaderDataSourceImp implements VehicleReaderDataSource {
  final HttpClient _httpClient;

  VehicleReaderDataSourceImp({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<Result<List<VehicleModel>>> getVehicles([int page = 1]) async {
    try {
      final response = await _httpClient.get('/${ApiRoutes.vehicles}?page=$page');
      if (response.isSuccess) {
        final vehicles = (response.data as List).map((e) => VehicleModel.fromJson(e)).toList();
        return Result.success(vehicles);
      } else {
        return Result.failure(const ServerFailure());
      }
    } on NotFoundFailure catch (e) {
      return Result.failure(e);
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnmappedFailure(e.toString()));
    }
  }

  @override
  Future<Result<VehicleDetailsModel>> getDetails(int vehicleId) async {
    try {
      final response = await _httpClient.get('/${ApiRoutes.vehicles}/$vehicleId');
      if (response.isSuccess) {
        final vehicle = VehicleDetailsModel.fromJson(response.data);
        return Result.success(vehicle);
      } else {
        return Result.failure(const ServerFailure());
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnmappedFailure(e.toString()));
    }
  }
}
