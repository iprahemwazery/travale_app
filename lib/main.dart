import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travale_app/app_routes.dart';
import 'package:travale_app/core/network/api_service.dart';
import 'package:travale_app/features/cart/data/cart_conttroler.dart';
import 'package:travale_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // GetX Controller
  Get.put(CartController());

  runApp(
    MultiRepositoryProvider(
      providers: [RepositoryProvider<ApiService>(create: (_) => ApiService())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder:
          (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Travel App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.light,
            home: SplashScreen(),
            getPages: AppPages.pages,
          ),
    );
  }
}
