import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/auth_screens/login_screen/widgets/custom_button.dart';
import 'package:Senaeya/View/Screens/expenses_screen/controller/expenses_screen_controller.dart';
import 'package:Senaeya/View/Widgegts/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:Senaeya/View/Widgets/custom_dropdown.dart';
import 'package:Senaeya/View/Widgegts/custom_text_field/custom_text_field.dart';
import 'package:Senaeya/View/Widgegts/custom_vertical_divider/custom_vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../Widgegts/custom_text/custom_text.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // White status bar
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    ExpensesScreenController controller = Get.find<ExpensesScreenController>();
    final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
    final RxInt selectedMonth = RxInt(0); // Changed: 0 means no month selected
    final RxInt selectedYear = RxInt(0); // Changed: 0 means no year selected
    final RxInt selectedIndex = (-1).obs;
    void showEditDialog(ExpenseItem item, int index) {
      // Use separate controllers for edit dialog to avoid conflicts
      final editDescController = TextEditingController(text: item.description);
      final editAmountController = TextEditingController(
        text: item.amount.toString(),
      );
      final editSelectedDate = Rx<DateTime?>(item.date);

      debugPrint(
        'Edit dialog - Item ID: ${item.id}, type: ${item.id.runtimeType}',
      );
      debugPrint(
        'Edit dialog - Amount: ${item.amount}, type: ${item.amount.runtimeType}',
      );
      showDialog(
        context: context,
        builder: (context) => Directionality(
          textDirection: TextDirection.ltr,
          child: AlertDialog(
            backgroundColor: Colors.white, // Set background color
            title: CustomText(text: 'edit_expense_title'.tr),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: editDescController,
                    hintText: 'description_label'.tr,
                    height: 45.h,
                    borderRadius: 8.r,
                  ),
                  SizedBox(height: 12.h),
                  CustomTextField(
                    controller: editAmountController,
                    hintText: 'amount_label'.tr,
                    keyboardType: TextInputType.number,
                    height: 45.h,
                    borderRadius: 8.r,
                  ),
                  SizedBox(height: 12.h),
                  Obx(
                    () => CustomTextField(
                      hintText: 'select_date'.tr,
                      controller: TextEditingController(
                        text: editSelectedDate.value == null
                            ? ''
                            : intl.DateFormat(
                                'yyyy-MM-dd',
                              ).format(editSelectedDate.value!),
                      ),
                      readOnly: true,
                      height: 45.h,
                      borderRadius: 8.r,
                      suffixIcon: Container(
                        width: 18.w,
                        height: 18.w,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          AppIcon.calendar,
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      onTap: () async {
                        final picked = await showDatePicker(
                          barrierColor: const Color(0xffF4F5F7),

                          context: context,
                          initialDate: editSelectedDate.value ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: const Color(0xffF4F5F7),
                                  onPrimary: Colors.white,
                                  surface: const Color(0xffF4F5F7),
                                  onSurface: Colors.black,
                                  secondary: AppColors
                                      .primary, // Action buttons color (Cancel/OK)
                                  onSecondary: Colors
                                      .white, // Text color on action buttons
                                ),
                                iconTheme: const IconThemeData(
                                  color: AppColors
                                      .primary, // Edit/calendar icon color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors
                                        .primary, // Text button color (Cancel/OK)
                                  ),
                                ),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: child!,
                              ),
                            );
                          },
                        );
                        if (picked != null) editSelectedDate.value = picked;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redTextFiled,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      onPressed: () {
                        editDescController.dispose();
                        editAmountController.dispose();
                        Navigator.pop(context);
                      },
                      child: CustomText(
                        text: 'cancel'.tr,
                        color: AppColors.red,
                        fontSize: 14.sp,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      onPressed: () async {
                        final desc = editDescController.text.trim();
                        final amount = double.tryParse(
                          editAmountController.text.trim(),
                        );
                        final date = editSelectedDate.value;
                        if (desc.isNotEmpty && amount != null && date != null) {
                          try {
                            // Ensure id is a string
                            final String itemId = item.id.toString();
                            debugPrint(
                              'Editing expense with ID: $itemId, type: ${itemId.runtimeType}',
                            );
                            // Close dialog first
                            Navigator.pop(context);
                            // Then call API and dispose controllers
                            await controller.editExpense(
                              itemId,
                              desc,
                              amount,
                              date,
                            );
                            // Dispose controllers after API call
                            editDescController.dispose();
                            editAmountController.dispose();
                          } catch (e) {
                            debugPrint('Edit dialog error: $e');
                            showCustomSnackBar(
                              'Error editing expense: ${e.toString()}',
                            );
                            // Dispose on error too
                            editDescController.dispose();
                            editAmountController.dispose();
                          }
                        } else {
                          showCustomSnackBar('Please fill all fields'.tr,isError: true);
                        }
                      },
                      child: CustomText(
                        text: 'save'.tr,
                        color: Colors.white,
                        fontSize: 14.sp,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    void deleteSelectedExpense(int index) {
      if (index < 0) return;
      final item = controller.filteredExpenses[index];
      CustomAlert.showYesNoDialogSimultaneous(
        context: context,
        message: "are_you_sure_delete_work_item".tr,
        yesButtonText: "yes".tr,
        noButtonText: "no".tr,
        onYesPressed: () {
          controller.deleteExpense(item.id);
          selectedIndex.value = -1;
          Navigator.pop(context);
        },
        onNoPressed: () {
          Get.back();
        },
      );
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(
          title: "expenses_title".tr,
          titleColor: Colors.black,
          blackHomeIcon: true,
          //blueCloud: true,
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isInitialLoading.value) {
            return Center(
              child: Image.asset(
                AppImages.loading,
                width: 150.w,
                height: 150.w,
              ),
            );
          }
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  children: [
                    // Input fields - First row: Description
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: controller.descController,
                            textAlign: TextAlign.center,
                            hintText: "items_label".tr,
                            height: 45.h,
                          ),
                        ),
                      ],
                    ),
          
                    SizedBox(height: 10.h),
          
                    // Second row: Amount, Date, Edit, Delete buttons
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            controller: controller.amountController,
                            hintText: "amount_label".tr,
                            keyboardType: TextInputType.number,
                            height: 45.h,
                            onChanged: (val) {
                              // Optional: Add any specific onChanged behavior here
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          flex: 2,
                          child: Obx(
                            () => CustomTextField(
                              hintText: "date_label".tr,
                              controller: TextEditingController(
                                text: selectedDate.value == null
                                    ? ''
                                    : intl.DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(selectedDate.value!),
                              ),
                              readOnly: true,
                              height: 45.h,
                              suffixIcon: Container(
                                width: 18.w,
                                height: 18.w,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  AppIcon.calendar,
                                  width: 24.w,
                                  height: 24.w,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              onTap: () async {
                                final picked = await _showDatePicker(context);
                                if (picked != null) {
                                  selectedDate.value = picked;
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedIndex.value >= 0) {
                                final item = controller
                                    .filteredExpenses[selectedIndex.value];
                                showEditDialog(item, selectedIndex.value);
                              }
                            },
                            child: SvgPicture.asset(AppIcon.editIcon),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedIndex.value >= 0) {
                                deleteSelectedExpense(selectedIndex.value);
                              }
                            },
                            child: SvgPicture.asset(AppIcon.deleteIcon),
                          ),
                        ),
                      ],
                    ),
          
                    SizedBox(height: 6.h),
                    Obx(
                      () => CustomButton(
                        text: controller.isLoading.value
                            ? "Adding..."
                            : "add_button".tr,
                        width: 200.w,
                        height: 40.h,
                        backgroundColor: controller.isLoading.value
                            ? Colors.grey
                            : AppColors.primary,
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                final desc = controller.descController.text
                                    .trim();
                                final amount = double.tryParse(
                                  controller.amountController.text.trim(),
                                );
                                final date = selectedDate.value;
                                if (desc.isNotEmpty &&
                                    amount != null &&
                                    date != null) {
                                  controller.addExpense(desc, amount, date);
                                } else {
                                  showCustomSnackBar('please_fill_all_required_fields'.tr,isError: true);
                                }
                              },
                      ),
                    ),
          
                    // Add button
                    SizedBox(height: 10.h),
          
                    // Table header
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal: 8.w,
                                    ),
                                    child: CustomText(
                                      text: "date_label".tr,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      minFontSize: 10,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                CustomVerticalDivider(
                                  color: Colors.white,
                                  height: 32.h,
                                  thickness: 1.w,
                                ),
                              ],
                            ),
                          ),
          
                          Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal: 8.w,
                                    ),
                                    child: CustomText(
                                      text: "expenses_item_label".tr,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      minFontSize: 10,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
          
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                CustomVerticalDivider(
                                  color: Colors.white,
                                  height: 32.h,
                                  thickness: 1.w,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal: 8.w,
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text: "amount_table_label".tr,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        minFontSize: 10,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
          
                    // Expense entries
                    Obx(() {
                      // Use controller's expenses directly (already filtered by API if search was applied)
                      final items = controller.expenses;
          
                      return Expanded(
                        child: SizedBox(
                          height: 0.6.sw,
                          child: ListView.builder(
                            itemCount: items.length < 6
                                ? 6
                                : items.length, // Show minimum 6 rows
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index < items.length) {
                                // Show actual expense item
                                ExpenseItem item = items[index];
                                return GestureDetector(
                                  onTap: () {
                                    selectedIndex.value = index;
                                  },
                                  child: Obx(() {
                                    bool isSelected =
                                        selectedIndex.value == index;
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.grey.withValues(alpha: 0.2)
                                            : AppColors.textFiledColor,
                                        border: const Border(
                                          bottom: BorderSide(color: Colors.white),
                                        ),
                                        borderRadius:
                                            index ==
                                                (items.length < 6
                                                        ? 6
                                                        : items.length) -
                                                    1
                                            ? BorderRadius.only(
                                                bottomLeft: Radius.circular(8.r),
                                                bottomRight: Radius.circular(8.r),
                                              )
                                            : BorderRadius.zero,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 12.h,
                                                horizontal: 8.w,
                                              ),
                                              child: CustomText(
                                                text: item.date.toString().split(
                                                  ' ',
                                                )[0],
                                                fontSize: 12.sp,
                                                color: Colors.black87,
                                                fontWeight: isSelected
                                                    ? FontWeight.w500
                                                    : FontWeight.normal,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
          
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 12.h,
                                                horizontal: 8.w,
                                              ),
                                              child: CustomText(
                                                text: item.description,
                                                fontSize: 12.sp,
                                                color: Colors.black87,
                                                overflow: TextOverflow.visible,
                                                fontWeight: isSelected
                                                    ? FontWeight.w500
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
          
                                          Expanded(
                                            flex: 3,
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 12.h,
                                                      horizontal: 8.w,
                                                    ),
                                                    child: CustomText(
                                                      text: item.amount
                                                          .toStringAsFixed(2),
                                                      fontSize: 12.sp,
                                                      color: Colors.black87,
                                                      fontWeight: isSelected
                                                          ? FontWeight.w500
                                                          : FontWeight.normal,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: -4,
                                                  right: -6,
                                                  child: Transform.scale(
                                                    scale: 0.5,
                                                    child: Radio<int>(
                                                      value: index,
                                                      // ignore: deprecated_member_use
                                                      groupValue:
                                                          selectedIndex.value,
                                                      // ignore: deprecated_member_use
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          selectedIndex.value =
                                                              value;
                                                        }
                                                      },
          
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      activeColor: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              } else {
                                // Show blank row
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.textFiledColor,
                                    border: const Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                    borderRadius: index == 5
                                        ? BorderRadius.only(
                                            // Last blank row
                                            bottomLeft: Radius.circular(8.r),
                                            bottomRight: Radius.circular(8.r),
                                          )
                                        : BorderRadius.zero,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                            horizontal: 8.w,
                                          ),
                                          height:
                                              44.h, // Same height as data rows
                                          child: const SizedBox(), // Empty space
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                            horizontal: 8.w,
                                          ),
                                          height: 44.h,
                                          child: const SizedBox(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                            horizontal: 8.w,
                                          ),
                                          height: 44.h,
                                          child: const SizedBox(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    }),
                    // Month/Year filters
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => CustomDropdown<String>(
                                value: selectedMonth.value > 0
                                    ? selectedMonth.value.toString().padLeft(
                                        2,
                                        '0',
                                      )
                                    : null,
                                items: [
                                  for (int i = 1; i <= 12; i++)
                                    i.toString().padLeft(2, '0'),
                                ],
                                hint: 'month_label'.tr,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    selectedMonth.value = int.parse(value);
                                  }
                                },
                                height: 40.h,
                                borderRadius: 24.r,
                                fillColor: AppColors.textFiledColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600]!,
                                ),
                                itemStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Obx(
                              () => CustomDropdown<int>(
                                value: selectedYear.value > 0
                                    ? selectedYear.value
                                    : null, // Changed: Added condition
                                items: [
                                  for (
                                    int i = DateTime.now().year - 5;
                                    i <= DateTime.now().year + 5;
                                    i++
                                  )
                                    i,
                                ],
                                hint: 'year_label'.tr,
                                onChanged: (int? value) {
                                  selectedYear.value =
                                      value ?? 0; // Changed: Set to 0 if null
                                },
                                height: 40.h,
                                borderRadius: 24.r,
                                fillColor: AppColors.textFiledColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600]!,
                                ),
                                itemStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Container(
                            width: 64.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(24.r),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Set search values from selected dropdowns
                                controller.setSearchMonth(
                                  selectedMonth.value > 0
                                      ? selectedMonth.value
                                      : null,
                                );
                                controller.setSearchYear(
                                  selectedYear.value > 0
                                      ? selectedYear.value
                                      : null,
                                );
                                // Apply filter - call API
                                controller.applySearch();
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
          
                    SizedBox(height: 6.h),
                    // Total expenses
                    Obx(() {
                      final items = controller.expenses
                          .where(
                            (e) =>
                                (selectedMonth.value == 0 ||
                                    e.date.month == selectedMonth.value) &&
                                (selectedYear.value == 0 ||
                                    e.date.year == selectedYear.value),
                          )
                          .toList();
                      final total = items.fold<double>(
                        0,
                        (sum, e) => sum + e.amount,
                      );
                      final monthName =
                          selectedMonth.value > 0 && selectedMonth.value <= 12
                          ? selectedMonth.value.toString().padLeft(2, '0')
                          : ' ';
                      final yearName = selectedYear.value > 0
                          ? selectedYear.value.toString()
                          : ' '; // Changed: Show 'All' when 0
                      return Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.red, width: 2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  AppIcon.riyalRed,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(width: 4.w),
                                CustomText(
                                  text: total.toStringAsFixed(2),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.red,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: "total_expenses_label".tr,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                                CustomText(
                                  text:
                                      '$monthName $yearName', // Changed: Use yearName variable
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
        }),
      ),
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),

      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                iconColor: WidgetStateProperty.all(const Color(0xFF1771B7)),
              ),
            ),
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xFF1771B7),
              onPrimary: Colors.white,
              secondary: Colors.black,
              onSecondary: Colors.red,
              error: Colors.red,
              onError: Colors.red,
              surface: Color(0xFFF4F5F7),
              onSurface: Colors.black,
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: child!,
          ),
        );
      },
    );
  }
}
