import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LogInterceptorApp extends LogInterceptor {
  LogInterceptorApp({
    request = true,
    requestHeader = true,
    responseHeader = true,
    responseBody = true,
    requestBody = true,
    error = true,
    logPrint = print,
  }) : super(
          request: request,
          requestHeader: requestHeader,
          responseHeader: responseHeader,
          responseBody: false,
          requestBody: requestBody,
          error: error,
          logPrint: logPrint,
        );

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is List &&
        response.data.isNotEmpty &&
        response.data?.first is Map &&
        response.data.first.containsKey('image')) {
      final RequestOptions optionsLog = response.requestOptions.copyWith();
      optionsLog.data = null;
      optionsLog.data = jsonDecode(jsonEncode(response.data));
      final vehicles = List<Map>.from(optionsLog.data);
      final modifiedVehicles = vehicles
          .map((vehicle) => {
                ...vehicle,
                'image': '...REMOVED_TO_LOG...',
              })
          .toList();

      optionsLog.data = modifiedVehicles;

      _printAll(optionsLog.data);
    }
    super.onResponse(response, handler);
  }
}

void _printAll(msg) {
  _logPrint('*** Response Body ***');
  msg.toString().split('\n').forEach(_logPrint);
}

void _logPrint(msg) {
  kDebugMode ? print(msg.toString()) : debugPrint(msg.toString());
}
