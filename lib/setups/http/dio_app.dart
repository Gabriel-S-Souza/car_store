import 'package:dio/dio.dart';

import '../../features/auth/data/interceptors/check_token.dart';
import 'interceptors/log_interceptor_app.dart';

const _baseUrl = String.fromEnvironment('API_URL');

const _basePath = '/api';

final dioApp = Dio(
  BaseOptions(
    baseUrl: _baseUrl + _basePath,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
)..interceptors.addAll([
    LogInterceptorApp(),
    InterceptorsWrapper(onRequest: checkToken),
  ]);
