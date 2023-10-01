import 'dart:typed_data';

class VehicleEntity {
  final int id;
  final String name;
  final String brand;
  final String model;
  final Uint8List image;
  final double price;

  const VehicleEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.image,
    required this.price,
  });
}
