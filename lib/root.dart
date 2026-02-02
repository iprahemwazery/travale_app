import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:travale_app/features/cart/data/cart_conttroler.dart';
import 'package:travale_app/features/cart/view/cart_view.dart';
import 'package:travale_app/features/favorites/view/favourite_view.dart';
import 'package:travale_app/features/home/view/home_view.dart';
import 'package:travale_app/features/profile/widget/profile_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;

  final CartController cartController = Get.find<CartController>();

  final List<Widget> _pages = [
    HomeView(),
    CartView(),
    FavouriteView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Color(0xFF4C53A5),
        buttonBackgroundColor: Colors.blueAccent,
        animationDuration: const Duration(milliseconds: 300),
        items: [
          const Icon(Icons.home, size: 30, color: Colors.white),

          const Icon(Icons.shopping_cart, size: 30, color: Colors.white),

          const Icon(Icons.favorite, size: 30, color: Colors.white),
          const Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
