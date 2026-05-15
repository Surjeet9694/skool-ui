import 'package:skool_ui/core/storage/token_storage.dart';
import 'package:skool_ui/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:skool_ui/features/auth/data/models/auth_models.dart';

/// Auth repository — orchestrates data sources and token storage.
final class AuthRepository {
  const AuthRepository(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  Future<UserProfile> login(String email, String password) async {
    final tokens = await _remoteDataSource.login(
      LoginRequest(email: email, password: password),
    );
    await TokenStorage.instance.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    return _remoteDataSource.getMyProfile();
  }

  Future<void> logout() async {
    final refreshToken = await TokenStorage.instance.getRefreshToken();
    if (refreshToken != null) {
      try {
        await _remoteDataSource.logout(refreshToken);
      } catch (_) {
        // Best-effort logout — always clear local tokens
      }
    }
    await TokenStorage.instance.clearTokens();
  }

  Future<UserProfile?> getMyProfile() async {
    try {
      return await _remoteDataSource.getMyProfile();
    } catch (_) {
      return null;
    }
  }

  Future<bool> isLoggedIn() => TokenStorage.instance.hasTokens();
}
