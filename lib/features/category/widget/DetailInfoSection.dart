import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travale_app/core/constants/app_color.dart';
import 'package:travale_app/core/constants/textstyles.dart';
import 'package:travale_app/features/cart/data/cart_conttroler.dart';
import 'package:travale_app/features/cart/data/cart_model.dart';
import 'package:travale_app/features/category/detail_controller.dart';
import 'package:travale_app/features/category/widget/DetailTitleSection.dart';
import 'package:travale_app/features/category/widget/payment_bottom_sheet.dart';
import 'package:travale_app/features/category/widget/preview_image_section.dart';

class DetailInfoSection extends StatelessWidget {
  final DetailController controller;
  const DetailInfoSection({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26.r),
            topRight: Radius.circular(26.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailTitleSection(),
            SizedBox(height: 18.h),
            Text(
              "The mighty Rinjani mountain of Gunung Rinjani is a massive volcano which towers over the island of Lombok. A climb to the top is one of the most exhilarating experiences you can have in Indonesia. At 3,726 meters tall, Gunung Rinjani is the second highest mountain in Indonesia...",
              style: AppTextStyle.defaultStyle.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 22.h),
            PreviewImageSection(controller: controller),
            SizedBox(height: 36.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  minimumSize: Size(double.infinity, 48.h),
                ),
                onPressed: () {
                  /// 1️⃣ إضافة للسلة
                  cartController.addToCart(
                    CartItemModel(
                      id: 1,
                      title: "Rinjani Mountain",
                      image: "assets/images/Rinjani.png",
                      price: 48,
                      quantity: 1,
                    ),
                  );

                  /// 2️⃣ Snackbar احترافي
                  Get.snackbar(
                    "Added to Cart",
                    "Trip added successfully",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.black87,
                    colorText: Colors.white,
                    margin: EdgeInsets.all(16.w),
                    borderRadius: 12.r,
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    duration: const Duration(seconds: 2),
                  );

                  Future.delayed(const Duration(milliseconds: 300), () {
                    Get.bottomSheet(
                      const PaymentBottomSheet(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  });
                },
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
