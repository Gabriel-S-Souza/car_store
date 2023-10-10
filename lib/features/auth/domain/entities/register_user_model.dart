import 'dart:typed_data';

class RegisterUserEntity {
  final String name;
  final String email;
  final String password;
  final Uint8List? image;

  RegisterUserEntity({
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });
}
