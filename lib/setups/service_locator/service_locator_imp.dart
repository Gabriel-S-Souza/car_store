import 'package:get_it/get_it.dart';

import '../../app_controller.dart';

class ServiceLocator {
  static final ServiceLocator I = ServiceLocator._internal();
  late final GetIt _getIt;

  ServiceLocator._internal();

  factory ServiceLocator([GetIt? getIt]) {
    I._getIt = getIt ?? GetIt.instance;
    return I;
  }

  void setup() {
    registerSingleton(AppController());
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
