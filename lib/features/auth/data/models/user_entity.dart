import '../../../../shared/domain/entities/roles.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] as String,
        email: json['email'] as String,
        role: Roles.values.firstWhere(
          (e) => e.label == json['role'],
          orElse: () => Roles.visitor,
        ),
      );
}
