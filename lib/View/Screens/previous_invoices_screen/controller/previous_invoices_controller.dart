import 'package:Senaeya/Service/api_client.dart';
import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/previous_invoices_screen/repo/previous_invoices_repo.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../Widgegts/custom_alert_dialog/custom_alert_dialog.dart';
import '../model/previous_invoices_model.dart';

class PreviousInvoicesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // Selected tab index observable
  var selectedTabIndex = 0.obs;

  // Loading states for each tab
  var isSavedLoading = false.obs;
  var isPostpaidLoading = false.obs;
  var isCompletedLoading = false.obs;
  var isDefaultList = false.obs;
  var isExtraTimeer = false.obs;
  var payingInvoiceId = ''.obs; // Track which specific invoice is being paid

  // Data lists for each tab
  var savedInvoices = <Map<String, dynamic>>[].obs;
  var postpaidInvoices = <Map<String, dynamic>>[].obs;
  var completedInvoices = <Map<String, dynamic>>[].obs;

  RxBool savedIsLoading = false.obs;
  RxBool postPaidIsLoading = false.obs;
  RxBool completeIsLoading = false.obs;
  ScrollController savedScrollController = ScrollController();
  ScrollController postPaidScrollController = ScrollController();
  ScrollController completeScrollController = ScrollController();
  int savedPage = 1;
  int postPaidPage = 1;
  int completePage = 1;
  int savedTotal = 0;
  int postPaidTotal = 0;
  int completeTotal = 0;

  @override
  void onInit() {
    super.onInit();

    // Initialize TabController with 3 tabs
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);

    // Listen to tab changes
    tabController.addListener(_handleTabChange);
    savedScrollController.addListener(_savedListener);
    postPaidScrollController.addListener(_postListener);
    completeScrollController.addListener(_completeListener);

    // Load initial data
    getSavedInvoices();
  }

  void _savedListener() {
    if (savedScrollController.position.pixels ==
        savedScrollController.position.maxScrollExtent) {
      if (savedPage < savedTotal) {
        savedPage++;
        getSavedInvoices(page: savedPage);
      }
    }
  }

  void _postListener() {
    if (postPaidScrollController.position.pixels ==
        postPaidScrollController.position.maxScrollExtent) {
      if (postPaidPage < postPaidTotal) {
        postPaidPage++;
        getPostPaidInvoices(page: postPaidPage);
      }
    }
  }

  void _completeListener() {
    if (completeScrollController.position.pixels ==
        completeScrollController.position.maxScrollExtent) {
      if (completePage < completeTotal) {
        completePage++;
        getCompleteInvoices(page: completePage);
      }
    }
  }

  RxList<InvoiceModel> savedInvoicesList = <InvoiceModel>[].obs;
  RxList<InvoiceModel> postPaidInvoicesList = <InvoiceModel>[].obs;
  RxList<InvoiceModel> completeInvoicesList = <InvoiceModel>[].obs;

  /// Fetch invoices methods

  Future<void> getSavedInvoices({int page = 1}) async {
    savedIsLoading.value = true;
    Response response = await PreviousInvoicesRepo().getInvoices(
      queryParam: 'unpaid&paymentMethod[ne]=postpaid',
      paramKey: 'paymentStatus',
      page: page,
    );
    savedIsLoading.value = false;
    if (response.statusCode == 200) {
      PreviousInvoicesResponse previousInvoicesResponse =
          PreviousInvoicesResponse.fromJson(response.body);
      savedInvoicesList.addAll(
        previousInvoicesResponse.data?.invoicesList ?? [],
      );
      savedTotal = previousInvoicesResponse.data?.meta?.total ?? 0;
    } else {
      print("Error fetching saved invoices: ${response.statusText}");
    }
  }

  Future<void> getPostPaidInvoices({int page = 1}) async {
    postPaidIsLoading.value = true;
    Response response = await PreviousInvoicesRepo().getInvoices(
      queryParam: 'postpaid&paymentStatus[ne]=paid',
      paramKey: 'paymentMethod',
      page: page,
    );
    postPaidIsLoading.value = false;
    if (response.statusCode == 200) {
      PreviousInvoicesResponse previousInvoicesResponse =
          PreviousInvoicesResponse.fromJson(response.body);
      postPaidInvoicesList.addAll(
        previousInvoicesResponse.data?.invoicesList ?? [],
      );
      postPaidTotal = previousInvoicesResponse.data?.meta?.total ?? 0;
    } else {
      print("Error fetching postpaid invoices: ${response.statusText}");
    }
  }

  Future<void> getCompleteInvoices({int page = 1}) async {
    completeIsLoading.value = true;
    Response response = await PreviousInvoicesRepo().getInvoices(
      queryParam: 'paid',
      paramKey: 'paymentStatus',
      page: page,
    );
    completeIsLoading.value = false;
    if (response.statusCode == 200) {
      PreviousInvoicesResponse previousInvoicesResponse =
          PreviousInvoicesResponse.fromJson(response.body);
      completeInvoicesList.addAll(
        previousInvoicesResponse.data?.invoicesList ?? [],
      );
      completeTotal = previousInvoicesResponse.data?.meta?.total ?? 0;
    }
  }

  ///Warning button actions

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

  ///onTap Pay Invoice
  Future<void> payInvoice({required String invoiceId}) async {
    try {
      payingInvoiceId.value = invoiceId; // Track the invoice being paid
      Response response = await PreviousInvoicesRepo().payInvoice(
        invoiceId: invoiceId, paymentMethod: 'postpaid',
      );
      if (response.statusCode == 200) {
        showCustomSnackBar("Invoice paid successfully", isError: false);
        refreshCurrentTab();
      } else {
        showCustomSnackBar("Failed to pay invoice: ${response.statusText}");
      }
    } catch (e) {
      showCustomSnackBar("Error paying invoice: ${e.toString()}");
    } finally {
      payingInvoiceId.value = ''; // Clear the tracker
    }
  }

  ///=================== Tab Handling ===================

  // Handle tab change
  void _handleTabChange() {
    if (!tabController.indexIsChanging) {
      selectedTabIndex.value = tabController.index;
      update(); // Update UI to reflect tab changes

      // Load data based on selected tab
      switch (tabController.index) {
        case 0:
          print('Saved tab selected');
          if (savedInvoicesList.isEmpty) {
            getSavedInvoices();
          }
          break;
        case 1:
          print('Postpaid tab selected');
          if (postPaidInvoicesList.isEmpty) {
            getPostPaidInvoices();
          }
          break;
        case 2:
          print('Completed tab selected');
          if (completeInvoicesList.isEmpty) {
            getCompleteInvoices();
          }
          break;
      }
    }
  }

  // Method to programmatically change tab
  void changeTab(int index) {
    if (index >= 0 && index < 3) {
      tabController.animateTo(index);
      selectedTabIndex.value = index;
    }
  }

  // Data loading methods
  void loadSavedInvoices() async {
    try {
      isSavedLoading.value = true;
      print('Loading saved invoices...');

      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));

      // Mock data - replace with actual API call
      savedInvoices.value = List.generate(
        5,
        (index) => {
          'id': 'SAV${index + 1}',
          'title': 'Saved Invoice ${index + 1}',
          'amount': '\$${(index + 1) * 100}',
          'date': '2024-0${(index % 9) + 1}-15',
          'status': 'saved',
        },
      );
    } catch (e) {
      print('Error loading saved invoices: $e');
    } finally {
      isSavedLoading.value = false;
    }
  }

  void loadPostpaidInvoices() async {
    try {
      isPostpaidLoading.value = true;
      print('Loading postpaid invoices...');

      await Future.delayed(Duration(seconds: 2));

      postpaidInvoices.value = List.generate(
        7,
        (index) => {
          'id': 'POST${index + 1}',
          'title': 'Postpaid Invoice ${index + 1}',
          'amount': '\$${(index + 1) * 150}',
          'date': '2024-0${(index % 9) + 1}-20',
          'status': 'postpaid',
        },
      );
    } catch (e) {
      print('Error loading postpaid invoices: $e');
    } finally {
      isPostpaidLoading.value = false;
    }
  }

  void loadCompletedInvoices() async {
    try {
      isCompletedLoading.value = true;
      print('Loading completed invoices...');

      await Future.delayed(Duration(seconds: 2));

      completedInvoices.value = List.generate(
        3,
        (index) => {
          'id': 'COMP${index + 1}',
          'title': 'Completed Invoice ${index + 1}',
          'amount': '\$${(index + 1) * 200}',
          'date': '2024-0${(index % 9) + 1}-25',
          'status': 'completed',
        },
      );
    } catch (e) {
      print('Error loading completed invoices: $e');
    } finally {
      isCompletedLoading.value = false;
    }
  }

  // Get current tab's loading state
  bool get isCurrentTabLoading {
    switch (selectedTabIndex.value) {
      case 0:
        return isSavedLoading.value;
      case 1:
        return isPostpaidLoading.value;
      case 2:
        return isCompletedLoading.value;
      default:
        return false;
    }
  }

  // Get current tab's data
  List<Map<String, dynamic>> get currentTabData {
    switch (selectedTabIndex.value) {
      case 0:
        return savedInvoices;
      case 1:
        return postpaidInvoices;
      case 2:
        return completedInvoices;
      default:
        return [];
    }
  }

  // Refresh current tab data
  void refreshCurrentTab() {
    switch (selectedTabIndex.value) {
      case 0:
        savedInvoicesList.clear();
        savedPage = 1;
        getSavedInvoices();
        break;
      case 1:
        postPaidInvoicesList.clear();
        postPaidPage = 1;
        getPostPaidInvoices();
        break;
      case 2:
        completeInvoicesList.clear();
        completePage = 1;
        getCompleteInvoices();
        break;
    }
  }

  @override
  void onClose() {
    // Dispose TabController when controller is destroyed
    tabController.removeListener(_handleTabChange);
    tabController.dispose();
    savedScrollController.removeListener(_savedListener);
    savedScrollController.dispose();
    postPaidScrollController.removeListener(_postListener);
    postPaidScrollController.dispose();
    completeScrollController.removeListener(_completeListener);
    completeScrollController.dispose();
    super.onClose();
  }
}


