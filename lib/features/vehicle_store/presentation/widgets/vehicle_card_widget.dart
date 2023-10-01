import 'package:flutter/material.dart';

import '../../domain/entities/vehicle_entity.dart';

class VehicleCardWidget extends StatelessWidget {
  final VehicleEntity? _vehicle;
  final VoidCallback onTap;
  final bool isLoading;

  const VehicleCardWidget.internal({
    super.key,
    required VehicleEntity? vehicle,
    required this.onTap,
    this.isLoading = false,
  }) : _vehicle = vehicle;

  factory VehicleCardWidget({
    required VehicleEntity vehicle,
    required VoidCallback onTap,
  }) =>
      VehicleCardWidget.internal(
        vehicle: vehicle,
        onTap: onTap,
        isLoading: false,
      );

  factory VehicleCardWidget.inLoading() => VehicleCardWidget.internal(
        vehicle: null,
        onTap: () {},
        isLoading: true,
      );

  VehicleEntity get vehicle {
    assert(_vehicle != null, 'Vehicle is null');
    return _vehicle!;
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: isLoading ? null : onTap,
        child: Card(
          child: Column(
            children: [
              if (isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (!isLoading)
                Expanded(
                  flex: 2,
                  child: Image.memory(
                    vehicle.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              if (!isLoading) ...[
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(vehicle.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      const Divider(height: 8),
                      Text(
                        vehicle.brand,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'R\$ ${(vehicle.price).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      );
}
