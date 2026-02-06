import 'package:get/get.dart';

class DetailController extends GetxController {
  RxString currentImage = "assets/images/Rinjani.png".obs;

  final List<String> previewImages = [
    "assets/images/rinjani-4.png",
    "assets/images/rinjani-3.png",
    "assets/images/rinjani-2.png",
    "assets/images/rinjani-1.png",
  ];

  RxBool isFavorite = false.obs;

  RxList<String> favoriteItems = <String>[].obs;

  void changeImage(String img) {
    currentImage.value = img;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    if (isFavorite.value) {
      favoriteItems.add(currentImage.value);
    } else {
      favoriteItems.remove(currentImage.value);
    }
  }
}
