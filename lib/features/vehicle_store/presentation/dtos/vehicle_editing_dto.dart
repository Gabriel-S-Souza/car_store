import 'dart:typed_data';

import '../../domain/entities/vehicle_details_entity.dart';

class VehicleEditingDto {
  int? id;
  String? name;
  String? brand;
  String? model;
  String? engine;
  Uint8List? image;
  int? year;
  int? mileage;
  Condition? condition;
  double? price;
  String? description;

  VehicleEditingDto({
    this.id,
    this.name,
    this.brand,
    this.model,
    this.engine,
    this.image,
    this.year,
    this.mileage,
    this.condition,
    this.price,
    this.description,
  });

  bool get isValid =>
      name != null &&
      name!.isNotEmpty &&
      brand != null &&
      brand!.isNotEmpty &&
      model != null &&
      model!.isNotEmpty &&
      image != null &&
      year != null &&
      year! > 0 &&
      condition != null &&
      condition!.label.isNotEmpty &&
      price != null &&
      price! > 0 &&
      description != null &&
      description!.isNotEmpty;

  VehicleDetailsEntity toEntity() {
    assert(isValid, 'VehicleEditingDto is not valid');
    return VehicleDetailsEntity(
      id: id ?? -1,
      name: name!,
      brand: brand!,
      model: model!,
      engine: engine,
      image: image ?? image!,
      year: year!,
      mileage: mileage,
      condition: condition!,
      price: price!,
      description: description!,
    );
  }

  VehicleEditingDto copyWith({
    Uint8List? image,
    int? id,
    String? name,
    String? brand,
    String? model,
    int? year,
    int? mileage,
    Condition? condition,
    double? price,
    String? description,
    String? engine,
    List<Map<String, String>>? additionalInformations,
  }) =>
      VehicleEditingDto(
        image: image ?? this.image,
        id: id ?? this.id,
        name: name ?? this.name,
        brand: brand ?? this.brand,
        model: model ?? this.model,
        year: year ?? this.year,
        mileage: mileage ?? this.mileage,
        condition: condition ?? this.condition,
        price: price ?? this.price,
        description: description ?? this.description,
        engine: engine ?? this.engine,
      );

  void addImage(Uint8List? newImage) => image = newImage;
}
