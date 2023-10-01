import 'dart:io';

import 'package:dio/dio.dart';

import '../../shared/domain/entities/failure.dart';

mixin HttpErrorHandler {
  Failure handleError(Object e) {
    if (e is! DioException) return UnmappedFailure(e.toString());

    if (e.response != null && e.response!.statusCode != null) {
      final error = _handleErrorByStatusCode(e);
      if (error != null) {
        return error;
      }
    }

    return _handleErrorByType(e);
  }

  Failure? _handleErrorByStatusCode(DioException e) {
    final statusCode = e.response!.statusCode;
    final String? message;

    if (e.response!.data is Map && e.response!.data.containsKey('message')) {
      message = e.response!.data['message'] is String
          ? e.response!.data['message']
          : e.response!.statusMessage;
    } else {
      message = null;
    }

    switch (statusCode) {
      case 400:
        return BadRequestFailure(message);
      case 401:
        return UnauthorizedFailure(message);
      case 404:
        return NotFoundFailure(message);
      case 500:
        return ServerFailure(message);
      default:
        return null;
    }
  }

  Failure _handleErrorByType(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const OfflineFailure();
      case DioExceptionType.cancel:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badResponse:
        return ServerFailure(e.message);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (e.error is SocketException &&
            e.error.toString().toLowerCase().contains('network is unreachable')) {
          return const OfflineFailure();
        }
        return UnmappedFailure(e.message);
      default:
        return UnmappedFailure(e.message);
    }
  }
}
