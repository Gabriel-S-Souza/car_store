import 'dart:typed_data';

import '../../../../shared/domain/entities/roles.dart';

class UserEntity {
  final String name;
  final String email;
  final Roles role;
  final Uint8List? image;

  UserEntity({
    required this.name,
    required this.email,
    this.image,
    required this.role,
  });

  factory UserEntity.visitor() => UserEntity(
        name: 'Visitante',
        email: '',
        role: Roles.visitor,
      );
}
