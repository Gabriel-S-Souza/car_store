import 'dart:convert';
import 'dart:typed_data';

import '../../domain/entities/register_user_model.dart';

class RegisterUserModel extends RegisterUserEntity {
  RegisterUserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.image,
  });

  factory RegisterUserModel.fromEntity(RegisterUserEntity entity) => RegisterUserModel(
        name: entity.name,
        email: entity.email,
        password: entity.password,
        image: entity.image,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'image': image != null ? _encodeImage(image!) : null,
      };

  String _encodeImage(Uint8List img) {
    final base64String = base64Encode(img);
    return 'data:image/png;base64,$base64String';
  }
}
