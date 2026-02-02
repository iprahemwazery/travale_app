import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travale_app/core/constants/app_color.dart';
import 'package:travale_app/core/constants/textstyles.dart';
import 'package:travale_app/features/category/detail_controller.dart';
import 'package:travale_app/features/widgets/previewImage.dart';

class DetailPreviewSection extends StatelessWidget {
  final DetailController controller;
  const DetailPreviewSection({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Preview", style: AppTextStyle.defaultHeaderOne),
            Container(
              height: 30.h,
              width: 50.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColor.bgColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 18.sp,
                    color: const Color.fromARGB(255, 248, 229, 1),
                  ),
                  SizedBox(width: 4.w),
                  Text("4.8", style: AppTextStyle.defaultStyle),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                controller.previewImages.map((img) {
                  return GestureDetector(
                    onTap: () => controller.changeImage(img),
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: PreviewImage(image: img),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
