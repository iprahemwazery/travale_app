import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travale_app/features/category/detail_controller.dart';

class DetailImageSection extends StatelessWidget {
  final DetailController controller;
  const DetailImageSection({required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Obx(
              () => Container(
                width: double.infinity,
                height: 380.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(controller.currentImage.value),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 44.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 40.h,
                      width: 36.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  _buildIconButton(
                    onTap: () => controller.toggleFavorite(),
                    isFavorite: controller.isFavorite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required VoidCallback onTap,
    required RxBool isFavorite,
  }) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.h,
          width: 36.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
          ),
          child: Icon(
            Icons.favorite,
            color: isFavorite.value ? Colors.red : Colors.black,
            size: 18.sp,
          ),
        ),
      ),
    );
  }
}
