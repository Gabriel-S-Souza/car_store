import '../../../../shared/domain/entities/roles.dart';

class UserEntity {
  final String name;
  final String email;
  final Roles roles;

  UserEntity({
    required this.name,
    required this.email,
    required this.roles,
  });
}
