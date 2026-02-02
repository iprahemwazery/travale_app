import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travale_app/features/home/data/models/tour_models.dart';
import 'package:travale_app/core/network/api_service.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = true.obs;
  var tours = <Tour>[].obs;

  final GetStorage storage = GetStorage(); // التخزين المحلي

  @override
  void onInit() {
    super.onInit();
    loadTours();
  }

  /// 1️⃣ جرب تحميل البيانات من الكاش أولاً
  void loadTours() {
    List<dynamic>? cachedData = storage.read<List<dynamic>>('tours');
    if (cachedData != null && cachedData.isNotEmpty) {
      tours.value = cachedData.map((e) => Tour.fromJson(e)).toList();
      print("Loaded tours from cache: ${tours.length}");
    }

    // بعدين جلب البيانات من API
    fetchTours();
  }

  /// 2️⃣ جلب البيانات من API وتخزينها في الكاش
  Future<void> fetchTours() async {
    try {
      isLoading(true);
      final result = await _apiService.getTours();
      tours.assignAll(result);

      // حفظ البيانات في الكاش
      storage.write('tours', result.map((e) => e.toJson()).toList());

      print("Tours fetched from API: ${result.length}");
    } catch (e) {
      print("Error fetching tours: $e");
    } finally {
      isLoading(false);
    }
  }
}
