import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travale_app/core/network/api_service.dart';
import 'package:travale_app/core/network/pref_helper.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService apiService;

  LoginCubit(this.apiService) : super(LoginInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final response = await apiService.post(
        'https://travel.wazery.net/wp-json/jwt-auth/v1/token',
        {'username': username, 'password': password},
      );

      if (response != null && response['token'] != null) {
        await PrefHelper.saveToken(response['token']);
        emit(LoginSuccess());
      } else {
        emit(LoginError('Login failed. No token received.'));
      }
    } catch (e) {
      emit(LoginError('Login failed: $e'));
    }
  }
}
