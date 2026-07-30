import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/auth_screens/login_screen/widgets/custom_button.dart';
import 'package:Senaeya/View/Widgegts/customUserTextFiled.dart';
import 'package:Senaeya/View/Widgegts/custom_button/next_button.dart';
import 'package:Senaeya/View/Widgegts/custom_text_field/custom_text_field.dart';
import 'package:Senaeya/View/Widgegts/vin_text_field.dart';
import 'package:Senaeya/View/Widgets/carplate_text_filed.dart';
import 'package:Senaeya/View/Widgets/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../Widgegts/custom_text/custom_text.dart';
import '../../Widgegts/user_management.dart';
import '../../Widgegts/workshop_management.dart';
import '../../Widgets/commonTextWithoutResize.dart';
import '../../Widgets/custom_dropdown_field.dart';
import '../../Widgets/custom_phone_field_with_button.dart';
import '../../Widgets/custom_phone_text_filed/custom_phone_text_filed.dart';
import '../auth_screens/login_screen/widgets/custom_text_field.dart';
import 'controller/add_customer_screen_controller.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    AddCustomerScreenController controller =
        Get.find<AddCustomerScreenController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

    return Obx(
      () => Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xFF1771B7),
          appBar: CustomAppBar(
            backgroundColor: Colors.white,
            title: controller.isFromNewInvoice
                ? 'Customer Car Data'.tr
                : controller.userType.value == 1
                    ? 'add_workshop'.tr
                    : 'add_customer'.tr,
            titleColor: Colors.black,
            blackHomeIcon: true,
            // //blueCloud: true,
            centerTitle: true,
          ),
          body: controller.isLoading.value
              ? Center(
                  child: Image.asset(
                    AppImages.loading,
                    width: 150.w,
                    height: 150.w,
                  ),
                )
              : SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 8),
                                ],
                              ),
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Customer/Workshop selection
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Radio<int>(
                                              value: 0,
                                              groupValue:
                                                  controller.userType.value,
                                              onChanged: controller.setUserType,
                                              activeColor: AppColors.primary,
                                            ),
                                            CustomText(
                                              text: 'customer'.tr,
                                              fontSize: 18.w,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<int>(
                                              value: 1,
                                              groupValue:
                                                  controller.userType.value,
                                              onChanged: controller.setUserType,
                                              activeColor: AppColors.primary,
                                            ),
                                            CustomText(
                                              text: 'workshop'.tr,
                                              fontSize: 18.w,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  // Conditional rendering based on userType
                                  Obx(() {
                                    if (controller.userType.value == 1) {
                                      // Workshop view
                                      return WorkshopManagement(formKey1: formKey1, controller: controller);
                                    } else {
                                      // Customer view
                                      return UserManagement(formKey: formKey, controller: controller);
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}




