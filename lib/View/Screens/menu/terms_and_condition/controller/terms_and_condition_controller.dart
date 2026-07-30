import 'package:Senaeya/Service/api_client.dart';
import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/terms_and_condition_model.dart';

class TermsAndConditionController extends GetxController {
  RxBool isloading = false.obs;
  Rxn<TermsandConditionModel> termsAndConditionModel =
      Rxn<TermsandConditionModel>();

  @override
  void onInit() {
    super.onInit();
    fetchTermsandCondition();
  }

  Future<void> fetchTermsandCondition() async {
    try {
      isloading(true);

      Response response = await ApiClient.getData(ApiConstant.termandConditon);

      if (response.statusCode == 200) {
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
        ${response.body.toString()}
        ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");

        termsAndConditionModel.value = TermsandConditionModel.fromJson(
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
