import 'dart:developer';

import '../../../../shared/domain/entities/roles.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] as String,
        email: json['email'] as String,
        roles: Roles.values.firstWhere(
          (e) {
            log(e.label);
            return e.label == json['role'];
          },
          orElse: () => Roles.visitor,
        ),
      );
}
