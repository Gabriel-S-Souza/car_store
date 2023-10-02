import 'package:flutter/material.dart';

import '../../../../shared/presentation/toast/toast_controller.dart';

class CreateVehicleScreen extends StatefulWidget {
  final int? vehicleId;
  const CreateVehicleScreen({super.key, this.vehicleId});

  @override
  State<CreateVehicleScreen> createState() => _CreateVehicleScreenState();
}

class _CreateVehicleScreenState extends State<CreateVehicleScreen> {
  @override
  void initState() {
    if (widget.vehicleId != null) {
      Toast.show('VehicleId: ${widget.vehicleId}');
    } else {
      Toast.show('VehicleId is null');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Create Vehicle'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Brand'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Condition'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mileage'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Create Vehicle'),
              ),
            ],
          ),
        ),
      );
}
