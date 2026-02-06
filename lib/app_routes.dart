import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:travale_app/features/cart/view/cart_view.dart';
import 'package:travale_app/features/category/detail_page.dart';
import 'package:travale_app/features/favorites/view/favourite_view.dart';
import 'package:travale_app/features/home/view/home_view.dart';
import 'package:travale_app/root.dart';

class AppRoutes {
  static final String home = '/home';
  static final String favourite = '/favourite';
  static final String cart = '/cart';
  static final String profile = '/profile';
  static final String detail = '/detail';
  static final String settings = '/settings';
  static final String root = '/root';
}

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.home, page: () => HomeView()),
    GetPage(name: AppRoutes.root, page: () => Root()),
    GetPage(name: AppRoutes.favourite, page: () => FavouriteView()),
    GetPage(name: AppRoutes.cart, page: () => CartView()),
    //  GetPage(name: AppRoutes.profile, page: () => ProfileView()),
    GetPage(name: AppRoutes.detail, page: () => DetailView()),
    //GetPage(name: AppRoutes.settings, page: () => SettingsView()),
  ];
}
