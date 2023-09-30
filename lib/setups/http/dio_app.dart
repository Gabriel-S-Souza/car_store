import 'package:dio/dio.dart';

import 'interceptors/check_token.dart';

const _baseUrl = 'http://localhost:3000';
const _basePath = '/api';

final dioApp = Dio(
  BaseOptions(
    baseUrl: _baseUrl + _basePath,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
)..interceptors.addAll([
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ),
    InterceptorsWrapper(onRequest: checkToken),
  ]);
