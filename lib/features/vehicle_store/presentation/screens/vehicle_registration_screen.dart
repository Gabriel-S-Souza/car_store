import 'package:flutter/material.dart';

import '../../../../shared/presentation/toast/toast_controller.dart';
import '../../../../shared/presentation/widgets/elevate_button_widget.dart';
import '../../../../shared/presentation/widgets/header_screen_widget.dart';

class VehicleRegistrationScreen extends StatefulWidget {
  final int? vehicleId;
  const VehicleRegistrationScreen({super.key, this.vehicleId});

  @override
  State<VehicleRegistrationScreen> createState() => _VehicleRegistrationScreenState();
}

class _VehicleRegistrationScreenState extends State<VehicleRegistrationScreen> {
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
        appBar: HeaderScreenWidget(
          title: widget.vehicleId != null ? 'Editar Veículo' : 'Cadastrar Veículo',
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
              ElevatedButtonWidget(
                onPressed: () {},
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      );
}
