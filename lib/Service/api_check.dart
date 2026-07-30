import 'package:get/get.dart';

import 'package:Senaeya/Helper/shared_prefe/shared_prefe.dart';
import 'package:Senaeya/Utils/AppConst/app_const.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';


class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (response.statusCode == 401) {
      await SharePrefsHelper.remove(AppConstants.bearerToken);
      //Get.offAllNamed(AppRoute.signInScreen);
    } else {
      showCustomSnackBar(response.statusText!,);
    }
  }
}
