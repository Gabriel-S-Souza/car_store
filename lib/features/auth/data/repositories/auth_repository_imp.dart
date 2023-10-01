import '../../../../shared/domain/entities/result.dart';
import '../../domain/entities/login_credentials_entity.dart';
import '../../domain/entities/register_user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/auth_datasource.dart';
import '../models/login_credentials_model.dart';
import '../models/resister_user_model.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImp({
    required AuthDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  @override
  Future<Result<UserEntity>> login(LoginCredentialsEntity credentials) =>
      _authDataSource.login(LoginCredentialsModel.fromEntity(credentials));

  @override
  Future<Result<VoidSuccess>> register(RegisterUserEntity user) =>
      _authDataSource.register(RegisterUserModel.fromEntity(user));
}
