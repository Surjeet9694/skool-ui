import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:skool_ui/core/config/app_config.dart';
import 'package:skool_ui/core/network/interceptors/auth_interceptor.dart';
import 'package:skool_ui/core/network/interceptors/logging_interceptor.dart';
import 'package:skool_ui/core/network/interceptors/error_interceptor.dart';

/// Dio HTTP client factory.
/// Returns a pre-configured Dio instance with all interceptors attached.
final class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: Duration(milliseconds: AppConfig.connectionTimeout),
        receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-App-Platform': 'flutter',
        },
        responseType: ResponseType.json,
      ),
    );

    // Order matters: logging → auth → error
    dio.interceptors.addAll([
      LoggingInterceptor(Logger()),
      AuthInterceptor(dio),
      ErrorInterceptor(),
    ]);

    return dio;
  }
}
