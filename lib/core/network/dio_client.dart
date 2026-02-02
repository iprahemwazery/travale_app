import 'package:dio/dio.dart';
import 'package:travale_app/core/network/pref_helper.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://travel.wazery.net/wp-json',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();

          print('➡️ API Request: ${options.method} ${options.uri}');
          print('🔑 Token: ${token ?? 'null'}');

          final publicEndpoints = [
            '/traveler/services/tours',
            '/traveler/services/categories',
            '/jwt-auth/v1/token',
            '/traveler/create-user',
          ];

          final isPublic = publicEndpoints.any((e) => options.path.contains(e));

          if (!isPublic &&
              token != null &&
              token.isNotEmpty &&
              token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
            print('✅ Authorization header added');
          } else {
            print('🟢 Public endpoint (no auth)');
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            '✅ API Response [${response.statusCode}] => ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print(
            '❌ API Error [${e.response?.statusCode}] => ${e.requestOptions.path}',
          );
          print('❌ Message: ${e.response?.data ?? e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
