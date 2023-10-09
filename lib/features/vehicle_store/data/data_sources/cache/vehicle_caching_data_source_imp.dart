import 'dart:convert';

import '../../../../../setups/local_storage/local_storage.dart';
import '../../../../../shared/domain/entities/result.dart';
import '../../models/vehicle_model.dart';
import 'vehicle_caching_data_source.dart';

class VehicleCachingDataSourceImp extends VehicleCachingDataSource {
  final LocalStorage _localStorage;

  final String _vehiclesCacheKey = 'vehicles';

  VehicleCachingDataSourceImp({
    required super.vehicleRemoteDataSource,
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;

  @override
  Future<Result<List<VehicleModel>>> getVehicles([int page = 1]) async {
    final vehiclesResult = await super.getVehicles(page);

    if (vehiclesResult.isSuccess) {
      saveVehiclesToCache(vehiclesResult.data);
      return vehiclesResult;
    } else {
      return Result.failure(vehiclesResult.failure, await getVehiclesFromCache());
    }
  }

  @override
  void saveVehiclesToCache(List<VehicleModel> vehicles) async {
    final vehiclesJson =
        vehicles.map((vehicle) => jsonEncode(vehicle.toJson(withId: true))).toList();
    _localStorage.setList(key: _vehiclesCacheKey, value: vehiclesJson);
  }

  @override
  Future<List<VehicleModel>> getVehiclesFromCache() async {
    final vehiclesJson = _localStorage.getList(_vehiclesCacheKey);
    if (vehiclesJson != null) {
      final vehicles = vehiclesJson.map((vehicleJson) {
        final vehicleMap = jsonDecode(vehicleJson);
        return VehicleModel.fromJson(vehicleMap);
      }).toList();
      return vehicles;
    } else {
      return [];
    }
  }
}
