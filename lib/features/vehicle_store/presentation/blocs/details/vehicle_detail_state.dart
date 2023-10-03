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
    final tableInformations = <Map<String, String>>[];
    tableInformations.add({'Ano': details.year.toString()});
    tableInformations.add({'Condição': details.condition.labelToDisplay});
    if (details.mileage != null) {
      tableInformations.add({'Kilometragem': details.mileage!.toString()});
    }
    if (details.engine != null && details.engine!.isNotEmpty) {
      tableInformations.add({'Motor': details.engine!});
    }
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
