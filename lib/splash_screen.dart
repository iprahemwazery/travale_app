import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travale_app/app_routes.dart';
import 'package:travale_app/auth/login/login_view.dart';
import 'package:travale_app/core/network/pref_helper.dart';
import 'package:travale_app/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final token = await PrefHelper.getToken();

    // لو موجود توكن، المستخدم مسجل دخول سابقًا
    if (token != null && token.isNotEmpty) {
      Get.toNamed(AppRoutes.root);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
