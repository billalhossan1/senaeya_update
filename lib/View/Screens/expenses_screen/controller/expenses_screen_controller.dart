import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/expenses_screen/model/expenses_month_year_workshop.dart';
import 'package:Senaeya/View/Screens/expenses_screen/model/get_all_expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../Helper/shared_prefe/shared_prefe.dart';
import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';

class ExpenseItem {
  String id; // Changed to String to match API response
  String description;
  double amount;
  DateTime date;

  ExpenseItem({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}

class ExpensesScreenController extends GetxController {
  Rxn<GetAllExpenses> expensesList = Rxn<GetAllExpenses>();
  Rxn<ExpensesMonthYearModel> expensesMonthYearList =
      Rxn<ExpensesMonthYearModel>();
  var expenses = <ExpenseItem>[].obs;
  var searchMonth = RxnInt();
  var searchYear = RxnInt();
  final descController = TextEditingController();
  final amountController = TextEditingController();
  final selectedDate = Rx<DateTime?>(null);
  final selectedMonth = RxInt(0);
  final selectedYear = RxInt(0);
  final selectedItems = RxSet<int>();
  final searchQuery = ''.obs;
  final selectedIndex = (-1).obs;
  var isLoading = false.obs;
  var isEditLoading = false.obs;
  var isInitialLoading = true.obs;

  // Computed property for filtered expenses
  List<ExpenseItem> get filteredExpenses {
    // If search is active (month or year selected), show filtered results
    // Otherwise show all expenses
    if (searchMonth.value != null || searchYear.value != null) {
      return expenses.where((e) {
        final monthMatch =
            searchMonth.value == null || e.date.month == searchMonth.value;
        final yearMatch =
            searchYear.value == null || e.date.year == searchYear.value;
        return monthMatch && yearMatch;
      }).toList();
    }
    return expenses;
  }

  @override
  void onInit() {
    super.onInit();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    isInitialLoading.value = true;
    await getAllExpenses();
    isInitialLoading.value = false;
  }

  // Add expense with API call
  Future<void> addExpense(
    String description,
    double amount,
    DateTime date,
  ) async {
    try {
      isLoading.value = true;
      // Format date as required by API (YYYY-M-D)
      String formattedDate = DateFormat('yyyy-M-d').format(date);
      String workShopId = await SharePrefsHelper.getString(
        SharedPreferenceValue.workshopId,
      );
      Map<String, dynamic> body = {
        "providerWorkShopId": workShopId,
        "title": description,
        "amount": amount,
        "spendingDate": formattedDate,
        "description": description,
      };

      Response response = await ApiClient.postData(
        ApiConstant.expenses,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Fetch updated expenses list
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
        ${response.body.toString()}
        ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");
        await getAllExpenses();
        descController.clear();
        amountController.clear();
        selectedDate.value = null;
        showCustomSnackBar("expense_added_successfully".tr, isError: false);
      } else {
        showCustomSnackBar(response.statusText ?? 'Failed to add expense');
      }
    } catch (e) {
      showCustomSnackBar('Failed to add expense: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Get All Expenses
  Future<void> getAllExpenses() async {
    try {
      String providerWorkShopId =
          await SharePrefsHelper.getString(SharedPreferenceValue.workshopId);
      isLoading.value = true;
      Response response = await ApiClient.getData(ApiConstant.expenses,query: {'providerWorkShopId':providerWorkShopId});
      if (response.statusCode == 200) {
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
        ${response.body.toString()}
        ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");

        expensesList.value = GetAllExpenses.fromJson(response.body);
        if (expensesList.value?.data?.result != null) {
          expenses.clear();
          for (var element in expensesList.value!.data!.result!) {
            expenses.add(
              ExpenseItem(
                id: element.id ?? '', // Keep as string
                description: element.item ?? element.description ?? '',
                amount: double.tryParse(element.amount.toString()) ?? 0.0,
                date: element.spendingDate ?? DateTime.now(),
              ),
            );
          }
        }
      } else {
        showCustomSnackBar(response.statusText ?? 'Failed to get expenses');
      }
    } catch (e) {
      showCustomSnackBar('Failed to get expenses: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Edit expense
  // Edit expense
  Future<void> editExpense(
    String id,
    String description,
    double amount,
    DateTime date,
  ) async {
    try {
      isEditLoading(true);
      debugPrint('EditExpense - ID: $id, type: ${id.runtimeType}');
      debugPrint('EditExpense - Amount: $amount, type: ${amount.runtimeType}');
      debugPrint('EditExpense - Date: $date, type: ${date.runtimeType}');

      // Validate inputs
      if (id.isEmpty || description.isEmpty || amount <= 0) {
        showCustomSnackBar('Invalid input data');
        return;
      }

      // Format date as required by API (YYYY-M-D)
      String formattedDate = DateFormat('yyyy-M-d').format(date);

      // Get workshop ID with error handling
      String workShopId = '';
      try {
        workShopId = await SharePrefsHelper.getString(
          SharedPreferenceValue.workshopId,
        );
        debugPrint(
          'EditExpense - WorkshopId: $workShopId, type: ${workShopId.runtimeType}',
        );
      } catch (e) {
        debugPrint('Error getting workshop ID: $e');
        showCustomSnackBar('Error getting workshop ID');
        return;
      }

      if (workShopId.isEmpty) {
        showCustomSnackBar('Workshop ID not found');
        return;
      }

      Map<String, dynamic> body = {
        "title": description,
        "amount": amount,
        "spendingDate": formattedDate,
        "description": description,
      };

      debugPrint('EditExpense - Request Body: $body');
      debugPrint('EditExpense - Formatted Date: $formattedDate');

      Response response = await ApiClient.patchData(
        "${ApiConstant.expenses}/$id",
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
      ${response.body.toString()}
      ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");

        // Refresh the expenses list to get updated data
        await getAllExpenses();
        showCustomSnackBar("expense_edited_successfully".tr, isError: false);
      } else {
        showCustomSnackBar(response.statusText ?? 'Failed to edit expense');
      }
    } catch (e, stackTrace) {
      debugPrint('EditExpense Error: $e');
      debugPrint('EditExpense StackTrace: $stackTrace');
      showCustomSnackBar('Failed to edit expense: ${e.toString()}');
    } finally {
      isEditLoading(false);
    }
  }

  // Delete expense
  Future<void> deleteExpense(String id) async {
    try {
      isLoading.value = true;
      // Get workshop ID with error handling
      String workShopId = '';
      try {
        workShopId = await SharePrefsHelper.getString(
          SharedPreferenceValue.workshopId,
        );
        debugPrint(
          'EditExpense - WorkshopId: $workShopId, type: ${workShopId.runtimeType}',
        );
      } catch (e) {
        debugPrint('Error getting workshop ID: $e');
        showCustomSnackBar('Error getting workshop ID');
        return;
      }

      Map<String, dynamic> body = {"providerWorkShopId": workShopId};

      Response response = await ApiClient.deleteData(
        "${ApiConstant.expenses}/$id",
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Remove from local list
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
        ${response.body.toString()}
        ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");
        expenses.removeWhere((e) => e.id == id);
        showCustomSnackBar("expense_deleted_successfully".tr, isError: false);
      } else {
        showCustomSnackBar(response.statusText ?? 'Failed to delete expense');
      }
    } catch (e) {
      showCustomSnackBar('Failed to delete expense: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getExpensesMonthYear() async {
    try {
      isLoading.value = true;
      Response response = await ApiClient.getData(
        "${ApiConstant.expensesMonth}${searchMonth.value}&year=${searchYear.value}",
      );
      if (response.statusCode == 200) {
        debugPrint("""✅✅✅✅✅✅✅✅✅✅✅✅✅
        ${response.body.toString()}
        ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅""");

        expensesMonthYearList.value = ExpensesMonthYearModel.fromJson(
          response.body,
        );

        // Update expenses list with filtered results
        if (expensesMonthYearList.value?.data?.result != null) {
          expenses.clear();
          for (var element in expensesMonthYearList.value!.data!.result!) {
            expenses.add(
              ExpenseItem(
                id: element.id ?? '',
                description: element.item ?? element.description ?? '',
                amount: double.tryParse(element.amount.toString()) ?? 0.0,
                date: element.spendingDate ?? DateTime.now(),
              ),
            );
          }
        }
        showCustomSnackBar("expenses_filtered_successfully".tr, isError: false);
      } else {
        showCustomSnackBar(response.statusText ?? 'Failed to get expenses');
      }
    } catch (e) {
      showCustomSnackBar('Failed to get expenses: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void setSearchMonth(int? month) {
    searchMonth.value = month;
  }

  void setSearchYear(int? year) {
    searchYear.value = year;
  }

  void clearSearch() {
    searchMonth.value = null;
    searchYear.value = null;
    getAllExpenses(); // Reload all expenses when clearing search
  }

  Future<void> applySearch() async {
    if (searchMonth.value != null || searchYear.value != null) {
      await getExpensesMonthYear();
    } else {
      showCustomSnackBar('Please select month or year to search'.tr);
    }
  }
}
