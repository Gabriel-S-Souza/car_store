import 'package:dio/dio.dart';

import 'interceptors/log_interceptor_app.dart';

const _baseUrl = String.fromEnvironment('API_URL');

const _basePath = '/api';

//TODO: Checar se não vai passar somente a referencia no ServiceLocator
final dioApp = Dio(
  BaseOptions(
    baseUrl: _baseUrl + _basePath,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
)..interceptors.addAll([LogInterceptorApp()]);
