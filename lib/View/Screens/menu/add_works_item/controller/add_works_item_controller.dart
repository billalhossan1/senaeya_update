import 'package:Senaeya/Service/api_client.dart';
import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/menu/add_works_item/models/works_category_model.dart';
import 'package:Senaeya/View/Widgegts/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Helper/shared_prefe/shared_prefe.dart';
import '../../../../../Utils/AppColors/app_colors.dart';

class AddWorksItemController extends GetxController {
  // Text controller for the work item input
  RxBool isLoading = false.obs;
  final TextEditingController workItemController = TextEditingController();
  Rxn<WorkCategoryModel> workCategoryData = Rxn<WorkCategoryModel>();

  // Observable variables
  var selectedSection = Rxn<String>();
  var selectedIndex = (-1).obs;
  var workName = ''.obs;
  var qty = 1.obs;

  // Lists
  var sections = <String>[].obs; // Localized category names for display
  var categoryMap = <String, Datum>{}.obs; // Map: localized name -> category data
  var workItems = <Map<String, dynamic>>[].obs;
  // String name = '';

  @override
  void onInit() {
    super.onInit();
    // name = Get.arguments['name'] ?? '';
    fetchWorkCategoryData();
  }

  @override
  void onClose() {
    workItemController.dispose();
    super.onClose();
  }

  Future<void> fetchWorkCategoryData() async {
    try {
      isLoading(true);
      Response response = await ApiClient.getData(ApiConstant.workCategory);

      if (response.statusCode == 200) {
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
        ${response.body.toString()}
        ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");

        workCategoryData.value = WorkCategoryModel.fromJson(response.body);

        // Populate sections list with category names
        if (workCategoryData.value?.data != null) {
          sections.clear();
          categoryMap.clear();
          for (var category in workCategoryData.value!.data!) {
            // Use localized title for display
            String localizedName = category.localizedTitle;
            if (localizedName.isNotEmpty) {
              sections.add(localizedName);
              categoryMap[localizedName] = category; // Store the full category data
            }
          }
        }

        if (sections.isEmpty) {
          showCustomSnackBar('No work categories found', isError: true);
        }
      } else {
        showCustomSnackBar('Failed to fetch work category data', isError: true);
      }
    } catch (e) {
      debugPrint('Error fetching work category data: $e');
      showCustomSnackBar(
        'Error fetching work category data: $e',
        isError: true,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> sendAlltheItem() async {
    try {
      isLoading(true);

      // Validate that there are items to send
      if (workItems.isEmpty) {
        showCustomSnackBar('No work items to send', isError: true);
        return;
      }

      String workShopId = '';
      try {
        workShopId = await SharePrefsHelper.getString(
          SharedPreferenceValue.workshopId,
        );
        debugPrint(
          'SendWorkItems - WorkshopId: $workShopId, type: ${workShopId.runtimeType}',
        );
      } catch (e) {
        debugPrint('Error getting workshop ID: $e');
        showCustomSnackBar('Error getting workshop ID', isError: true);
        return;
      }

      if (workShopId.isEmpty) {
        showCustomSnackBar('Workshop ID not found', isError: true);
        return;
      }

      // Build the request body
      Map<String, dynamic> body = {
        "data": workItems
            .map(
              (item) {
                // Get the original workCategoryName from the category map
                String localizedSection = item['section'];
                Datum? category = categoryMap[localizedSection];
                String originalCategoryName = category?.workCategoryName ?? localizedSection;

                return {
                  "requestedWorkItem": item['item'], // Work item name
                  "workCategoryName": originalCategoryName, // Original category name for API
                };
              },
        )
            .toList(),
        "message": "Please check the car and perform necessary repairs.",
        // "name": name,
      };

      debugPrint('SendWorkItems - Request Body: $body');

      Response response = await ApiClient.postData(
        ApiConstant.sendWorkItems,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
        ${response.body.toString()}
        ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");

        onSend();
        workItems.clear();
        selectedIndex.value = -1;

      } else {
        showCustomSnackBar(
          response.statusText ?? 'Failed to send work items',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint('Error sending work items: $e');
      showCustomSnackBar('Error sending work items: $e', isError: true);
    } finally {
      isLoading(false);
    }
  }
  void onSend() {
    CustomAlert.showInfo(
      context: Get.context!,
      message: 'thank_you....your_request_has_been_successfully_received'.tr,
      onPressed: () {
        Navigator.pop(Get.context!);
        Navigator.pop(Get.context!);
        Navigator.pop(Get.context!);
      },
    );
  }

  void addWorkItem() {
    if (workItemController.text.trim().isEmpty ||
        selectedSection.value == null) {
    showCustomSnackBar(  'Please enter work item and select section'.tr,isError: true);
      return;
    }

    final newItem = {
      'item': workItemController.text.trim(),
      'section': selectedSection.value!,
      'selected': false,
    };

    workItems.add(newItem);
    workItemController.clear();
    selectedSection.value = null;
    showCustomSnackBar( 'work_item_added_successfully'.tr,isError: false);
  }

  void selectItem(int index) {
    if (index < 0 || index >= workItems.length) return;

    for (int i = 0; i < workItems.length; i++) {
      workItems[i]['selected'] = false;
    }

    workItems[index]['selected'] = true;
    selectedIndex.value = index;

    workItems.refresh();
  }

  void editWork(int index) {
    if (index < 0 || index >= workItems.length) {
      Get.snackbar(
        'error'.tr,
        'Invalid item selected'.tr,
        backgroundColor: AppColors.red.withValues(alpha: 0.1),
        colorText: AppColors.red,
      );
      return;
    }

    final item = workItems[index];
    workName.value = item['item'];
    final sectionIndex = sections.indexOf(item['section']);
    qty.value = sectionIndex >= 0 ? sectionIndex : 0;
  }

  void updateWork(int index) {
    if (index < 0 || index >= workItems.length) return;

    // Update the work item
    workItems[index] = {
      'item': workName.value,
      'section': qty.value < sections.length
          ? sections[qty.value]
          : sections.first,
      'selected': workItems[index]['selected'],
    };

    workName.value = '';
    qty.value = 1;
    selectedIndex.value = -1;

    workItems.refresh();
    showCustomSnackBar('work_item_updated_successfully'.tr, isError: false);
  }

  void deleteWork(int index) {
    if (index < 0 || index >= workItems.length) {
    showCustomSnackBar( 'invalid_item_selected'.tr,isError: true);
      return;
    }

    CustomAlert.showYesNoDialogSimultaneous(
      context: Get.context!,
      message: "are_you_sure_delete_work_item".tr,
      onYesPressed: () {
        workItems.removeAt(index);
        selectedIndex.value = -1;
        Get.back();
        showCustomSnackBar( 'work_item_deleted_successfully'.tr,isError: false);
      },
      yesButtonText: "delete".tr,
      noButtonText: "cancel".tr,
    );
  }

  void send() {
    if (workItems.isEmpty) {
      showCustomSnackBar( 'No work items to send'.tr,isError: true);
      return;
    }

    // Send all items in the list
    sendAlltheItem();
  }
}