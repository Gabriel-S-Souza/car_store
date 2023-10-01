import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/login_datasource.dart';
import '../../features/auth/data/datasources/login_datasource_imp.dart';
import '../../features/auth/data/repositories/login_repository_imp.dart';
import '../../features/auth/domain/repositories/login_repository.dart';
import '../../features/auth/domain/use_cases/login_case.dart';
import '../../features/auth/presentation/blocs/login/login_bloc.dart';
import '../../features/vehicle_store/data/data_sources/cache/vehicle_caching_data_source_imp.dart';
import '../../features/vehicle_store/data/data_sources/remoto/vehicle_data_source.dart';
import '../../features/vehicle_store/data/data_sources/remoto/vehicle_data_source_imp.dart';
import '../../features/vehicle_store/data/repositories/vehicle_repository_imp.dart';
import '../../features/vehicle_store/domain/repositories/vehicle_repository.dart';
import '../../features/vehicle_store/domain/use_cases/get_vehicle_details_use_case.dart';
import '../../features/vehicle_store/domain/use_cases/get_vehicle_use_case.dart';
import '../../features/vehicle_store/presentation/blocs/details/vehicle_detail_bloc.dart';
import '../../features/vehicle_store/presentation/blocs/home/home_bloc.dart';
import '../../shared/data/data_sources/local_storage/local_storage_data_source.dart';
import '../../shared/data/data_sources/local_storage/local_storage_imp.dart';
import '../../shared/data/data_sources/secure_local_storage/secure_local_storage.dart';
import '../../shared/data/data_sources/secure_local_storage/secure_local_storage_imp.dart';
import '../http/dio_app.dart';
import '../http/http_client.dart';

class ServiceLocator {
  static final ServiceLocator I = ServiceLocator._internal();
  late final GetIt _getIt;

  ServiceLocator._internal();

  factory ServiceLocator([GetIt? getIt]) {
    I._getIt = getIt ?? GetIt.instance;
    return I;
  }

  Future<void> setup() async {
    // Local storage
    registerSingleton<LocalStorage>(
      LocalStorageImp(await SharedPreferences.getInstance()),
    );

    registerSingleton<SecureLocalStorage>(
      SecureLocalStorageImp(
        const FlutterSecureStorage(),
      ),
    );

    // Http client
    registerSingleton<HttpClient>(HttpClient(dioApp));

    // Data sources
    registerFactory<VehicleDataSource>(
      () => VehicleCachingDataSourceImp(
        localStorage: get(),
        vehicleRemoteDataSource: VehicleDataSourceImp(
          httpClient: get(),
          secureLocalStorage: get(),
        ),
      ),
    );

    registerFactory<LoginDataSource>(
      () => LoginDataSourceImp(
        httpClient: get(),
        secureLocalStorage: get(),
      ),
    );

    // Repositories
    registerFactory<VehicleRepository>(
      () => VehicleRepositoryImp(
        vehicleDataSource: get(),
      ),
    );

    registerFactory<LoginRepository>(
      () => LoginRepositoryImp(
        loginDataSource: get(),
      ),
    );

    // Use cases
    registerFactory<GetVehiclesUseCase>(
      () => GetVehiclesUseCaseImp(
        vehicleRepository: get(),
      ),
    );

    registerFactory<GetVehicleDetailsUseCase>(
      () => GetVehicleDetailsUseCaseImp(
        vehicleRepository: get(),
      ),
    );

    registerFactory<LoginUseCase>(
      () => LoginUseCaseImp(
        loginRepository: get(),
      ),
    );

    // Blocs
    registerFactory<HomeBloc>(() => HomeBloc(getVehicles: get()));

    registerFactory<VehicleDetailsBloc>(() => VehicleDetailsBloc(getVehicleDetails: get()));

    registerFactory<LoginBloc>(() => LoginBloc(login: get()));
  }

  T get<T extends Object>() => _getIt.get<T>();

  void registerFactory<T extends Object>(T Function() factory) {
    _getIt.registerFactory<T>(factory);
  }

  void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  bool isRegistered<T extends Object>() => _getIt.isRegistered<T>();
}
