import 'dart:typed_data';

class VehicleDetailsEntity {
  final int id;
  final String name;
  final String brand;
  final String model;
  final int year;
  final int mileage;
  final Condition condition;
  final Uint8List image;
  final double price;
  final String description;
  final List<Map<String, String>> additionalInformations;

  const VehicleDetailsEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.mileage,
    required this.condition,
    required this.image,
    required this.price,
    required this.description,
    required this.additionalInformations,
  });
}

enum Condition {
  newVehicle('new', 'Novo'),
  used('used', 'Usado'),
  almostNew('almost_new', 'Semi novo'),
  inGoodCondition('in_good_condition', 'Em bom estado'),
  needsRepair('needs_repair', 'Precisa de reparos');

  final String label;
  final String labelToDisplay;

  const Condition(this.label, this.labelToDisplay);
}
