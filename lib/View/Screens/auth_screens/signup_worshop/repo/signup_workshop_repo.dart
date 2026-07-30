import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../Service/api_client.dart';
import '../../../../../Service/api_url.dart';
import '../model/create_workshop_check_model.dart';

class SignupWorkshopRepo {
  Future<Response> createWorkshop({
    required String workshopNameEnglish,
    required String workshopNameArabic,
    required String contact,
    required String unn,
    required String crn,
    required String mln,
    required String address,
    String? taxVatNumber,
    String? bankAccountNumber,
    required bool isAvailableMobileWorkshop,
    required Map<String, dynamic> workshopGEOlocation,
    required Map<String, dynamic> regularWorkingSchedule,
    required Map<String, dynamic> ramadanWorkingSchedule,
  }) async {
    try {
      // Create the complete workshop data object
      Map<String, dynamic> workshopData = {
        "workshopNameEnglish": workshopNameEnglish,
        "workshopNameArabic": workshopNameArabic,
        "contact": contact,
        "unn": unn,
        "crn": crn,
        "mln": mln,
        "address": address,
        "isAvailableMobileWorkshop": isAvailableMobileWorkshop,
        "workshopGEOlocation": workshopGEOlocation,
        "regularWorkingSchedule": regularWorkingSchedule,
        "ramadanWorkingSchedule": ramadanWorkingSchedule,
        "role": "WORKSHOP_OWNER",
      };

      // Only add optional fields if they have values
      if (taxVatNumber != null && taxVatNumber.isNotEmpty) {
        workshopData["taxVatNumber"] = taxVatNumber;
      }

      if (bankAccountNumber != null && bankAccountNumber.isNotEmpty) {
        workshopData["bankAccountNumber"] = bankAccountNumber;
      }

      // Send as form-data with a single "data" field containing JSON string
      Map<String, String> body = {"data": jsonEncode(workshopData)};

      Response response = await ApiClient.postMultipartData(
        ApiConstant.createWorkShop,
        body,
        multipartBody: [],
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }

  Future<CreateWorkShopCheckingModel> checkingWorkshoisCreatedOrNot({
    required String mln,
    required String crn,
    required String unn,
    required String tax,
  }) async {
    try {
      Response response = await ApiClient.getData("${ApiConstant.checkingWorkshopIsCreated}?mln=$mln&taxVatNumber=$tax&crn=$crn&unn=$unn");
      if (response.statusCode == 200) {
        return CreateWorkShopCheckingModel.fromJson(response.body);
      } else {
        return CreateWorkShopCheckingModel(
          message: response.body,
        );
      }

    } catch (e) {
      return CreateWorkShopCheckingModel(
        message: e.toString(),
      );
    }
  }
}
