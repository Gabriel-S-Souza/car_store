import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../setups/di/service_locator.dart';
import '../../../../setups/local_storage/secure_local_storage.dart';
import '../../../../setups/utils/storage_keys.dart';
import '../../../auth/data/datasources/refresh_token_data_source.dart';

class CheckTokenInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authorization = options.headers['authorization'] as String?;
    final token = authorization?.split(' ').lastOrNull;

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
      if (_isExpiredToken(token)) {
        final refreshTokenDataSource = ServiceLocator.I.get<RefreshTokenDataSource>();
        final secureLocalStorage = ServiceLocator.I.get<SecureLocalStorage>();
        final response = await refreshTokenDataSource.get();
        if (response.isSuccess) {
          final newAccessToken = await secureLocalStorage.get(StorageKeys.accessToken);
          options.headers['authorization'] = 'Bearer $newAccessToken';
          handler.next(options);
          return;
        }
        handler.next(options);
        return;
      }
    }
    handler.next(options);
  }
}

bool _validateFormatToken(String? token) {
  try {
    if (token == null) return false;
    final decodedToken = JwtDecoder.decode(token);
    return decodedToken.isNotEmpty;
  } catch (e) {
    return false;
  }
}

bool _isExpiredToken(String? token) {
  final decodedToken = JwtDecoder.decode(token!);
  final expireIn = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] as int);
  final remainingTime = expireIn.difference(DateTime.now()).inSeconds;
  return remainingTime < 1;
}
