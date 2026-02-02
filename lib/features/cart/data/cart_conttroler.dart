import 'package:get/get.dart';
import 'cart_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addToCart(CartItemModel item) {
    final index = cartItems.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }
  }

  void removeItem(int id) {
    cartItems.removeWhere((item) => item.id == id);
  }

  void increaseQty(CartItemModel item) {
    item.quantity++;
    cartItems.refresh();
  }

  void decreaseQty(CartItemModel item) {
    if (item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
    }
  }
}
