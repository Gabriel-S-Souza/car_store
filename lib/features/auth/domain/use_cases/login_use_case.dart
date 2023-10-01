import '../../../../shared/domain/entities/result.dart';
import '../entities/login_credentials_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

abstract class LoginUseCase {
  Future<Result<UserEntity>> call(LoginCredentialsEntity credentialsEntity);
}

class LoginUseCaseImp implements LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCaseImp({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Result<UserEntity>> call(LoginCredentialsEntity credentialsEntity) async =>
      _authRepository.login(credentialsEntity);
}
