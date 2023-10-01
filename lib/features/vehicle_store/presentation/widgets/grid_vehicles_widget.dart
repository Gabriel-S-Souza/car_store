import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../domain/entities/vehicle_entity.dart';
import 'vehicle_card_widget.dart';

class GridVehiclesWidget extends StatelessWidget {
  final bool isLoading;
  final List<VehicleEntity> vehicles;
  final void Function(VehicleEntity) onVehicleTap;

  const GridVehiclesWidget({
    super.key,
    this.vehicles = const <VehicleEntity>[],
    this.isLoading = false,
    required this.onVehicleTap,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24),
      itemCount: isLoading ? vehicles.length + 1 : vehicles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveBreakpoints.of(context).screenWidth >= 580
            ? orientation == Orientation.portrait
                ? 2
                : 3
            : 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) => isLoading && index == vehicles.length
          ? VehicleCardWidget.inLoading()
          : VehicleCardWidget(
              vehicle: vehicles[index],
              onTap: () => onVehicleTap(vehicles[index]),
            ),
    );
  }
}
