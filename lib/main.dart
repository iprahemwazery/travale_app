// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travale_app/app_routes.dart';
import 'package:travale_app/features/cart/data/cart_conttroler.dart';
import 'package:travale_app/splash_screen.dart';

void main() async {
  //  لتشغيل المفضله يعني انه يسمع فيها
  Get.put(CartController());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // تهيئة التخزين
  runApp(const MyApp());
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
