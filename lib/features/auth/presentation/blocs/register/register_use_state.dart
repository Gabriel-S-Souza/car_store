import 'package:equatable/equatable.dart';

class RegisterUserState extends Equatable {
  final bool isSuccess;
  final bool hidePassword;
  final bool hideConfirmPassword;
  final bool isLoading;
  final String? errorMessage;

  const RegisterUserState({
    this.isSuccess = false,
    this.hidePassword = true,
    this.hideConfirmPassword = true,
    this.isLoading = false,
    this.errorMessage,
  });

  factory RegisterUserState.initial() => const RegisterUserState();

  RegisterUserState loading() => copyWith(isLoading: true);

  RegisterUserState success() => copyWith(
        isSuccess: true,
        errorMessage: null,
        isLoading: false,
      );

  RegisterUserState error(String message) => copyWith(errorMessage: message, isLoading: false);

  RegisterUserState copyWith({
    bool? isSuccess,
    bool? hidePassword,
    bool? hideConfirmPassword,
    bool? isLoading,
    String? errorMessage,
  }) =>
      RegisterUserState(
        isSuccess: isSuccess ?? this.isSuccess,
        hidePassword: hidePassword ?? this.hidePassword,
        hideConfirmPassword: hideConfirmPassword ?? this.hideConfirmPassword,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        isSuccess,
        hidePassword,
        hideConfirmPassword,
        isLoading,
        errorMessage,
      ];
}
