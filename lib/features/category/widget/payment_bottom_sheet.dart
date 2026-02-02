import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.55.sh, // نص الشاشة تقريبًا
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// 🔹 Title
          Text(
            "Payment",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20.h),

          /// 🔹 Total Price
          _infoRow("Total", "\$84.00"),

          SizedBox(height: 20.h),

          /// 🔹 Payment Methods
          Text(
            "Payment Method",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),

          SizedBox(height: 10.h),

          _paymentItem(icon: Icons.credit_card, title: "Credit / Debit Card"),
          _paymentItem(icon: Icons.account_balance_wallet, title: "Wallet"),
          _paymentItem(icon: Icons.paypal, title: "PayPal"),

          const Spacer(),

          /// 🔹 Confirm Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                Get.snackbar(
                  "Success",
                  "Payment completed",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text("Confirm Payment"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16.sp)),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _paymentItem({required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // لاحقًا: اختيار طريقة الدفع
      },
    );
  }
}
