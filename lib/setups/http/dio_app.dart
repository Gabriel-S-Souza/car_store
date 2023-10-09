import 'package:dio/dio.dart';

import 'log_interceptor_app.dart';

const _baseUrl = String.fromEnvironment('API_URL');

const _basePath = '/api';

Dio get dioApp => Dio(
      BaseOptions(
        baseUrl: _baseUrl + _basePath,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    )..interceptors.add(LogInterceptorApp());
