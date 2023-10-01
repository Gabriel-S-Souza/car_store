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

  VehicleDetailsSuccess(this.details);
}

class VehicleDetailsError extends VehicleDetailsState {
  final String message;

  VehicleDetailsError(this.message);
}
