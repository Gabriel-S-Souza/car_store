import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final ServiceLocator I = ServiceLocator._internal();
  late final GetIt _getIt;

  ServiceLocator._internal();

  factory ServiceLocator([GetIt? getIt]) {
    I._getIt = getIt ?? GetIt.instance;
    return I;
  }

  void setup() async {
    _getIt;
  }

  T get<T extends Object>() {
    throw UnimplementedError();
  }

  bool isRegistered<T extends Object>() {
    throw UnimplementedError();
  }

  void registerFactory<T extends Object>(T Function() factory) {}

  void registerSingleton<T extends Object>(T instance) {}
}
