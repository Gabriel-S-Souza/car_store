import 'dart:typed_data';

class VehicleDetailsEntity {
  final int id;
  final String name;
  final String brand;
  final String model;
  final Uint8List image;
  final double price;
  final String description;
  final List<Map<String, String>> additionalInformations;

  const VehicleDetailsEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.image,
    required this.price,
    required this.description,
    required this.additionalInformations,
  });
}
