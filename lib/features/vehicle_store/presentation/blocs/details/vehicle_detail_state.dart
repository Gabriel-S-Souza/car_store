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

  VehicleDetailsSuccess._internal(this.details);

  factory VehicleDetailsSuccess(VehicleDetailsEntity details) =>
      VehicleDetailsSuccess._internal(details);

  VehicleDetailsSuccess deleted() => copyWith();

  List<Map<String, String>> get tableInformations {
    final tableInformations = <Map<String, String>>[];
    tableInformations.add({'Ano': details.year.toString()});
    tableInformations.add({'Condição': details.condition.labelToDisplay});
    if (details.mileage != null) {
      tableInformations.add({'Quilometragem': details.mileage!.toString()});
    }
    if (details.engine != null && details.engine!.isNotEmpty) {
      tableInformations.add({'Motor': details.engine!});
    }
    return tableInformations;
  }

  VehicleDetailsSuccess copyWith({
    VehicleDetailsEntity? details,
    bool? isDeleted,
    bool? deleteLoading,
  }) =>
      VehicleDetailsSuccess._internal(
        details ?? this.details,
      );
}

class VehicleDetailsError extends VehicleDetailsState {
  final String message;

  VehicleDetailsError(this.message);
}
