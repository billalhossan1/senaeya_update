import 'dart:async';
import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/add_spare_parts_screen/model/spare_part_model.dart';
import 'package:Senaeya/View/Screens/add_spare_parts_screen/repo/create_invoice_repo.dart';
import 'package:Senaeya/View/Widgegts/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/shared_prefe/shared_prefe.dart';

class WorkItem {
  final String code;
  final String name;
  final int qty;
  final double price;
  final bool isNew;
  bool selected;

  WorkItem({
    required this.code,
    required this.name,
    required this.qty,
    required this.price,
    required this.isNew,
    this.selected = false,
  });

  double get total => qty * price;

  WorkItem copyWith({
    String? code,
    String? name,
    int? qty,
    double? price,
    bool? isNew,
    bool? selected,
  }) {
    return WorkItem(
      code: code ?? this.code,
      name: name ?? this.name,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      isNew: isNew ?? this.isNew,
      selected: selected ?? this.selected,
    );
  }
}

class AddSparePartsController extends GetxController {
  // Form fields
  var selectedCode = ''.obs;
  var workName = ''.obs;
  var qty = 0.obs;
  var price = 0.0.obs;
  var searchQuery = ''.obs;
  var isNew = true.obs;
  var sparePartsAdded = true.obs;

  // Received data from previous screen
  String clientId = '';
  String clientCarId = '';
  List<Map<String, dynamic>> workItems = [];

  // Additional received data
  String brandName = '';
  String brandId = '';
  String modelId = '';
  String modelName = '';
  String year = '';
  String brandImage = '';
  String clientName = '';
  String clientPhone = '';

  // Saudi plate information
  String saudiPlateEnglishText = '';
  String saudiPlateArabicText = '';
  String inputEnglishPlateNumber = '';
  String inputArabicPlateNumber = '';
  String symbolImageForSaudi = '';

  // International plate information
  String internationalPlateNumber = '';

  // Lists
  var works = <WorkItem>[].obs;
  var availableCodes = <String>[
  ].obs;
  RxList<WorkItem> filteredWorks = <WorkItem>[].obs;
  dynamic costOfWorks = 0.0;

  var discount = 0.0;

  // Selection
  var selectedIndex = (-1).obs;

  // Controllers
  final codeController = TextEditingController();

  // Timer for debouncing code input
  Timer? _debounceTimer;
  RxBool isSearchingSpare = false.obs;

  // Calculations
  double get totalAmount => works.fold(0.0, (sum, item) => sum + item.total);

  @override
  void onInit() {
    super.onInit();

    // Receive data from navigation arguments
    if (Get.arguments != null) {
      clientId = Get.arguments['clientId'] ?? '';
      clientCarId = Get.arguments['clientCarId'] ?? '';
      workItems = List<Map<String, dynamic>>.from(
        Get.arguments['workItems'] ?? [],
      );
      discount = Get.arguments['discount'] ?? 0.0;

      // Receive additional car and brand information
      brandName = Get.arguments['brandName'] ?? '';
      modelId = Get.arguments['modelId'] ?? '';
      modelName = Get.arguments['modelName'] ?? '';
      year = Get.arguments['year'] ?? '';
      brandImage = Get.arguments['brandImage'] ?? '';

      // Receive client information
      clientName = Get.arguments['clientName'] ?? '';
      clientPhone = Get.arguments['clientPhone'] ?? '';

      // Receive Saudi plate information
      saudiPlateEnglishText = Get.arguments['saudiPlateEnglishText'] ?? '';
      saudiPlateArabicText = Get.arguments['saudiPlateArabicText'] ?? '';
      inputEnglishPlateNumber = Get.arguments['inputEnglishPlateNumber'] ?? '';
      inputArabicPlateNumber = Get.arguments['inputArabicPlateNumber'] ?? '';
      symbolImageForSaudi = Get.arguments['symbolImageForSaudi'] ?? '';

      // Receive International plate information
      internationalPlateNumber =
          Get.arguments['internationalPlateNumber'] ?? '';
      costOfWorks = Get.arguments['costOfWorks'] ?? 0.0;


      print("Received clientId: $clientId");
      print("Received clientCarId: $clientCarId");
      print("Received workItems: $workItems");
      print("Received discount: $discount");
      print("Received brandName: $brandName");
      print("Received modelName: $modelName");
      print("Received clientName: $clientName");
      print("Cost Of Works: $costOfWorks");
    }
    print("client id from add spare parts screen $clientId");

    // Initialize with sample data

    filteredWorks.addAll(works);
    ever(searchQuery, (_) => filterWorks());
  }

  @override
  void onClose() {
    _debounceTimer?.cancel(); // Cancel timer when controller is disposed
    codeController.dispose();
    super.onClose();
  }

  void addWork() {
    if (codeController.text.trim().isEmpty || workName.value.isEmpty||price.value<=0||qty.value<=0) {
      showCustomSnackBar('please_fill_all_required_fields'.tr, isError: true);
      return;
    }
    final newWork = WorkItem(
      code: codeController.text.trim(),
      name: workName.value,
      qty: qty.value,
      price: price.value,
      isNew: isNew.value,
    );
    works.add(newWork);
    filterWorks();
    clearForm();
    showCustomSnackBar('spare_part_added_successfully'.tr, isError: false);
    update();
  }

  void editWork(int index) {
    if (index < 0 || index >= works.length) return;
    final work = works[index];
    selectedCode.value = work.code;
    workName.value = work.name;
    qty.value = work.qty;
    price.value = work.price;
    isNew.value = work.isNew;
  }

  void updateWork(int index) {
    if (index < 0 || index >= works.length) return;
    works[index] = WorkItem(
      code: selectedCode.value,
      name: workName.value,
      qty: qty.value,
      price: price.value,
      isNew: isNew.value,
      selected: works[index].selected,
    );
    filterWorks(); // Always update filteredWorks based on current search
    clearForm();
    selectedIndex.value = -1;
    update();

    showCustomSnackBar('spare_part_updated_successfully'.tr, isError: false);
  }

  void deleteWork(int index) {
    if (index < 0 || index >= works.length) return;

    CustomAlert.showYesNoDialogSimultaneous(
      context: Get.context!,
      message: 'are_you_sure_delete_spare_part'.tr,
      onNoPressed: () {
        print("no");

       Navigator.pop(Get.context!);
      },
      onYesPressed: () {
        works.removeAt(index);
        works.refresh(); // Force UI update for main list
        filterWorks();
        filteredWorks.refresh(); // Force UI update for filtered list
        selectedIndex.value = -1;
        Navigator.pop(Get.context!);
        showCustomSnackBar(
          'spare_part_deleted_successfully'.tr,
          isError: false,
        );
      },
      yesButtonText: 'delete'.tr,

      noButtonText: 'cancel'.tr,
    );
  }

  void selectWork(int index) {
    // Deselect all in filteredWorks
    for (int i = 0; i < filteredWorks.length; i++) {
      filteredWorks[i].selected = false;
    }
    if (index >= 0 && index < filteredWorks.length) {
      filteredWorks[index].selected = true;
      // Also update the main works list selection
      int mainIndex = works.indexWhere(
        (w) =>
            w.code == filteredWorks[index].code &&
            w.name == filteredWorks[index].name,
      );
      if (mainIndex != -1) {
        for (int i = 0; i < works.length; i++) {
          works[i].selected = false;
        }
        works[mainIndex].selected = true;
      }
      selectedIndex.value = index;
    } else {
      selectedIndex.value = -1;
    }
    works.refresh();
    filteredWorks.refresh();
  }

  void filterWorks() {
    if (searchQuery.value.isEmpty) {
      filteredWorks.assignAll(works);
    } else {
      filteredWorks.assignAll(
        works
            .where(
              (work) =>
                  work.code.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ) ||
                  work.name.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
            )
            .toList(),
      );
    }
  }

  // Generate spare parts list in the required format
  List<Map<String, dynamic>> getSparePartsItems() {
    return works.map((workItem) {
      return {
        "itemName": workItem.name, // Using name as the item name
        "quantity": workItem.qty,
        "cost": workItem.price,
        "code": workItem.code,
      };
    }).toList();
  }

  /// Search for spare part by code with debouncing
  Future<void> searchSparePart({required String typingCode}) async {
    try {
      isSearchingSpare.value = true;
      String workshopId = await SharePrefsHelper.getString(
        SharedPreferenceValue.workshopId,
      );
      Response response = await CreateInvoiceRepo().searchSpareParts(code: typingCode, workshopId: workshopId);

      if (response.statusCode == 200 && response.body != null && response.body['data'] != null) {
        SparePartByCode sparePartByCode = SparePartByCode.fromJson(response.body);

        // Check if result array has data and get the first item
        if (sparePartByCode.data?.result != null &&
            sparePartByCode.data!.result!.isNotEmpty &&
            sparePartByCode.data!.result![0].title != null) {
          // Get current locale
          String currentLocale = Get.locale?.languageCode ?? 'en';
          String localizedTitle = sparePartByCode.data!.result![0].title!.getLocalizedTitle(currentLocale);

          if (localizedTitle.isNotEmpty) {
            workName.value = localizedTitle;
            showCustomSnackBar('spare_part_found'.tr, isError: false);
          } else {
            workName.value = '';
            showCustomSnackBar('spare_part_not_found'.tr, isError: true);
          }
        } else {
          workName.value = '';
          showCustomSnackBar('spare_part_not_found'.tr, isError: true);
        }
      } else {
        workName.value = '';
        showCustomSnackBar('spare_part_not_found'.tr, isError: true);
      }
    } catch (e) {
      print('Error searching spare part: $e');
      workName.value = '';
      showCustomSnackBar('error_searching_spare_part'.tr, isError: true);
    } finally {
      isSearchingSpare.value = false;
    }

  }

  // Method to navigate to next screen with spare parts data

  RxBool isLoading = false.obs;
  Future<void> submitSpareParts() async {

    List<Map<String, dynamic>> sparePartsItems = getSparePartsItems();
    print("=====================$sparePartsAdded");
    if (sparePartsAdded.value == true) {
      isLoading.value = false;

      if (sparePartsItems.isEmpty) {
        showCustomSnackBar(
          'please_add_at_least_one_spare_part'.tr,
          isError: true,
        );
        return;
      }
    }

    // You can navigate or pass this data as needed
    // Example: Get.back with result
    // Response response = await CreateInvoiceRepo().createInvoice(clientId: clientId, carId: clientCarId, workList: workItems, sparePartsList: sparePartsItems, discount: discount);
    // isLoading.value=false;
    // if(response.statusCode==200){
    //
    //   showCustomSnackBar('invoice_created_successfully'.tr,isError: false);
    //   Get.toNamed(AppRoute.invoiceSummaryScreen,arguments: {'invoiceId':response.body['data']['_id']});
    // }else{
    //   showCustomSnackBar(response.statusText,isError: true);
    // }

    ///Navigate
    Get.toNamed(
      AppRoute.invoiceSummaryScreen,
      arguments: {
        'clientId': clientId,
        'clientCarId': clientCarId,
        'workList': workItems,
        'sparePartsList': sparePartsItems,
        'discount': discount,
        'brandId': brandId,
        'brandName': brandName,
        'modelId': modelId,
        'modelName': modelName,
        'year': year,
        'brandImage': brandImage,
        'clientName': clientName,
        'clientPhone': clientPhone,
        'saudiPlateEnglishText': saudiPlateEnglishText,
        'saudiPlateArabicText': saudiPlateArabicText,
        'inputEnglishPlateNumber': inputEnglishPlateNumber,
        'inputArabicPlateNumber': inputArabicPlateNumber,
        'symbolImageForSaudi': symbolImageForSaudi,
        'internationalPlateNumber': internationalPlateNumber,
        'costOfWorks': costOfWorks,
        'costOfSpareParts': totalAmount,

      },
    );

    // Or navigate to another screen
    // Get.toNamed(AppRoute.someScreen, arguments: {
    //   'sparePartsItems': sparePartsItems,
    //   'totalAmount': totalAmount,
    // });
  }

  void clearForm() {
    selectedCode.value = '';
    codeController.clear(); // Clear the text field
    workName.value = '';
    qty.value = 1;
    price.value = 0.0;
    isNew.value = true;
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void onCodeChanged(String? value) {
    selectedCode.value = value ?? '';
  }

  void onWorkNameChanged(String value) {
    workName.value = value;
  }

  void onQtyChanged(String value) {
    qty.value = int.tryParse(value) ?? 1;
  }

  void onPriceChanged(String value) {
    price.value = double.tryParse(value) ?? 0.0;
  }

  void onCodeTextChanged(String value) {
    selectedCode.value = value;

    // Cancel previous timer if user is still typing
    _debounceTimer?.cancel();

    // Clear work name if code is empty
    if (value.trim().isEmpty) {
      workName.value = '';
      return;
    }

    // Set a new timer - API will be called after user stops typing for 800ms
    _debounceTimer = Timer(const Duration(milliseconds: 800), () {
      // Call API to search for spare part by code
      if (value.trim().isNotEmpty) {
        print('Searching spare part with code: ${value.trim()}');
        searchSparePart(typingCode: value.trim());
      }
    });
  }
}
