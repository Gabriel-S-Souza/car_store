import 'dart:convert';
import 'dart:typed_data';

import '../../domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  VehicleModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.model,
    required super.image,
    required super.price,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json['id'] as int,
        name: json['name'] as String,
        brand: json['brand'] as String,
        model: json['model'] as String,
        image: _decodeImage((json['image'] as String).codeUnits),
        price: json['price'] is int ? (json['price'] as int).toDouble() : json['price'] as double,
      );

  Map<String, dynamic> toJson({bool withId = false}) {
    final data = {
      'name': name,
      'brand': brand,
      'model': model,
      'image': _encodeImage(image),
      'price': price,
    };
    if (withId) {
      data['id'] = id;
    }
    return data;
  }

  static Uint8List _decodeImage(List<int> imageData) {
    final base64String = String.fromCharCodes(imageData);
    return base64Decode(
        base64String.replaceAll(RegExp(r'data:image\/(webp|png|jpeg|jpg);base64,'), ''));
  }

  String _encodeImage(Uint8List img) {
    final base64String = base64Encode(img);
    return 'data:image/png;base64,$base64String';
  }
}
