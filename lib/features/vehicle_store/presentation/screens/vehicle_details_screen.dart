import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../setups/app_routes/app_routes.dart';
import '../../../../setups/di/service_locator.dart';
import '../blocs/details/vehicle_detail_bloc.dart';
import '../blocs/details/vehicle_detail_state.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final int vehicleId;

  const VehicleDetailsScreen({super.key, required this.vehicleId});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final vehicleDetailsBloc = ServiceLocator.I.get<VehicleDetailsBloc>();

  @override
  void initState() {
    super.initState();
    vehicleDetailsBloc.getDetails(widget.vehicleId);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Car Store'),
          centerTitle: true,
          leading: !context.canPop()
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.goNamed(RouteNames.vehicles);
                  },
                )
              : null,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.goNamed(RouteNames.login);
              },
            ),
          ],
        ),
        body: ResponsiveScaledBox(
          width: null,
          child: BlocBuilder<VehicleDetailsBloc, VehicleDetailsState>(
            bloc: vehicleDetailsBloc,
            builder: (context, state) {
              if (state is VehicleDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is VehicleDetailsSuccess) {
                return ListView(
                  children: [
                    Column(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Image.memory(
                            state.details.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BrandAndNameWidget(
                      brand: state.details.brand,
                      name: state.details.name,
                    ),
                    const SizedBox(height: 10),
                    DescriptionWidget(description: state.details.description),
                    const SizedBox(height: 10),
                    PriceWidget(price: state.details.price),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Informações adicionais',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                            blurRadius: 6.0,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: state.details.additionalInformations
                            .asMap()
                            .entries
                            .map(
                              (MapEntry<int, Map<String, String>> entry) => InformationRowWidget(
                                ikey: entry.value['key'] ?? 'not found',
                                value: entry.value['value'] ?? 'not found',
                                rowColor: entry.key.isEven
                                    ? Theme.of(context).colorScheme.scrim.withOpacity(0.3)
                                    : Theme.of(context).cardColor,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                );
              }
              if (state is VehicleDetailsError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      );
}

class BrandAndNameWidget extends StatelessWidget {
  final String brand;
  final String name;

  const BrandAndNameWidget({super.key, required this.brand, required this.name});

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: Text(
          '$brand - $name',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.amberAccent,
          ),
        ),
      );
}

class DescriptionWidget extends StatelessWidget {
  final String description;

  const DescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          description,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      );
}

class PriceWidget extends StatelessWidget {
  final double price;

  const PriceWidget({super.key, required this.price});

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: 'Por apenas: ',
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.amber,
            ),
            children: [
              TextSpan(
                text: 'R\$ ${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.amberAccent,
                ),
              ),
            ],
          ),
        ),
      );
}

class InformationRowWidget extends StatelessWidget {
  final String ikey;
  final String value;
  final Color rowColor;

  const InformationRowWidget({
    Key? key,
    required this.ikey,
    required this.value,
    required this.rowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: rowColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                ikey,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              flex: 3,
              child: AutoSizeText(
                value,
                maxFontSize: 14,
                minFontSize: 8,
                maxLines: 3,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      );
}