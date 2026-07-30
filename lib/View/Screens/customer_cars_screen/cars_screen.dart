import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/View/Widgegts/customer_car_card/car_card.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Utils/AppImg/app_img.dart';
import 'controller/cars_controller.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CarsController controller = Get.put(CarsController());

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(
          title: "customer_cars".tr,
          titleColor: Colors.black,
          //blueCloud: true,
          centerTitle: true,
          onBack: Get.back,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 1.sh,
                maxHeight: 1.sh,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              // Use Obx to reactively rebuild when controller changes
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: Image.asset(
                      AppImages.loading,
                      width: 150.w,
                      height: 150.w,
                    ),
                  );
                }

                if (controller.cars.isEmpty) {
                  return Center(child: Text('no_cars_found'.tr));
                }

                // Scrollable list of car cards
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: controller.cars.length,
                  itemBuilder: (context, index) {
                    final car = controller.cars[index];
                    return CarCard(car: car);
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
