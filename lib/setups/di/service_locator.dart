import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_controller.dart';
import '../../features/auth/data/datasources/auth_datasource.dart';
import '../../features/auth/data/datasources/auth_datasource_imp.dart';
import '../../features/auth/data/datasources/refresh_token_data_source.dart';
import '../../features/auth/data/datasources/refresh_token_data_source_imp.dart';
import '../../features/auth/data/repositories/auth_repository_imp.dart';
import '../../features/auth/domain/repositories/login_repository.dart';
import '../../features/auth/domain/use_cases/login_use_case.dart';
import '../../features/auth/domain/use_cases/register_user_use_case.dart';
import '../../features/auth/presentation/blocs/login/login_bloc.dart';
import '../../features/auth/presentation/blocs/register/register_user_bloc.dart';
import '../../features/vehicle_store/data/data_sources/cache/vehicle_caching_data_source_imp.dart';
import '../../features/vehicle_store/data/data_sources/remoto/vehicle_data_source.dart';
import '../../features/vehicle_store/data/data_sources/remoto/vehicle_reader_data_source_imp.dart';
import '../../features/vehicle_store/data/data_sources/remoto/vehicle_writer_data_source_imp.dart';
import '../../features/vehicle_store/data/repositories/vehicle_reader_repository_imp.dart';
import '../../features/vehicle_store/data/repositories/vehicle_writer_repository_imp.dart';
import '../../features/vehicle_store/domain/repositories/vehicle_reader_repository.dart';
import '../../features/vehicle_store/domain/repositories/vehicle_writer_repositoty.dart';
import '../../features/vehicle_store/domain/use_cases/delete_vehicle_use_case.dart';
import '../../features/vehicle_store/domain/use_cases/get_vehicle_details_use_case.dart';
import '../../features/vehicle_store/domain/use_cases/get_vehicle_use_case.dart';
import '../../features/vehicle_store/domain/use_cases/register_vehicle_use_case.dart';
import '../../features/vehicle_store/domain/use_cases/update_vehicle_use_case.dart';
import '../../features/vehicle_store/presentation/blocs/details/vehicle_detail_bloc.dart';
import '../../features/vehicle_store/presentation/blocs/home/home_bloc.dart';
import '../../features/vehicle_store/presentation/blocs/registration/vehicle_registration_bloc.dart';
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
    registerFactory<AuthDataSource>(
      () => AuthDataSourceImp(
        httpClient: get(),
        secureLocalStorage: get(),
      ),
    );

    registerFactory<VehicleReaderDataSource>(
      () => VehicleCachingDataSourceImp(
        localStorage: get(),
        vehicleRemoteDataSource: VehicleReaderDataSourceImp(
          httpClient: get(),
        ),
      ),
    );

    registerFactory<VehicleWriterDataSource>(
      () => VehicleWriterDataSourceImp(
        httpClient: get(),
        secureLocalStorage: get(),
      ),
    );

    // Repositories
    registerFactory<AuthRepository>(
      () => AuthRepositoryImp(
        authDataSource: get(),
      ),
    );

    registerFactory<RefreshTokenDataSource>(
      () => RefreshTokenDataSourceImp(
        httpClient: get(),
        secureLocalStorage: get(),
      ),
    );

    registerFactory<VehicleReaderRepository>(
      () => VehicleReaderRepositoryImp(
        vehicleDataSource: get(),
      ),
    );

    registerFactory<VehicleWriterRepository>(
      () => VehicleWriterRepositoryImp(
        vehicleDataSource: get(),
      ),
    );

    // Use cases
    registerFactory<LoginUseCase>(
      () => LoginUseCaseImp(
        authRepository: get(),
      ),
    );

    registerFactory<RegisterUserUseCase>(
      () => RegisterUserUseCaseImp(
        authRepository: get(),
      ),
    );

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

    registerFactory<RegisterVehicleUseCase>(
      () => RegisterVehicleUseCaseImp(
        vehicleRepository: get(),
      ),
    );

    registerFactory<UpdateVehicleUseCase>(
      () => UpdateVehicleUseCaseImp(
        vehicleRepository: get(),
      ),
    );

    registerFactory<DeleteVehicleUseCase>(
      () => DeleteVehicleUseCaseImp(
        vehicleRepository: get(),
      ),
    );

    // Blocs
    registerFactory<LoginBloc>(
      () => LoginBloc(
        login: get(),
      ),
    );

    registerFactory<RegisterUserBloc>(
      () => RegisterUserBloc(
        registerUser: get(),
      ),
    );

    registerFactory<HomeBloc>(
      () => HomeBloc(
        getVehicles: get(),
      ),
    );

    registerFactory<VehicleDetailsBloc>(
      () => VehicleDetailsBloc(
        getVehicleDetails: get(),
        deleteVehicle: get(),
      ),
    );

    registerSingleton<VehicleRegistrationBloc>(
      VehicleRegistrationBloc(
        registerVehicle: get(),
        updateVehicle: get(),
        deleteVehicle: get(),
      ),
    );

    AppController.I.init(get());
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
