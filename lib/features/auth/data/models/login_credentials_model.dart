import '../../domain/entities/login_credentials_entity.dart';

class LoginCredentialsModel extends LoginCredentialsEntity {
  LoginCredentialsModel({required super.email, required super.password});

  factory LoginCredentialsModel.fromEntity(LoginCredentialsEntity entity) => LoginCredentialsModel(
        email: entity.email,
        password: entity.password,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
