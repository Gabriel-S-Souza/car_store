import 'package:dio/dio.dart';

import 'interceptors/check_token.dart';
import 'interceptors/log_interceptor_app.dart';

//TODO: Sets real url
const _baseUrl = 'http://192.168.1.3:3000';
// const _baseUrl = 'http://localhost:3000';
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
