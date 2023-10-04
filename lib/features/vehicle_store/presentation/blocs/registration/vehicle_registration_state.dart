import 'package:equatable/equatable.dart';

class VehicleRegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VehicleRegistrationInitial extends VehicleRegistrationState {}

class VehicleRegistrationLoading extends VehicleRegistrationState {}

class VehicleRegistrationSuccess extends VehicleRegistrationState {
  final bool isUpdateOrRegister;
  final bool isDelete;

  VehicleRegistrationSuccess({this.isUpdateOrRegister = false, this.isDelete = false});
}

class VehicleRegistrationError extends VehicleRegistrationState {
  final String message;

  VehicleRegistrationError(this.message);
}
