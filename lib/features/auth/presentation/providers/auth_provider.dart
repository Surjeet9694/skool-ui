import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skool_ui/core/network/providers.dart';
import 'package:skool_ui/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:skool_ui/features/auth/data/models/auth_models.dart';
import 'package:skool_ui/features/auth/data/repositories/auth_repository.dart';

// ─── Data Source Provider ─────────────────────────────────────────────────────
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(dioProvider));
});

// ─── Repository Provider ──────────────────────────────────────────────────────
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authRemoteDataSourceProvider));
});

// ─── Auth State ───────────────────────────────────────────────────────────────

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);
  final UserProfile user;
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated([this.errorMessage]);
  final String? errorMessage;
}

// ─── Auth Notifier ────────────────────────────────────────────────────────────

final class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(const AuthInitial());

  final AuthRepository _repository;

  /// Check if user has valid session on app launch.
  Future<void> checkSession() async {
    final isLoggedIn = await _repository.isLoggedIn();
    if (!isLoggedIn) {
      state = const AuthUnauthenticated();
      return;
    }
    final profile = await _repository.getMyProfile();
    if (profile != null) {
      state = AuthAuthenticated(profile);
    } else {
      state = const AuthUnauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthLoading();
    try {
      final profile = await _repository.login(email, password);
      state = AuthAuthenticated(profile);
    } catch (e) {
      state = AuthUnauthenticated(_extractMessage(e));
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthUnauthenticated();
  }

  String _extractMessage(Object e) {
    if (e is Exception) return e.toString().replaceAll('Exception: ', '');
    return 'An unexpected error occurred.';
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

/// Convenience provider that returns the authenticated user or null.
final currentUserProvider = Provider<UserProfile?>((ref) {
  final state = ref.watch(authProvider);
  return state is AuthAuthenticated ? state.user : null;
});
