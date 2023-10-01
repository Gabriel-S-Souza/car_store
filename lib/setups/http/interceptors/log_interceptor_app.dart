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
      final data = _deepCopyData(response);
      final dataWithoutImage = data.map((vehicle) => _hideImage(vehicle)).toList();
      _printAll(dataWithoutImage);
    } else if (response.data is Map && response.data.containsKey('image')) {
      final data = _deepCopyData(response);
      final vehicle = _hideImage(data);
      _printAll(vehicle);
    } else {
      _printAll(response.data);
    }
    super.onResponse(response, handler);
  }

  void _printAll(msg) {
    _logPrint('*** Response Body ***');
    msg.toString().split('\n').forEach(_logPrint);
  }

  void _logPrint(msg) {
    kDebugMode ? print(msg.toString()) : debugPrint(msg.toString());
  }

  Map<String, dynamic> _hideImage(Map<dynamic, dynamic> vehicle) => {
        ...vehicle,
        'image': '...REMOVED_TO_LOG...',
      };

  dynamic _deepCopyData(Response response) => jsonDecode(jsonEncode(response.data));
}
