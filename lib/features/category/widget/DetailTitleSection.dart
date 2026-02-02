import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travale_app/core/constants/app_color.dart';
import 'package:travale_app/core/constants/textstyles.dart';

class DetailTitleSection extends StatelessWidget {
  const DetailTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rinjani Mountain", style: AppTextStyle.defaultHeaderOne),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColor.primaryColor,
                  size: 16.r,
                ),
                SizedBox(width: 4.w),
                Text(
                  "Lombok, Indonesia",
                  style: AppTextStyle.loca.copyWith(
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "\$48",
              style: AppTextStyle.defaultHeaderOne.copyWith(fontSize: 24.sp),
            ),
            SizedBox(width: 4.w),
            Text(
              "/Person",
              style: AppTextStyle.smallText.copyWith(
                color: AppColor.secondTextColor,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
