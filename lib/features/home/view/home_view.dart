import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:travale_app/app_routes.dart';
import 'package:travale_app/core/constants/app_color.dart';
import 'package:travale_app/core/constants/textstyles.dart';
import 'package:travale_app/features/home/data/models/home_contrroler.dart';
import 'package:travale_app/features/widgets/categoryWidget.dart';
import 'package:travale_app/features/widgets/judulWidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    MediaQuery.of(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 50.h, bottom: 24.h),
              color: AppColor.primaryColor,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundImage: const AssetImage(
                      "assets/images/profil2.png",
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "ebrahem@email.com",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                    icon: SvgPicture.asset(
                      "assets/icons/menu.svg",
                      height: 22.h,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Current Location",
                        style: AppTextStyle.defaultStyle,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColor.primaryColor,
                            size: 14.r,
                          ),
                          SizedBox(width: 4.w),
                          Text("Denpasar, Bali", style: AppTextStyle.loca),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18.r,
                    backgroundImage: const AssetImage(
                      "assets/images/profil2.png",
                    ),
                  ),
                ],
              ),

              SizedBox(height: 36.h),

              // ===== CATEGORY =====
              JudulWidget(judul: "Category"),
              SizedBox(height: 22.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryWidget(
                      gambar: "assets/icons/MOUNTAIN.svg",
                      judul: "Mountain",
                    ),
                    SizedBox(width: 12),
                    CategoryWidget(
                      gambar: "assets/icons/WATERFALL.svg",
                      judul: "Waterfall",
                    ),
                    SizedBox(width: 12),
                    CategoryWidget(
                      gambar: "assets/icons/RIVER.svg",
                      judul: "River",
                    ),
                    SizedBox(width: 12),
                    CategoryWidget(
                      gambar: "assets/icons/FOREST.svg",
                      judul: "Forest",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 22.h),

              // ===== TOURS FROM API (Vertical List + Pull to Refresh + Caching) =====
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.tours.isEmpty) {
                    return const Center(child: Text("No Tours Found"));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchTours(); // تحديث البيانات
                    },
                    child: ListView.builder(
                      itemCount: controller.tours.length,
                      padding: EdgeInsets.only(bottom: 20.h, top: 12.h),
                      itemBuilder: (context, index) {
                        final tour = controller.tours[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: InkWell(
                            onTap: () {
                              // الانتقال لصفحة التفاصيل
                              Get.toNamed(AppRoutes.detail, arguments: tour);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // الصورة
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      topRight: Radius.circular(12.r),
                                    ),
                                    child:
                                        tour.image != null
                                            ? Image.network(
                                              tour.image!,
                                              width: double.infinity,
                                              height: 180.h,
                                              fit: BoxFit.cover,
                                            )
                                            : Image.asset(
                                              'assets/images/Bromo.png',
                                              width: double.infinity,
                                              height: 180.h,
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // العنوان
                                        Text(
                                          tour.title,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        // الوصف
                                        Text(
                                          tour.excerpt,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        // السعر افتراضي
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 4.h,
                                                horizontal: 8.w,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                              ),
                                              child: Text(
                                                "\$0",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),

              // SizedBox(height: 26.h),
            ],
          ),
        ),
      ),
    );
  }
}
