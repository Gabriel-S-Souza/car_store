import 'dart:convert';
import 'dart:typed_data';

import '../../domain/entities/vehicle_details_entity.dart';

class VehicleDetailsModel extends VehicleDetailsEntity {
  VehicleDetailsModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.model,
    required super.image,
    required super.price,
    required super.description,
    required super.additionalInformations,
  });

  factory VehicleDetailsModel.fromJson(Map<String, dynamic> json) => VehicleDetailsModel(
        id: json['id'] as int,
        name: json['name'] as String,
        brand: json['brand'] as String,
        model: json['model'] as String,
        image: _decodeImage(json['image'] as List<int>),
        price: json['price'] as double,
        description: json['description'] as String,
        additionalInformations: (json['additionalInformations'] as List<dynamic>)
            .map(
              (e) => e as Map<String, String>,
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'brand': brand,
        'model': model,
        'image': _encodeImage(image),
        'price': price,
        'description': description,
        'additionalInformations': additionalInformations,
      };

  static Uint8List _decodeImage(List<int> imageData) {
    final base64String = String.fromCharCodes(imageData);
    return base64Decode(base64String.replaceAll('data:image/png;base64,', ''));
  }

  List<int> _encodeImage(Uint8List img) {
    final base64String = base64Encode(img);
    final encodedImage = 'data:image/png;base64,$base64String';
    return encodedImage.codeUnits;
  }
}
