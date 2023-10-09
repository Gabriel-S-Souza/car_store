import '../../../../setups/api_routes/api_routes.dart';
import '../../../../setups/http/http_client.dart';
import '../../../../setups/local_storage/secure_local_storage.dart';
import '../../../../setups/utils/storage_keys.dart';
import '../../../../shared/domain/entities/failure.dart';
import '../../../../shared/domain/entities/result.dart';
import 'refresh_token_data_source.dart';

class RefreshTokenDataSourceImp implements RefreshTokenDataSource {
  final HttpClient _httpClient;
  final SecureLocalStorage _secureLocalStorage;

  RefreshTokenDataSourceImp({
    required HttpClient httpClient,
    required SecureLocalStorage secureLocalStorage,
  })  : _httpClient = httpClient,
        _secureLocalStorage = secureLocalStorage;

  @override
  Future<Result<VoidSuccess>> get() async {
    try {
      final response = await _httpClient.post(
        ApiRoutes.refreshToken,
        body: {
          'refreshToken': await _secureLocalStorage.get(StorageKeys.refreshToken),
        },
      );

      if (response.isSuccess) {
        await _secureLocalStorage.set(
          key: StorageKeys.accessToken,
          value: response.data['accessToken'],
        );
        await _secureLocalStorage.set(
          key: StorageKeys.refreshToken,
          value: response.data['refreshToken'],
        );
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
