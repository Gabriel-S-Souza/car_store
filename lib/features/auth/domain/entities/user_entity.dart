import '../../../../shared/domain/entities/roles.dart';

class UserEntity {
  final String name;
  final String email;
  final Roles role;

  UserEntity({
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserEntity.visitor() => UserEntity(
        name: 'Visitante',
        email: '',
        role: Roles.visitor,
      );
}
