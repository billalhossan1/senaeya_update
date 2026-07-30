import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/car_invoices_screen/repo/car_invoices_repo.dart';
import 'package:Senaeya/View/Screens/previous_invoices_screen/model/previous_invoices_model.dart';
import 'package:Senaeya/View/Widgegts/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';

class CarInvoicesController extends GetxController{
  RxBool isLoading = false.obs;
  String carId = '';

  @override
  void onInit() {
    carId = Get.arguments['carId'] ?? '';
    scrollController.addListener(_scrollListener);
    super.onInit();
    getInvoices();
  }
  RxList<InvoiceModel>invoicesList=<InvoiceModel>[].obs;
  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int totalPages = 1;
  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (currentPage < totalPages) {
        currentPage++;
        getInvoices(page: currentPage);
      }
    }
  }

  Future<void>getInvoices({int page=1})async{
    isLoading.value = true;
    Response response = await CarInvoicesRepo().getInvoicesByCar(page: page, carId: carId);
    isLoading.value = false;

    if(response.statusCode ==200){
      if(page==1){
        invoicesList.clear();
      }
      PreviousInvoicesResponse invoicesListModel = PreviousInvoicesResponse.fromJson(response.body);
      invoicesList.addAll(invoicesListModel.data?.invoicesList ?? []);
      totalPages = invoicesListModel.data?.meta?.totalPage ?? 1;
    }else{
      showCustomSnackBar(response.statusText??'Unknown error occurred');
    }
  }

  RxBool isDefaultList = false.obs;
  RxBool isExtraTimeer = false.obs;
  Future<void> onTapDefaultersList(String id) async {
    try {
      isDefaultList.value = true;


      Response response = await ApiClient.patchData(
        ApiConstant.defaulterList(id),
      );

      if (response.statusCode == 200) {
        bool isBlock =response.body["data"]["status"]=='Block';
          CustomAlert.showInfo(
            context: Get.context!,
            message: isBlock?'The customer has been placed on the defaulters list'.tr:'The customer has been removed from the defaulters list'.tr,
            onPressed: () {
              Get.back();
            },
          );
        // showCustomSnackBar("${response.body["data"]["status"]} Successfully", isError: false);
        // print("Marked as defaulter successfully");
        // refreshCurrentTab();
      } else {
        showCustomSnackBar(
          "Failed to mark as defaulter: ${response.statusText}",
        );
      }
    } catch (e) {
      showCustomSnackBar("Error in marking as defaulter: ${e.toString()}");
    } finally {
      isDefaultList.value = false;
    }
  }

  Future<void> onTapExtendTime(String id) async {
    try {
      isExtraTimeer.value = true;
      Map<String, dynamic> body = {"extraTimeForUnpaidPostpaidInvoice": 3};
      Response response = await ApiClient.patchData(
        "${ApiConstant.getInvoices}/$id",
        body: body,
      );

      if (response.statusCode == 200) {
        showCustomSnackBar("Extra 3 days Given".tr, isError: false);
        refreshCurrentTab();
      } else {
        showCustomSnackBar("response.statusText");
      }
    } catch (e) {
      showCustomSnackBar("Error: ${e.toString()}");
    } finally {
      isExtraTimeer.value = false;
    }
  }

  /// Refresh current invoice list: reset pagination, clear list and reload
  void refreshCurrentTab() {
    // Reset pagination and data
    currentPage = 1;
    totalPages = 1;
    invoicesList.clear();

    // Reset scroll position safely
    try {
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    } catch (_) {}

    // Reload first page
    getInvoices(page: 1);
  }

}
