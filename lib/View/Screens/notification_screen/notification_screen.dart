import 'package:Senaeya/View/Screens/notification_screen/controller/notification_controller.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:Senaeya/View/Widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationController controller = Get.find<NotificationController>();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF1771B7),
        appBar: CustomAppBar(
          title: "Notifications".tr,
          titleColor: Colors.black,
          //blueCloud: true,
          blackHomeIcon: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.notificationsList.isEmpty
                        ? Center(
                            child: CustomText(
                              text: "No Notification Yet".tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: ListView.builder(
                              itemCount: controller.notificationsList.length,
                              itemBuilder: (context, index) {
                                final notification = controller.notificationsList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: NotificationCard(
                                    notification: notification,
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
