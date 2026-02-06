import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travale_app/core/network/api_service.dart';
import 'package:travale_app/core/network/pref_helper.dart';
import 'package:travale_app/root.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ApiService apiService;

  RegisterCubit(this.apiService) : super(RegisterInitial());

  Future<void> register({
    required String username,
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    required BuildContext context,
  }) async {
    emit(RegisterLoading());

    try {
      // 1️⃣ إنشاء المستخدم
      final createResponse = await apiService.createUser(
        username: username,
        password: password,
        email: email,
        firstName: firstName ?? '',
        lastName: lastName ?? '',
      );

      if (createResponse == null || createResponse['success'] != true) {
        throw Exception(createResponse?['message'] ?? 'Failed to create user');
      }

      // 2️⃣ تسجيل الدخول تلقائي
      final loginResponse = await apiService.login(
        username: username,
        password: password,
      );

      if (loginResponse != null && loginResponse['token'] != null) {
        await PrefHelper.saveToken(loginResponse['token']);
      } else {
        throw Exception(
          loginResponse?['message'] ?? 'Login failed: token not received',
        );
      }

      emit(RegisterSuccess());

      // 3️⃣ الانتقال إلى Root بدون رجوع
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Root()),
        (route) => false,
      );
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
