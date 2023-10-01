import '../../../../shared/domain/entities/result.dart';
import '../entities/login_credentials_entity.dart';
import '../entities/register_user_model.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login(LoginCredentialsEntity credentialsEntity);
  Future<Result<VoidSuccess>> register(RegisterUserEntity userEntity);
}
