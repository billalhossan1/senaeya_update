import 'package:Senaeya/Utils/AppColors/app_colors.dart';

import 'package:Senaeya/View/Widgegts/setting_card/setting_card.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/View/Screens/home_screen/controller/home_controller.dart';

class WorkShopWorkScreen extends StatefulWidget {
  const WorkShopWorkScreen({super.key});

  @override
  State<WorkShopWorkScreen> createState() => _WorkShopWorkScreenState();
}

class _WorkShopWorkScreenState extends State<WorkShopWorkScreen> {
  late HomeController controller;
  // final List<Color> _colors = [
  //   const Color(0xffF59331),
  //   const Color(0xffE26CCA),
  //   const Color(0xff3CA9AA),
  //   const Color(0xff3CA9AA),
  //   const Color(0xffFF3F49),
  //   const Color(0xff00B6FF),
  //   const Color(0xff00B6FF),
  //   const Color(0xff1DB7AE),
  // ];

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>();
    controller.getWorkShopWork();
    // Ensure the workshop-work list is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(
          title: 'workshop_work_title'.tr,
          titleColor: Colors.black,
          //blueCloud: true,
          onBack: Get.back,
        ),
        body: Obx(() {
          if (controller.workShopWorkIsLoading.value) {
            return const Center(child: CircularProgressIndicator(color: Colors.white,));
          }

          final list = controller.workShopWorkList;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 166 / 174,
              ),
              itemBuilder: (context, index) {
                final item = list[index];
                // Build image path: if image is already a URL, use it; otherwise prefix with base URL
                print("image===========================${item.image}");
                final imagePath =
                (item.image != null &&
                    (item.image!.startsWith('http') ||
                        item.image!.startsWith('https')))
                    ? item.image!
                    : '${ApiConstant.imageBaseUrl}${item.image ?? ''}';
                // final color = _colors[index % _colors.length];

                // Get current locale language code
                final currentLocale = Get.locale?.languageCode ?? 'en';

                return Obx(() => ServiceCard(
                  title: item.getLocalizedTitle(currentLocale),
                  imagePath: imagePath,
                  // color: color,
                  isSelected: controller.isWorkShopSelectedById(item.sId),
                  onTap: () async {
                    await controller.toggleWorkShopSelection(item);
                  },
                ));
              },
            ),
          );
        }),
      ),
    );
  }
}