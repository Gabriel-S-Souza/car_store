import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/toast/toast_controller.dart';
import '../../../domain/entities/register_user_model.dart';
import '../../../domain/use_cases/register_user_use_case.dart';
import 'register_use_state.dart';

class RegisterUserBloc extends Cubit<RegisterUserState> {
  final RegisterUserUseCase _registerUser;

  RegisterUserBloc({
    required RegisterUserUseCase registerUser,
  })  : _registerUser = registerUser,
        super(RegisterUserState.initial());

  Future<void> register(String name, String email, String password, Uint8List? image) async {
    emit(state.loading());
    final user = RegisterUserEntity(
      name: name,
      email: email,
      password: password,
      image: image,
    );
    final result = await _registerUser(user);
    result.when(
      onSuccess: (user) {
        Toast.show('Usuário cadastrado com sucesso!');
        emit(state.success());
      },
      onFailure: (failure, _) {
        Toast.show(failure.message);
        emit(state.error(failure.message));
      },
    );
  }

  void hidePassword(bool hide) {
    emit(state.copyWith(hidePassword: hide));
  }

  void hideConfirmPassword(bool hide) {
    emit(state.copyWith(hideConfirmPassword: hide));
  }
}
