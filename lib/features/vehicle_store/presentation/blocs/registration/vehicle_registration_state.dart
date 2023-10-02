import 'package:equatable/equatable.dart';

class VehicleRegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VehicleRegistrationInitial extends VehicleRegistrationState {}

class VehicleRegistrationLoading extends VehicleRegistrationState {}

class VehicleRegistrationSuccess extends VehicleRegistrationState {}

class VehicleRegistrationError extends VehicleRegistrationState {
  final String message;

  VehicleRegistrationError(this.message);
}
