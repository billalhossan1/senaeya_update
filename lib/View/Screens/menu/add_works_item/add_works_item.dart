import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Screens/auth_screens/login_screen/widgets/custom_button.dart';
import 'package:Senaeya/View/Widgegts/custom_text_field/custom_text_field.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:Senaeya/View/Widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Widgegts/custom_text/custom_text.dart';
import 'controller/add_works_item_controller.dart';

class AddWorksItem extends StatelessWidget {
  const AddWorksItem({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return GetBuilder<AddWorksItemController>(
      init: AddWorksItemController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color(0xFF0C5CA8),
            appBar: CustomAppBar(
              title: "Add Works Items".tr,
              titleColor: Colors.black,
              //blueCloud: true,
              blackHomeIcon: true,
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'New works item'.tr,
                            textAlign: TextAlign.center,
                            controller: controller.workItemController,
                          ),
              
                          SizedBox(height: 8.h),
                          // Section dropdown with edit/delete
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                      () => controller.isLoading.value
                                      ? Container(
                                    height: 46.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(
                                        24.0.r,
                                      ),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  )
                                      : CustomDropdown<String>(
                                    value: controller.selectedSection.value,
                                    items: controller.sections,
                                    hint: 'Sections'.tr,
                                    onChanged: (value) {
                                      controller.selectedSection.value =
                                          value;
                                    },
                                    height: 46.h,
                                    borderRadius: 24.0.r,
                                    fillColor: const Color(0xFFF7F7F7),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    itemStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: () {
                                  if (controller.selectedIndex.value >= 0) {
                                    _showEditDialog(context, controller);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(AppIcon.editIcon),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.selectedIndex.value >= 0) {
                                    controller.deleteWork(
                                      controller.selectedIndex.value,
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(AppIcon.deleteIcon),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          // Add button
                          CustomButton(
                            text: "Add".tr,
                            onPressed: () => controller.addWorkItem(),
                            width: 250.w,
                          ),
                          SizedBox(height: 12.h),
                          // Table header
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1771B7),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6, // Increased flex for Work Item
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    child: Center(
                                      child: CustomText(
                                        text: 'New Work Items'.tr,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                // Divider between Work Item and Section
                                Container(
                                  width: 1,
                                  height: 32.h,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: CustomText(
                                      text: 'Sections'.tr,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Table rows with ListView.builder in a fixed height box
                          Obx(
                                () => Expanded(
                              child: ListView.builder(
                                itemCount: controller.workItems.length < 8
                                    ? 8
                                    : controller.workItems.length,
                                itemBuilder: (context, index) {
                                  if (index < controller.workItems.length) {
                                    final item = controller.workItems[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: item['selected'] == true
                                            ? Colors.blue.withAlpha(25)
                                            : AppColors.textFiledColor,
                                        border: const Border(
                                          bottom: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () => controller.selectItem(index),
                                        child: Stack(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex:
                                                  5, // Increased flex for Work Item
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 12.h,
                                                      horizontal: 8.w,
                                                    ),
                                                    child: CustomText(
                                                      text: item['item'],
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
              
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: CustomText(
                                                      text: item['section'],
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              top:
                                              -4, // Changed from -14.h to 0 to prevent clipping
                                              right:
                                              -5, // Changed from -6.w to 0 to prevent clipping
                                              child: Transform.scale(
                                                scale: 0.5,
                                                child: Radio<int>(
                                                  value: index,
                                                  groupValue:
                                                  item['selected'] == true
                                                      ? index
                                                      : -1,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      controller.selectItem(
                                                        index,
                                                      );
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
                                    );
                                  } else {
                                    return Container(
                                      height: 40.h,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF7F7F7),
                                        border: Border(
                                          bottom: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Obx(
                                () => CustomButton(
                              text: controller.isLoading.value
                                  ? "Sending...".tr
                                  : "send".tr,
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                controller.send();
                              },
                              backgroundColor: controller.isLoading.value
                                  ? Colors.grey
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(
      BuildContext context,
      AddWorksItemController controller,
      ) {
    if (controller.selectedIndex.value < 0) return;

    final index = controller.selectedIndex.value;
    controller.editWork(index);

    final itemController = TextEditingController(
      text: controller.workName.value,
    );
    String selectedSectionForEdit =
    controller.qty.value < controller.sections.length
        ? controller.sections[controller.qty.value]
        : controller.sections.first;

    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: CustomText(
              text: 'Edit Work Item'.tr,
              fontWeight: FontWeight.bold,
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: itemController,
                      decoration: InputDecoration(
                        labelText: 'Work Item'.tr,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return DropdownButtonFormField<String>(
                          value: selectedSectionForEdit,
                          decoration: InputDecoration(
                            labelText: 'Sections'.tr,
                            border: OutlineInputBorder(),
                          ),
                          items: controller.sections.map((section) {
                            return DropdownMenuItem<String>(
                              value: section,
                              child: CustomText(text: section),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedSectionForEdit = value;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
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
                      onPressed: () => Navigator.of(context).pop(),
                      child: CustomText(
                        text: 'cancel'.tr,
                        color: AppColors.red,
                        fontSize: 14.sp,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      onPressed: () {
                        // Update controller values
                        controller.workName.value = itemController.text.trim();
                        controller.qty.value = controller.sections.indexOf(
                          selectedSectionForEdit,
                        );
                        controller.updateWork(index);
                        Navigator.of(context).pop();
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
        );
      },
    );
  }
}