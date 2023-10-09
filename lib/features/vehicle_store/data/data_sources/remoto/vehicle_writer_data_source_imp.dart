import '../../../../../setups/api_routes/api_routes.dart';
import '../../../../../setups/http/http_client.dart';
import '../../../../../setups/local_storage/secure_local_storage.dart';
import '../../../../../setups/utils/storage_keys.dart';
import '../../../../../shared/domain/entities/failure.dart';
import '../../../../../shared/domain/entities/result.dart';
import '../../interceptors/check_token_interceptor.dart';
import '../../models/vehicle_details_model.dart';
import 'vehicle_data_source.dart';

class VehicleWriterDataSourceImp implements VehicleWriterDataSource {
  final HttpClient _httpClient;
  final SecureLocalStorage _secureLocalStorage;

  VehicleWriterDataSourceImp({
    required HttpClient httpClient,
    required SecureLocalStorage secureLocalStorage,
  })  : _httpClient = httpClient,
        _secureLocalStorage = secureLocalStorage {
    _httpClient.addInterceptor(CheckTokenInterceptor());
  }

  @override
  Future<Result<VoidSuccess>> registerVehicle(VehicleDetailsModel vehicle) async {
    try {
      final response = await _httpClient.post(
        ApiRoutes.vehicles,
        body: vehicle.toJson(),
        accessToken: await _secureLocalStorage.get(StorageKeys.accessToken),
      );
      if (response.isSuccess) {
        return Result.voidSuccess();
      } else {
        return Result.failure(const ServerFailure());
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnmappedFailure(e.toString()));
    }
  }

  @override
  Future<Result<VoidSuccess>> updateVehicle(VehicleDetailsModel vehicle) async {
    try {
      final response = await _httpClient.put(
        '${ApiRoutes.vehicles}/${vehicle.id}',
        body: vehicle.toJson(),
        accessToken: await _secureLocalStorage.get(StorageKeys.accessToken),
      );
      if (response.isSuccess) {
        return Result.voidSuccess();
      } else {
        return Result.failure(const ServerFailure());
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnmappedFailure(e.toString()));
    }
  }

  @override
  Future<Result<VoidSuccess>> deleteVehicle(int vehicleId) async {
    try {
      final response = await _httpClient.delete(
        '${ApiRoutes.vehicles}/$vehicleId',
        accessToken: await _secureLocalStorage.get(StorageKeys.accessToken),
      );
      if (response.isSuccess) {
        return Result.voidSuccess();
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
