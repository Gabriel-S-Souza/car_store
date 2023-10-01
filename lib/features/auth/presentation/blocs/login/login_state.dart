import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

class LoginState extends Equatable {
  final UserEntity? user;
  final bool hidePassword;
  final bool isLoading;
  final String? errorMessage;

  const LoginState({
    this.user,
    this.hidePassword = true,
    this.isLoading = false,
    this.errorMessage,
  });

  factory LoginState.initial() => const LoginState();

  LoginState loading() => copyWith(isLoading: true);

  LoginState success(UserEntity user) => copyWith(
        user: user,
        errorMessage: null,
        isLoading: false,
      );

  LoginState error(String message) => copyWith(errorMessage: message, isLoading: false);

  LoginState copyWith({
    UserEntity? user,
    bool? hidePassword,
    bool? isLoading,
    String? errorMessage,
  }) =>
      LoginState(
        user: user ?? this.user,
        hidePassword: hidePassword ?? this.hidePassword,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        user,
        hidePassword,
        isLoading,
        errorMessage,
      ];
}
