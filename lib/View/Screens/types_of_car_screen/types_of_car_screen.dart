import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/View/Screens/home_screen/controller/home_controller.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgegts/cars_card/cars_card.dart';

class CarsCardScreen extends StatefulWidget {
  const CarsCardScreen({super.key});

  @override
  State<CarsCardScreen> createState() => _CarsCardScreenState();
}

class _CarsCardScreenState extends State<CarsCardScreen> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    // expect HomeController was registered earlier; otherwise this will throw
    controller = Get.find<HomeController>();
    controller.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(
          title: "CARS",
          titleColor: Colors.black,
          //redCloud: true,
          onBack: Get.back,
        ),
        body: Obx(() {
          if (controller.carsIsLoading.value) {
            return const Center(child: CircularProgressIndicator(color: Colors.white,));
          }
          return GridView.builder(
            itemCount: controller.countryList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
              childAspectRatio: 1.0, // Aspect ratio of each grid item
            ),
            itemBuilder: (context, index) {
              final item = controller.countryList[index];
              return Obx(() => CarsCard(
                    isSelected: controller.isSelectedById(item.sId),
                    title: item.title ?? '',
                    imagePath: item.image ?? '',
                    onTap: () async {
                      await controller.toggleSelection(item);
                    },
                  ));
            },
          );
        }),
      ),
    );
  }
}
