import 'dart:convert';
import 'package:Senaeya/Helper/shared_prefe/shared_prefe.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../Service/api_client.dart';
import '../../../../../Service/api_url.dart';

class EditWorkshopScreenRepo {
  Future<Response> createWorkshop({
    required String workshopNameEnglish,
    required String workshopNameArabic,
    required String contact,
    required String unn,
    required String crn,
    required String mln,
    required String address,
    required String taxVatNumber,
    required String bankAccountNumber,
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
        "taxVatNumber": taxVatNumber,
        "bankAccountNumber": bankAccountNumber,
        "isAvailableMobileWorkshop": isAvailableMobileWorkshop,
        "workshopGEOlocation": workshopGEOlocation,
        "regularWorkingSchedule": regularWorkingSchedule,
        "ramadanWorkingSchedule": ramadanWorkingSchedule,
      };

      // Send as form-data with a single "data" field containing JSON string
      Map<String, String> body = {"data": jsonEncode(workshopData)};
      var workshopId = await SharePrefsHelper.getString(
        SharedPreferenceValue.workshopId,
      );
      Response response = await ApiClient.patchMultipartData(
        "${ApiConstant.createWorkShop}/$workshopId",
        body,
        multipartBody: [],
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }

  // Get the Workshop data for editing
  Future<Response> getWorkshopData() async {
    try {
      var workshopId = await SharePrefsHelper.getString(
        SharedPreferenceValue.workshopId,
      );
      Response response = await ApiClient.getData(
        "${ApiConstant.createWorkShop}/$workshopId",
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }

  // Update workshop - only editable fields
  Future<Response> updateWorkshop({
    required String workshopNameEnglish,
    required String contact,
    required String address,
    String? taxVatNumber,
    required String bankAccountNumber,
    required bool isAvailableMobileWorkshop,
    required Map<String, dynamic> workshopGEOlocation,
    required Map<String, dynamic> regularWorkingSchedule,
    required Map<String, dynamic> ramadanWorkingSchedule,
  }) async {
    try {
      var workshopId = await SharePrefsHelper.getString(
        SharedPreferenceValue.workshopId,
      );

      // Create the workshop data object with only editable fields
      Map<String, dynamic> workshopData = {
        "workshopNameEnglish": workshopNameEnglish,
        "contact": contact,
        "address": address,
        // "taxVatNumber": taxVatNumber,
        "isAvailableMobileWorkshop": isAvailableMobileWorkshop,
        "workshopGEOlocation": workshopGEOlocation,
        "regularWorkingSchedule": regularWorkingSchedule,
        "ramadanWorkingSchedule": ramadanWorkingSchedule,
      };
      if(bankAccountNumber.isNotEmpty){
        workshopData["bankAccountNumber"]=bankAccountNumber;
      }
      if(taxVatNumber!=null && taxVatNumber.isNotEmpty){
        workshopData["taxVatNumber"]=taxVatNumber;
      }

      // Send as form-data with a single "data" field containing JSON string
      Map<String, String> body = {"data": jsonEncode(workshopData)};

      Response response = await ApiClient.patchMultipartData(
        "${ApiConstant.createWorkShop}/$workshopId",
        body,
        multipartBody: [],
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }
}
