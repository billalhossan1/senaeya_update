import 'package:Senaeya/Service/api_client.dart';
import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../home_screen/controller/home_controller.dart';

import '../../../Widgegts/custom_alert_dialog/custom_alert_dialog.dart';

class ReportScreenController extends GetxController {
  // Report type selection
  RxBool isLoading = false.obs;
  var selectedReportType = "Weekly".obs;

  // Date selection
  var selectedDay = ''.obs;
  var selectedMonth = ''.obs;
  var selectedYear = ''.obs;

  // Checkbox selections
  RxBool includeIncome = true.obs;
  RxBool includeOutlay = true.obs;
  RxBool includeNumberOfCars = true.obs;

  // Daily report generation toggle
  RxBool generateDailyReport = false.obs;

  // Language selection
  var selectedLanguage = "Arabic".obs;
  
  @override
  void onReady() {
    super.onReady();
    _checkInitialAuthorization();
  }

  Future<void> _checkInitialAuthorization() async {
    if (Get.isRegistered<HomeController>()) {
      HomeController homeController = Get.find<HomeController>();
      isLoading.value = true;
      bool isAuth = await homeController.checkAuthorization(popOnUnAuthorized: true);
      if (!isAuth) {
        isLoading.value = false;
        return;
      }
      isLoading.value = false;
    }
  }

  void reportSuccess(){
    CustomAlert.showInfo(
      context: Get.context!,
      message: 'The report has been issued and sent via WhatsApp.'.tr,
      onPressed: () {
        Get.back();
        Get.back();
      },
    );
  }

  Future<bool> generateReport() async {
    // Validate form first (before setting loading)
    if (selectedDay.value.isEmpty ||
        selectedMonth.value.isEmpty ||
        selectedYear.value.isEmpty) {
      showCustomSnackBar("select_complete_date".tr,isError: true);
      return false;
    }

    try {
      isLoading(true);

      // Format dates as YYYY-M-D (without leading zeros for month and day)
      String startDate =
          '${selectedYear.value}-${int.parse(selectedMonth.value)}-${int.parse(selectedDay.value)}';

      // Calculate end date based on report type
      String endDate = _calculateEndDate(
        int.parse(selectedYear.value),
        int.parse(selectedMonth.value),
        int.parse(selectedDay.value),
      );

      // Map language to 'en' or 'ar'
      String lang = selectedLanguage.value.toLowerCase() == 'english'
          ? 'en'
          : 'ar';

      // Build query parameters
      String url =
          '${ApiConstant.getReport}?startDate=$startDate&endDate=$endDate&lang=$lang&isReleased=true'
          '&noOfCars=${includeNumberOfCars.value.toString().toLowerCase()}'
          '&outlay=${includeOutlay.value.toString().toLowerCase()}'
          '&income=${includeIncome.value.toString().toLowerCase()}';

      debugPrint('Report URL: $url');
      debugPrint('Report Type: ${selectedReportType.value}');
      debugPrint('Start Date: $startDate');
      debugPrint('End Date: $endDate');
      debugPrint('Language: $lang');
      debugPrint('Include Income: ${includeIncome.value}');
      debugPrint('Include Outlay: ${includeOutlay.value}');
      debugPrint('Include Number of Cars: ${includeNumberOfCars.value}');

      Response response = await ApiClient.getData(url);

      if (response.statusCode == 200) {
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅
response: ${response.body}
✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");
        reportSuccess();

        return true; // Success
      } else {
        debugPrint("Error response: ${response.statusCode} - ${response.body}");

        showCustomSnackBar(response.statusText??"error_title".tr,isError: true);
        return false;
      }
    } catch (e) {
      debugPrint('Error generating report: $e');
      showCustomSnackBar("error_title".tr,isError: true);
      return false;
    } finally {
      isLoading(false);
    }
  }

  String _calculateEndDate(int year, int month, int day) {
    DateTime startDate = DateTime(year, month, day);
    DateTime endDate;

    switch (selectedReportType.value) {
      case "Daily":
        endDate = startDate;
        break;
      case "Weekly":
        endDate = startDate.add(const Duration(days: 6));
        break;
      case "Monthly":
        endDate = DateTime(year, month + 1, day);
        break;
      case "3-month":
        endDate = DateTime(year, month + 3, day);
        break;
      case "6-month":
        endDate = DateTime(year, month + 6, day);
        break;
      case "Annual":
        endDate = DateTime(year + 1, month, day);
        break;
      default:
        endDate = startDate;
    }

    return '${endDate.year}-${endDate.month}-${endDate.day}';
  }
}
