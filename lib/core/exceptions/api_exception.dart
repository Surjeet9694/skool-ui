/// Typed API exception hierarchy.
/// All network errors are transformed to these types by [ErrorInterceptor].
sealed class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  factory ApiException.timeout() => const _TimeoutException();
  factory ApiException.noInternet() => const _NoInternetException();
  factory ApiException.unauthorized([String? msg]) =>
      _UnauthorizedException(msg ?? 'Session expired. Please log in again.');
  factory ApiException.forbidden([String? msg]) =>
      _ForbiddenException(msg ?? 'You do not have permission.');
  factory ApiException.notFound([String? msg]) =>
      _NotFoundException(msg ?? 'Resource not found.');
  factory ApiException.badRequest([String? msg]) =>
      _BadRequestException(msg ?? 'Invalid request.');
  factory ApiException.validation([String? msg]) =>
      _ValidationException(msg ?? 'Validation failed.');
  factory ApiException.conflict([String? msg]) =>
      _ConflictException(msg ?? 'Conflict occurred.');
  factory ApiException.rateLimit() => const _RateLimitException();
  factory ApiException.server([String? msg]) =>
      _ServerException(msg ?? 'Server error. Please try again.');
  factory ApiException.unknown([String? msg]) =>
      _UnknownException(msg ?? 'An unexpected error occurred.');

  @override
  String toString() => 'ApiException($message)';
}

final class _TimeoutException extends ApiException {
  const _TimeoutException()
      : super('Request timed out. Check your internet connection.');
}

final class _NoInternetException extends ApiException {
  const _NoInternetException()
      : super('No internet connection. Please check your network.');
}

final class _UnauthorizedException extends ApiException {
  const _UnauthorizedException(super.message);
}

final class _ForbiddenException extends ApiException {
  const _ForbiddenException(super.message);
}

final class _NotFoundException extends ApiException {
  const _NotFoundException(super.message);
}

final class _BadRequestException extends ApiException {
  const _BadRequestException(super.message);
}

final class _ValidationException extends ApiException {
  const _ValidationException(super.message);
}

final class _ConflictException extends ApiException {
  const _ConflictException(super.message);
}

final class _RateLimitException extends ApiException {
  const _RateLimitException()
      : super('Too many requests. Please slow down.');
}

final class _ServerException extends ApiException {
  const _ServerException(super.message);
}

final class _UnknownException extends ApiException {
  const _UnknownException(super.message);
}
