import 'package:dio/dio.dart';
import 'package:skool_ui/core/constants/api_endpoints.dart';
import 'package:skool_ui/features/auth/data/models/auth_models.dart';

/// Remote data source for authentication APIs.
final class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<TokenResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return TokenResponse.fromJson(response.data['data']);
  }

  Future<void> logout(String refreshToken) async {
    await _dio.post(
      ApiEndpoints.logout,
      data: {'refresh_token': refreshToken},
    );
  }

  Future<TokenResponse> refreshToken(String refreshToken) async {
    final response = await _dio.post(
      ApiEndpoints.refresh,
      data: {'refresh_token': refreshToken},
    );
    return TokenResponse.fromJson(response.data['data']);
  }

  Future<UserProfile> getMyProfile() async {
    final response = await _dio.get(ApiEndpoints.me);
    return UserProfile.fromJson(response.data['data']);
  }
}
