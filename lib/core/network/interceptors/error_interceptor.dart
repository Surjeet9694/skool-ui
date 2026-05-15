import 'package:dio/dio.dart';
import 'package:skool_ui/core/exceptions/api_exception.dart';

/// Transforms Dio errors into typed ApiException instances.
final class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        ApiException.timeout(),
      DioExceptionType.connectionError => ApiException.noInternet(),
      DioExceptionType.badResponse => _handleBadResponse(err),
      _ => ApiException.unknown(err.message ?? 'Unknown error'),
    };

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }

  ApiException _handleBadResponse(DioException err) {
    final statusCode = err.response?.statusCode ?? 0;
    final message = _extractMessage(err.response?.data);

    return switch (statusCode) {
      400 => ApiException.badRequest(message),
      401 => ApiException.unauthorized(message),
      403 => ApiException.forbidden(message),
      404 => ApiException.notFound(message),
      409 => ApiException.conflict(message),
      422 => ApiException.validation(message),
      429 => ApiException.rateLimit(),
      >= 500 => ApiException.server(message),
      _ => ApiException.unknown(message),
    };
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? 'An error occurred.';
    }
    return 'An error occurred.';
  }
}
