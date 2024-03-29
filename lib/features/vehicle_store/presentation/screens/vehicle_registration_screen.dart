import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../setups/di/service_locator.dart';
import '../../../../shared/presentation/widgets/elevate_button_widget.dart';
import '../../../../shared/presentation/widgets/header_screen_widget.dart';
import '../../../../shared/presentation/widgets/responsive_padding_widget.dart';
import '../../../../shared/presentation/widgets/text_field_widget.dart';
import '../../domain/entities/vehicle_details_entity.dart';
import '../blocs/registration/vehicle_registration_bloc.dart';
import '../blocs/registration/vehicle_registration_state.dart';
import '../dtos/vehicle_editing_dto.dart';
import '../widgets/drop_selector_widget.dart';
import '../widgets/vehicle_image_field_widget.dart';

class VehicleRegistrationScreen extends StatefulWidget {
  final int? vehicleId;
  final VehicleDetailsEntity? vehicle;

  const VehicleRegistrationScreen({
    super.key,
    this.vehicleId,
    this.vehicle,
  });

  @override
  State<VehicleRegistrationScreen> createState() => _VehicleRegistrationScreenState();
}

class _VehicleRegistrationScreenState extends State<VehicleRegistrationScreen> {
  final bloc = ServiceLocator.I.get<VehicleRegistrationBloc>();
  ValueNotifier<VehicleEditingDto> vehicleEditingDto = ValueNotifier(VehicleEditingDto());
  late final bool isUpdate;

  final _formKey = GlobalKey<FormState>();

  late final CurrencyTextInputFormatter priceFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: 'R\$',
    locale: 'pt-br',
  );

  @override
  void initState() {
    super.initState();
    isUpdate = widget.vehicleId != null;
    vehicleEditingDto.value = vehicleEditingDto.value.copyWith(
      id: widget.vehicleId,
      name: widget.vehicle?.name,
      brand: widget.vehicle?.brand,
      model: widget.vehicle?.model,
      price: widget.vehicle?.price,
      description: widget.vehicle?.description,
      condition: widget.vehicle?.condition,
      year: widget.vehicle?.year,
      mileage: widget.vehicle?.mileage,
      engine: widget.vehicle?.engine,
      image: widget.vehicle?.image,
    );
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider<VehicleRegistrationBloc>(
          create: (context) => bloc,
          child: BlocBuilder<VehicleRegistrationBloc, VehicleRegistrationState>(
            bloc: bloc,
            builder: (context, state) => ResponsivePadding(
              isScreenWrapper: true,
              child: Scaffold(
                appBar: HeaderScreenWidget(
                  title: widget.vehicleId != null ? 'Editar Veículo' : 'Cadastrar Veículo',
                  onPrimaryTap: () => context.pop(),
                ),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 22),
                      VehicleImageFieldWidget(
                        initialImage: widget.vehicle?.image,
                        onImageSelected: (image) {
                          vehicleEditingDto.value.image = image;
                          vehicleEditingDto.value = vehicleEditingDto.value.copyWith(image: image);
                        },
                      ),
                      const SizedBox(height: 28),
                      TextFieldWidget(
                        initialValue: widget.vehicle?.name,
                        label: 'Nome',
                        onChanged: (value) =>
                            vehicleEditingDto.value = vehicleEditingDto.value.copyWith(name: value),
                      ),
                      const SizedBox(height: 22),
                      TextFieldWidget(
                        initialValue: widget.vehicle?.brand,
                        label: 'Marca',
                        onChanged: (value) => vehicleEditingDto.value =
                            vehicleEditingDto.value.copyWith(brand: value),
                      ),
                      const SizedBox(height: 22),
                      TextFieldWidget(
                        initialValue: widget.vehicle?.model,
                        label: 'Modelo',
                        onChanged: (value) => vehicleEditingDto.value =
                            vehicleEditingDto.value.copyWith(model: value),
                      ),
                      const SizedBox(height: 22),
                      TextFieldWidget(
                        initialValue: widget.vehicle?.price.toString(),
                        label: 'Preço',
                        inputFormatter: priceFormatter,
                        keyboardType: TextInputType.number,
                        onChanged: (value) =>
                            vehicleEditingDto.value = vehicleEditingDto.value.copyWith(
                          price: priceFormatter.getUnformattedValue().toDouble(),
                        ),
                      ),
                      const SizedBox(height: 22),
                      TextFieldWidget(
                        initialValue: widget.vehicle?.description,
                        label: 'Descrição',
                        onChanged: (value) => vehicleEditingDto.value =
                            vehicleEditingDto.value.copyWith(description: value),
                      ),
                      const SizedBox(height: 22),
                      ValueListenableBuilder<VehicleEditingDto>(
                        valueListenable: vehicleEditingDto,
                        builder: (context, vehicleEditing, child) => DropSelectorWidget(
                          hint: 'Condição',
                          textItems: Condition.values.map((e) => e.labelToDisplay).toList(),
                          items: Condition.values,
                          selectedValue: vehicleEditing.condition,
                          onChanged: (value) =>
                              vehicleEditingDto.value = vehicleEditing.copyWith(condition: value),
                        ),
                      ),
                      const SizedBox(height: 22),
                      TextFieldWidget(
                        initialValue: widget.vehicle?.year.toString(),
                        label: 'Ano',
                        mask: '####',
                        filter: {'#': RegExp(r'[0-9]')},
                        keyboardType: TextInputType.number,
                        onChanged: (value) => vehicleEditingDto.value =
                            vehicleEditingDto.value.copyWith(year: int.tryParse(value ?? '0') ?? 0),
                      ),
                      const SizedBox(height: 22),
                      TextFieldWidget(
                        initialValue: widget.vehicle?.mileage != null
                            ? widget.vehicle!.mileage.toString()
                            : '',
                        label: 'Km rodados (Opcional)',
                        mask: '#############',
                        filter: {'#': RegExp(r'[0-9]')},
                        keyboardType: TextInputType.number,
                        onChanged: (value) => vehicleEditingDto.value = vehicleEditingDto.value
                            .copyWith(mileage: int.tryParse(value ?? '0') ?? 0),
                      ),
                      const SizedBox(height: 22),
                      TextFieldWidget(
                        initialValue: widget.vehicle?.engine ?? '',
                        hint: 'Ex: 1.4',
                        label: 'Motor (Opcional)',
                        mask: '#########',
                        filter: {'#': RegExp(r'[0-9.]')},
                        keyboardType: TextInputType.number,
                        onChanged: (value) => vehicleEditingDto.value =
                            vehicleEditingDto.value.copyWith(engine: value),
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
                persistentFooterButtons: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ValueListenableBuilder<VehicleEditingDto>(
                      valueListenable: vehicleEditingDto,
                      builder: (context, vehicleEditing, child) => ElevatedButtonWidget(
                        enabled: vehicleEditingDto.value.isValid,
                        onPressed: () async {
                          if (vehicleEditingDto.value.isValid) {
                            await bloc.writeVehicle(
                              vehicleEditingDto.value.toEntity(),
                              isUpdate,
                            );
                            if (bloc.state is VehicleRegistrationSuccess &&
                                (bloc.state as VehicleRegistrationSuccess).isUpdateOrRegister) {
                              Future.delayed(
                                const Duration(milliseconds: 500),
                                () {
                                  context.pop();
                                },
                              );
                            }
                          }
                        },
                        child: state is VehicleRegistrationLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isUpdate ? 'Atualizar' : 'Cadastrar',
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
