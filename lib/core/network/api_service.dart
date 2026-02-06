import 'package:dio/dio.dart';
import 'package:travale_app/core/network/api_exceptions.dart';
import 'package:travale_app/core/network/dio_client.dart';
import 'package:travale_app/features/home/data/models/tour_models.dart';
import 'package:travale_app/features/profile/models/user_models.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  /// ============================
  /// GET
  /// ============================
  Future<dynamic> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      print('GET Error: ${e.response?.data}');
      return ApiExceptions.handleError(e);
    }
  }

  /// ============================
  /// POST
  /// ============================
  Future<dynamic> post(
    String endPoint,
    dynamic body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      print('POST Error: ${e.response?.data}');
      return ApiExceptions.handleError(e);
    }
  }

  /// ============================
  /// REGISTER USER (WordPress)
  /// ============================
  Future<dynamic> createUser({
    required String username,
    required String password,
    required String email,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        'https://travel.wazery.net/wp-json/traveler/create-user',
        data: {
          'username': username,
          'password': password,
          'email': email,
          'first_name': firstName ?? '',
          'last_name': lastName ?? '',
        },
      );

      print('Register response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('Register error: ${e.response?.data}');
      return e.response?.data;
    }
  }

  /// ============================
  /// LOGIN (JWT)
  /// ============================
  Future<Map<String, dynamic>?> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        'https://travel.wazery.net/wp-json/jwt-auth/v1/token',
        data: {'username': username, 'password': password},
      );
      return response.data; // هنا Map
    } on DioException catch (e) {
      print('Login error: ${e.response?.data}');
      return null; // بدل ما يرجع ApiError
    }
  }

  /// ============================
  /// CURRENT USER
  /// ============================
  Future<User?> getCurrentUser() async {
    try {
      final response = await _dioClient.dio.get(
        'https://travel.wazery.net/wp-json/wp/v2/users/me',
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      print('Get user error: ${e.response?.data}');
      return null;
    }
  }

  /// ============================
  /// TOURS
  /// ============================

  Future<List<Tour>> getTours({int page = 1, int perPage = 10}) async {
    try {
      final response = await _dioClient.dio.get(
        '/traveler/services/tours',
        queryParameters: {
          'paged': page,
          'posts_per_page': perPage,
          'orderby': 'ID',
          'order': 'ASC',
        },
      );

      if (response.data['success'] == true) {
        final List data = response.data['data'];
        return data.map((e) => Tour.fromJson(e)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Tours error: ${e.response?.data ?? e.message}');
      return [];
    }
  }
}
