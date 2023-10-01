import '../../../../setups/api_routes/api_routes.dart';
import '../../../../setups/http/http_client.dart';
import '../../../../setups/utils/storage_keys.dart';
import '../../../../shared/data/data_sources/secure_local_storage/secure_local_storage.dart';
import '../../../../shared/domain/entities/failure.dart';
import '../../../../shared/domain/entities/result.dart';
import '../../domain/entities/user_entity.dart';
import '../models/login_credentials_model.dart';
import '../models/user_entity.dart';
import 'login_datasource.dart';

class LoginDataSourceImp implements LoginDataSource {
  final HttpClient _httpClient;
  final SecureLocalStorage _secureLocalStorage;

  LoginDataSourceImp({
    required HttpClient httpClient,
    required SecureLocalStorage secureLocalStorage,
  })  : _httpClient = httpClient,
        _secureLocalStorage = secureLocalStorage;

  @override
  Future<Result<UserEntity>> login(LoginCredentialsModel credentials) async {
    try {
      final response = await _httpClient.post(
        ApiRoutes.login,
        body: credentials.toJson(),
      );
      if (response.isSuccess) {
        _secureLocalStorage.set(StorageKeys.accessToken, response.data['accessToken']);
        _secureLocalStorage.set(StorageKeys.refreshToken, response.data['refreshToken']);
        return Result.success(UserModel.fromJson(response.data['user']));
      } else {
        return Result.failure(UnmappedFailure(response.data.toString()));
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnmappedFailure(e.toString()));
    }
  }
}
