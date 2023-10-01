import '../../../../shared/domain/entities/result.dart';
import '../entities/login_credentials_entity.dart';
import '../entities/user_entity.dart';

abstract class LoginRepository {
  Future<Result<UserEntity>> login(LoginCredentialsEntity credentialsEntity);
}
