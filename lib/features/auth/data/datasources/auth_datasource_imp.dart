import '../../../../setups/api_routes/api_routes.dart';
import '../../../../setups/http/http_client.dart';
import '../../../../setups/local_storage/secure_local_storage.dart';
import '../../../../setups/utils/storage_keys.dart';
import '../../../../shared/domain/entities/failure.dart';
import '../../../../shared/domain/entities/result.dart';
import '../../domain/entities/user_entity.dart';
import '../models/login_credentials_model.dart';
import '../models/resister_user_model.dart';
import '../models/user_model.dart';
import 'auth_datasource.dart';

class AuthDataSourceImp implements AuthDataSource {
  final HttpClient _httpClient;
  final SecureLocalStorage _secureLocalStorage;

  AuthDataSourceImp({
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
        _secureLocalStorage.set(
          key: StorageKeys.accessToken,
          value: response.data['accessToken'],
        );
        _secureLocalStorage.set(
          key: StorageKeys.refreshToken,
          value: response.data['refreshToken'],
        );
        return Result.success(UserModel.fromJson(response.data['user']));
      } else {
        return Result.failure(UnmappedFailure(response.data['message']));
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnmappedFailure(e.toString()));
    }
  }

  @override
  Future<Result<VoidSuccess>> register(RegisterUserModel user) async {
    try {
      final response = await _httpClient.post(
        ApiRoutes.signup,
        body: user.toJson(),
      );
      if (response.isSuccess) {
        return Result.voidSuccess();
      } else {
        return Result.failure(UnmappedFailure(response.data['message']));
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnmappedFailure(e.toString()));
    }
  }
}
