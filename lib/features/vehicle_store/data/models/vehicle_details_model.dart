import 'dart:convert';
import 'dart:typed_data';

import '../../domain/entities/vehicle_details_entity.dart';

class VehicleDetailsModel extends VehicleDetailsEntity {
  VehicleDetailsModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.model,
    required super.year,
    required super.condition,
    required super.image,
    required super.price,
    required super.description,
    super.engine,
    super.mileage,
  });

  factory VehicleDetailsModel.fromEntity(VehicleDetailsEntity entity) => VehicleDetailsModel(
        id: entity.id,
        name: entity.name,
        brand: entity.brand,
        model: entity.model,
        year: entity.year,
        mileage: entity.mileage,
        engine: entity.engine,
        condition: entity.condition,
        image: entity.image,
        price: entity.price,
        description: entity.description,
      );

  factory VehicleDetailsModel.fromJson(Map<String, dynamic> json) => VehicleDetailsModel(
        id: json['id'] as int,
        name: json['name'] as String,
        brand: json['brand'] as String,
        model: json['model'] as String,
        year: json['year'] as int,
        mileage: json['mileage'] as int?,
        engine: json['engine'] as String?,
        condition: Condition.fromLabel(json['condition'] as String),
        image: _decodeImage((json['image'] as String).codeUnits),
        price: json['price'] is int ? (json['price'] as int).toDouble() : json['price'] as double,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'brand': brand,
        'model': model,
        'image': _encodeImage(image),
        'price': price,
        'description': description,
        'year': year,
        'mileage': mileage,
        'engine': engine,
        'condition': condition.label,
      };

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
