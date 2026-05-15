import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application environment configuration.
/// All values are loaded from .env file at runtime.
/// Never hardcode secrets or URLs.
final class AppConfig {
  AppConfig._();

  static String get _env => dotenv.env['APP_ENV'] ?? 'development';

  static bool get isProduction => _env == 'production';
  static bool get isDevelopment => _env == 'development';

  /// Base API URL — loaded from environment
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.skoolapp.com/api/v1';

  /// Connection timeout in milliseconds
  static int get connectionTimeout =>
      int.tryParse(dotenv.env['CONNECTION_TIMEOUT_MS'] ?? '15000') ?? 15000;

  /// Receive timeout in milliseconds
  static int get receiveTimeout =>
      int.tryParse(dotenv.env['RECEIVE_TIMEOUT_MS'] ?? '30000') ?? 30000;

  /// App name for display
  static String get appName => dotenv.env['APP_NAME'] ?? 'Skool';

  /// Sentry DSN — empty string disables Sentry
  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? '';
}
