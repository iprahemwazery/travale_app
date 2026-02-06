import 'package:dio/dio.dart';
import 'api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // ✅ API custom message (WordPress)
    if (data is Map<String, dynamic>) {
      final message = data['message']?.toString();
      if (message != null && message.isNotEmpty) {
        return ApiError(message: message, statusCode: statusCode);
      }
    }

    // ✅ Status code handling
    switch (statusCode) {
      case 400:
        return ApiError(
          message: 'Invalid data sent to server',
          statusCode: statusCode,
        );
      case 401:
        return ApiError(
          message: 'Unauthorized request',
          statusCode: statusCode,
        );
      case 403:
        return ApiError(
          message: 'Email or username already exists',
          statusCode: statusCode,
        );
      case 404:
        return ApiError(message: 'Service not found', statusCode: statusCode);
      case 500:
        return ApiError(
          message: 'Server error, try again later',
          statusCode: statusCode,
        );
    }

    // ✅ Dio connection errors
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Connection timeout');

      case DioExceptionType.connectionError:
        return ApiError(message: 'No internet connection');

      default:
        return ApiError(message: 'Unexpected error occurred');
    }
  }
}
