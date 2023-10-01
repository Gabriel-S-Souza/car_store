import '../../../../shared/domain/entities/result.dart';
import '../../domain/entities/login_credentials_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_datasource.dart';
import '../models/login_credentials_model.dart';

class LoginRepositoryImp implements LoginRepository {
  final LoginDataSource _loginDataSource;

  LoginRepositoryImp({
    required LoginDataSource loginDataSource,
  }) : _loginDataSource = loginDataSource;

  @override
  Future<Result<UserEntity>> login(LoginCredentialsEntity credentials) =>
      _loginDataSource.login(LoginCredentialsModel.fromEntity(credentials));
}
