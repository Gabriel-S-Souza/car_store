import 'dart:typed_data';

class VehicleDetailsEntity {
  final int id;
  final String name;
  final String brand;
  final String model;
  final int year;
  final Condition condition;
  final Uint8List image;
  final double price;
  final String description;
  final String? engine;
  final int? mileage;

  const VehicleDetailsEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.condition,
    required this.image,
    required this.price,
    required this.description,
    this.engine,
    this.mileage,
  });
}

enum Condition {
  newVehicle('new', 'Novo'),
  almostNew('almost_new', 'Semi novo'),
  used('used', 'Usado'),
  inGoodCondition('in_good_condition', 'Em bom estado'),
  needsRepair('needs_repair', 'Precisa de reparos');

  final String label;
  final String labelToDisplay;

  const Condition(this.label, this.labelToDisplay);

  static Condition fromLabel(String label) => Condition.values.firstWhere(
        (e) => e.label == label,
        orElse: () => Condition.used,
      );
}
