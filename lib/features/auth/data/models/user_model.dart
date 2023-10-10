import 'dart:convert';
import 'dart:typed_data';

import '../../../../shared/domain/entities/roles.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    super.image,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] as String,
        email: json['email'] as String,
        image: json['image'] != null ? _decodeImage((json['image'] as String).codeUnits) : null,
        role: Roles.values.firstWhere(
          (e) => e.label == json['role'],
          orElse: () => Roles.visitor,
        ),
      );

  static Uint8List _decodeImage(List<int> imageData) {
    final base64String = String.fromCharCodes(imageData);
    return base64Decode(
        base64String.replaceAll(RegExp(r'data:image\/(webp|png|jpeg|jpg);base64,'), ''));
  }
}
