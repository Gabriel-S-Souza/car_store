import '../../../../shared/domain/entities/result.dart';
import '../../domain/entities/user_entity.dart';
import '../models/login_credentials_model.dart';

abstract class LoginDataSource {
  Future<Result<UserEntity>> login(LoginCredentialsModel credentials);
}
