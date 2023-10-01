import '../../../../shared/domain/entities/result.dart';
import '../entities/login_credentials_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

abstract class LoginUseCase {
  Future<Result<UserEntity>> login(LoginCredentialsEntity credentialsEntity);
}

class LoginUseCaseImp implements LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCaseImp({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<Result<UserEntity>> login(LoginCredentialsEntity credentialsEntity) async =>
      _loginRepository.login(credentialsEntity);
}
