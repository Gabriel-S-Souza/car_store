import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future<void> checkToken(
  RequestOptions options,
  RequestInterceptorHandler handler,
) async {
  if ((options.method == 'POST' ||
          options.method == 'PUT' ||
          options.method == 'PATCH' ||
          options.method == 'DELETE') &&
      options.path.contains('vehicles')) {
    final authorization = options.headers['authorization'] as String?;
    final token = authorization?.split(' ').lastOrNull;
    log('Check token: $token');

    if (!_validateFormatToken(token)) {
      handler.reject(
        DioException(
          requestOptions: options,
          response: Response(
            statusCode: 401,
            data: 'Token invalid',
            requestOptions: options,
          ),
        ),
      );
    } else {
      final isExpired = _isTokenExpired(token);
      if (isExpired) {
        // handles with expired token
      }
      handler.next(options);
      return;
    }
  }
  handler.next(options);
}

bool _isTokenExpired(String? token) {
  final decodedToken = JwtDecoder.decode(token!);
  final expireIn = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] as int);
  final remainingTime = expireIn.difference(DateTime.now()).inSeconds;
  return remainingTime < 0;
}

bool _validateFormatToken(String? token) {
  try {
    if (token == null) return false;
    final decodedToken = JwtDecoder.decode(token);
    return decodedToken.isNotEmpty;
  } catch (e) {
    rethrow;
  }
}
