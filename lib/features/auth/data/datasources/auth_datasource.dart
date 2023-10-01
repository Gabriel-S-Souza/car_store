import '../../../../shared/domain/entities/result.dart';
import '../../domain/entities/user_entity.dart';
import '../models/login_credentials_model.dart';
import '../models/resister_user_model.dart';

abstract class AuthDataSource {
  Future<Result<UserEntity>> login(LoginCredentialsModel credentials);
  Future<Result<VoidSuccess>> register(RegisterUserModel user);
}
