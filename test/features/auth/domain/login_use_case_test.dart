import 'package:car_store/features/auth/domain/entities/login_credentials_entity.dart';
import 'package:car_store/features/auth/domain/entities/user_entity.dart';
import 'package:car_store/features/auth/domain/use_cases/login_use_case.dart';
import 'package:car_store/shared/domain/entities/failure.dart';
import 'package:car_store/shared/domain/entities/result.dart';
import 'package:car_store/shared/domain/entities/roles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/build_mocks.mocks.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    loginUseCase = LoginUseCaseImp(authRepository: mockRepository);
  });

  group('LoginUseCase.login |', () {
    test('success: should return a Result with a UserEntity', () async {
      // Arrange
      final credentials =
          LoginCredentialsEntity(email: 'jonhdoe@teste.com', password: 'JonhDoe123@');
      final user = UserEntity(email: credentials.email, name: 'John Doe', role: Roles.admin);

      final Matcher isValidUser = isA<UserEntity>()
          .having((user) => user.email, 'email', isA<String>())
          .having((user) => user.name, 'name', isA<String>())
          .having((user) => user.role, 'role', isA<Roles>());

      when(mockRepository.login(credentials)).thenAnswer((_) async => Result.success(user));

      // Act
      final result = await loginUseCase(credentials);

      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.data, isValidUser);

      verify(mockRepository.login(credentials)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
        'failure: when the response of the repository is unsuccessful, should return a Result with a Failure',
        () async {
      // Arrange
      const String errorMessage = 'Failed to login';
      final credentials =
          LoginCredentialsEntity(email: 'jonhdoe@teste.com', password: 'JonhDoe123@');

      when(mockRepository.login(credentials))
          .thenAnswer((_) async => Result.failure(const Failure(errorMessage)));

      // Act
      final result = await loginUseCase(credentials);

      // Assert
      expect(result.isSuccess, isFalse);
      expect(result.failure, isA<Failure>());
      expect(result.failure.message, isA<String>());

      verify(mockRepository.login(credentials)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
