import 'package:equatable/equatable.dart';

import '../../../domain/entities/vehicle_details_entity.dart';

class VehicleDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VehicleDetailsInitial extends VehicleDetailsState {}

class VehicleDetailsLoading extends VehicleDetailsState {}

class VehicleDetailsSuccess extends VehicleDetailsState {
  final VehicleDetailsEntity details;
  final bool isDeleted;

  VehicleDetailsSuccess._internal(this.details, {this.isDeleted = false});

  factory VehicleDetailsSuccess(VehicleDetailsEntity details) =>
      VehicleDetailsSuccess._internal(details);

  VehicleDetailsSuccess deleted() => copyWith(isDeleted: true);

  List<Map<String, String>> get tableInformations {
    final tableInformations = [
      {
        'key': 'Ano',
        'value': details.year.toString(),
      },
      {
        'key': 'Km',
        'value': details.mileage.toString(),
      },
      {
        'key': 'Condição',
        'value': details.condition.labelToDisplay,
      },
      ...details.additionalInformations,
    ];
    return tableInformations;
  }

  VehicleDetailsSuccess copyWith({
    VehicleDetailsEntity? details,
    bool? isDeleted,
  }) =>
      VehicleDetailsSuccess._internal(
        details ?? this.details,
        isDeleted: isDeleted ?? this.isDeleted,
      );
}

class VehicleDetailsError extends VehicleDetailsState {
  final String message;

  VehicleDetailsError(this.message);
}
