/// Storage key constants for Hive and Flutter Secure Storage.
/// Centralised to prevent typos and make refactoring easy.
abstract final class StorageKeys {
  // Secure storage keys (JWT tokens)
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  // Hive box names
  static const String userBox = 'user_box';
  static const String settingsBox = 'settings_box';

  // Hive keys inside boxes
  static const String cachedUser = 'cached_user';
  static const String isDarkMode = 'is_dark_mode';
  static const String selectedLocale = 'selected_locale';
  static const String onboardingComplete = 'onboarding_complete';
}

/// Route name constants for GoRouter.
abstract final class RouteNames {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String dashboard = 'dashboard';
  static const String attendance = 'attendance';
  static const String homework = 'homework';
  static const String fees = 'fees';
  static const String notifications = 'notifications';
  static const String profile = 'profile';
}

/// Route path constants for GoRouter.
abstract final class RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String attendance = '/attendance';
  static const String homework = '/homework';
  static const String fees = '/fees';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
}
