import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Core/AppRoute/app_route.dart';
import '../Widgegts/custom_alert_dialog/custom_alert_dialog.dart';

class CommonAlertDialog {
  static void showRegisterWorkshopDialog(){
    CustomAlert.showInfo(
      context: Get.context!,
      message: 'You must register your workshop first'.tr,
      onPressed: () {
        Navigator.of(Get.context!).pop();
        Get.toNamed(AppRoute.signupWorkshopScreen);
      },
    );
  }
}