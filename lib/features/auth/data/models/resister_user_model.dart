import '../../domain/entities/register_user_model.dart';

class RegisterUserModel extends RegisterUserEntity {
  RegisterUserModel({
    required super.name,
    required super.email,
    required super.password,
  });

  factory RegisterUserModel.fromEntity(RegisterUserEntity entity) => RegisterUserModel(
        name: entity.name,
        email: entity.email,
        password: entity.password,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}
