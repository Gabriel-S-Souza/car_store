import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../setups/utils/formatter.dart';
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
                      AutoSizeText(
                        vehicle.name,
                        maxLines: 1,
                        maxFontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 8),
                      AutoSizeText(
                        vehicle.brand,
                        maxLines: 1,
                        maxFontSize: 12,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AutoSizeText(
                        Formatter.doubleToCurrency(vehicle.price),
                        maxLines: 2,
                        maxFontSize: 10,
                        minFontSize: 6,
                        overflow: TextOverflow.ellipsis,
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
