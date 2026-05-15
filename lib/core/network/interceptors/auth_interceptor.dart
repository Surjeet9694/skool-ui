import 'package:dio/dio.dart';
import 'package:skool_ui/core/constants/api_endpoints.dart';
import 'package:skool_ui/core/storage/token_storage.dart';

/// Dio interceptor that injects JWT access tokens and handles 401 refresh flow.
final class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._dio);

  final Dio _dio;
  bool _isRefreshing = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for auth endpoints
    if (_isAuthRoute(options.path)) {
      return handler.next(options);
    }

    final token = await TokenStorage.instance.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401 || _isRefreshing) {
      return handler.next(err);
    }

    if (_isAuthRoute(err.requestOptions.path)) {
      return handler.next(err);
    }

    _isRefreshing = true;
    try {
      final refreshToken = await TokenStorage.instance.getRefreshToken();
      if (refreshToken == null) {
        await TokenStorage.instance.clearTokens();
        return handler.next(err);
      }

      // Attempt token refresh
      final refreshResponse = await _dio.post(
        ApiEndpoints.refresh,
        data: {'refresh_token': refreshToken},
        options: Options(headers: {'Authorization': ''}),
      );

      final data = refreshResponse.data['data'];
      await TokenStorage.instance.saveTokens(
        accessToken: data['access_token'],
        refreshToken: data['refresh_token'],
      );

      // Retry the original request with new token
      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer ${data['access_token']}';
      final retryResponse = await _dio.fetch(retryOptions);
      handler.resolve(retryResponse);
    } catch (_) {
      // Refresh failed — clear tokens and propagate 401
      await TokenStorage.instance.clearTokens();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  bool _isAuthRoute(String path) =>
      path.contains('/auth/login') ||
      path.contains('/auth/refresh') ||
      path.contains('/auth/register');
}
