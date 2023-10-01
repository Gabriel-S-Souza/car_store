import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/toast/toast_controller.dart';
import '../../../domain/entities/login_credentials_entity.dart';
import '../../../domain/use_cases/login_case.dart';
import 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  final LoginUseCase _login;

  LoginBloc({
    required LoginUseCase login,
  })  : _login = login,
        super(LoginState.initial());

  Future<void> login(String email, String password) async {
    emit(state.loading());
    final credentials = LoginCredentialsEntity(email: email, password: password);
    final result = await _login.login(credentials);
    result.when(
      onSuccess: (user) {
        emit(state.success(user));
      },
      onFailure: (failure, _) {
        Toast.show(failure.message);
        emit(state.error(failure.message));
      },
    );
  }

  void showPassword(bool show) {
    emit(LoginState(hidePassword: show));
  }
}
