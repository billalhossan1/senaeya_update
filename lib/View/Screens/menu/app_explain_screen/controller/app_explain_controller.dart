import 'package:Senaeya/Service/api_client.dart';
import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../terms_and_condition/model/terms_and_condition_model.dart';

class AppExplainController extends GetxController {
  RxBool isloading = false.obs;
  Rxn<TermsandConditionModel> appExplain =
  Rxn<TermsandConditionModel>();

  @override
  void onInit() {
    super.onInit();
    fetchAppExplain();
  }

  Future<void> fetchAppExplain() async {
    try {
      isloading(true);

      Response response = await ApiClient.getData(ApiConstant.appExplain);

      if (response.statusCode == 200) {
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
        ${response.body.toString()}
        ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");

        appExplain.value = TermsandConditionModel.fromJson(
          response.body,
        );
        isloading(false);
      } else {
        showCustomSnackBar("Error in Fetching the Terms and Condition");
      }
    } catch (e) {
      showCustomSnackBar("Error in Fetching the Terms and Condition");
    }
  }
}
