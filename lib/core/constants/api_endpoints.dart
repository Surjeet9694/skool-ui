/// API endpoint constants.
/// All paths are relative to the base URL defined in AppConfig.
/// Never hardcode full URLs in feature code.
abstract final class ApiEndpoints {
  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refresh = '/auth/refresh';
  static const String changePassword = '/auth/change-password';
  static const String register = '/auth/register';

  // ─── Users ────────────────────────────────────────────────────────────────
  static const String me = '/users/me';
  static String userById(String id) => '/users/$id';

  // ─── Attendance ───────────────────────────────────────────────────────────
  static const String attendanceBulk = '/attendance/bulk';
  static String studentAttendance(String studentId) =>
      '/attendance/student/$studentId';

  // ─── Homework ─────────────────────────────────────────────────────────────
  static const String homework = '/homework';
  static String homeworkById(String id) => '/homework/$id';

  // ─── Fees ─────────────────────────────────────────────────────────────────
  static const String fees = '/fees';
  static String studentFees(String studentId) => '/fees/student/$studentId';
  static String feeById(String id) => '/fees/$id';

  // ─── Notifications ────────────────────────────────────────────────────────
  static const String notifications = '/notifications';
  static String markNotificationRead(String id) =>
      '/notifications/$id/read';
  static const String markAllNotificationsRead = '/notifications/read-all';
}
