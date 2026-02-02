import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travale_app/features/category/widget/DetailImageSection.dart';
import 'package:travale_app/features/category/widget/DetailInfoSection.dart';

import 'package:travale_app/features/category/detail_controller.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key});

  final DetailController controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            DetailImageSection(controller: controller),
            DetailInfoSection(controller: controller),
          ],
        ),
      ),
    );
  }
}
