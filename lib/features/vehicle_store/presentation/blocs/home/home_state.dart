import 'package:equatable/equatable.dart';

import '../../../domain/entities/vehicle_entity.dart';

class HomeState extends Equatable {
  final List<VehicleEntity> vehicles;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.vehicles = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  bool get hasError => errorMessage != null;

  HomeState copyWith({
    List<VehicleEntity>? vehicles,
    bool? isLoading,
    String? errorMessage,
  }) =>
      HomeState(
        vehicles: vehicles ?? this.vehicles,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
      );

  static HomeState initial() => const HomeState();

  HomeState loading() => copyWith(isLoading: true, errorMessage: null);

  HomeState success(List<VehicleEntity> vehicles) => copyWith(
        vehicles: List<VehicleEntity>.from(this.vehicles)..addAll(vehicles),
        isLoading: false,
      );

  HomeState failure({
    required String message,
    List<VehicleEntity>? vehicles,
  }) =>
      copyWith(
        vehicles: vehicles,
        errorMessage: message,
        isLoading: false,
      );

  @override
  List<Object?> get props => [vehicles, isLoading, errorMessage];
}
