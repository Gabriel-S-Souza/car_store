import '../../../../shared/domain/entities/result.dart';
import '../entities/register_user_model.dart';
import '../repositories/login_repository.dart';

abstract class RegisterUserUseCase {
  Future<Result<VoidSuccess>> call(RegisterUserEntity userEntity);
}

class RegisterUserUseCaseImp implements RegisterUserUseCase {
  final AuthRepository _authRepository;

  RegisterUserUseCaseImp({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Result<VoidSuccess>> call(RegisterUserEntity user) async => _authRepository.register(user);
}
