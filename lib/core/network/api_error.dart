class ApiError implements Exception {
  final String message;
  final int? statusCode;

  ApiError({required this.message, this.statusCode});

  String get normalized => message.toLowerCase();

  bool get isEmailExists =>
      normalized.contains('email') && normalized.contains('exist');

  bool get isUsernameExists =>
      normalized.contains('username') && normalized.contains('exist');

  bool get isWeakPassword => normalized.contains('password');

  bool get isInvalidData => normalized.contains('invalid');

  bool get isNetworkError =>
      normalized.contains('internet') ||
      normalized.contains('connection') ||
      normalized.contains('timeout');

  @override
  String toString() => message;
}
