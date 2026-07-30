import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:Senaeya/View/Screens/previous_invoices_screen/controller/previous_invoices_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Utils/AppImg/app_img.dart';
import '../../Widgegts/customer_invoice_card/customer_invoice_card.dart';

class PreviousInvoicesScreen extends StatelessWidget {
  const PreviousInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    final controller = Get.find<PreviousInvoicesController>();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(
          title: "previous_invoices_title".tr,
          titleColor: Colors.black,
          centerTitle: true,
          blackHomeIcon: true,
          //blueCloud: true,
        ),
        body: Column(
          children: [
            // Custom TabBar with gaps and equal sizes
            Container(
              padding: EdgeInsets.only(top: 8.r, right: 16.w, left: 16.w),
              child: TabBar(
                controller: controller.tabController,
                dividerColor: Colors.transparent,

                // Gap between tabs
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 2.h,
                ),

                // Hide default indicator
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,

                indicatorWeight: 4.w,

                // Disable default colors
                labelColor: Colors.transparent,
                unselectedLabelColor: Colors.white,

                tabs: List.generate(3, (index) {
                  final tabData = [
                    {"title": "tab_saved".tr},
                    {"title": "tab_postpaid".tr},
                    {"title": "tab_completed".tr},
                  ];
                  return Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        height: 40.h,
                        alignment: Alignment.center,
                        child: CustomText(
                          text: tabData[index]["title"] as String,
                          color: index == 1
                              ? const Color(0xFFFF9900)
                              : index == 0
                              ? AppColors.red
                              : const Color(0xFF11C84E),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // TabBarView with dynamic border radius
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.3,
                  right: 15.3,
                  bottom: 16,
                ),
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: controller.selectedTabIndex.value == 0
                            ? Radius.zero
                            : Radius.circular(8.r),
                        topRight: controller.selectedTabIndex.value == 2
                            ? Radius.zero
                            : Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r),
                        bottomRight: Radius.circular(8.r),
                      ),
                    ),
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        // Saved tab content
                        _buildSavedTab(controller),
                        // Postpaid tab content
                        _buildPostpaidTab(controller),
                        // Completed tab content
                        _buildCompletedTab(controller),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Saved Invoices Tab
  Widget _buildSavedTab(PreviousInvoicesController controller) {
    return Obx(() {
      if (controller.savedIsLoading.value && controller.savedInvoicesList.isEmpty) {
        return Center(
          child: Image.asset(
            AppImages.loading,
            width: 150.w,
            height: 150.w,
          ),
        );
      }

      if (controller.savedInvoicesList.isEmpty) {
        return Center(
          child: Text(
            "no_invoices_available".tr,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
        );
      }

      return ListView.builder(
        controller: controller.savedScrollController,
        itemCount: controller.savedInvoicesList.length + (controller.savedIsLoading.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.savedInvoicesList.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final invoice = controller.savedInvoicesList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child:Obx(()=> CustomerInvoiceCard(
              onTapDefaultersList: () {
                controller.onTapDefaultersList(invoice.client?.id ?? '');
              },
              onTapPay: (){
                controller.payInvoice(invoiceId:invoice.id??'');
              },
              onTapExtendTime: () {
                controller.onTapExtendTime(invoice.id ?? '');
              },
              invoiceStatus:invoice.paymentMethod!=null? "release_invoice".tr:"set_payment".tr,
              invoice: invoice,
              isLoading: controller.payingInvoiceId.value == invoice.id,
            ),)
          );
        },
      );
    });
  }

  // Postpaid Invoices Tab
  Widget _buildPostpaidTab(PreviousInvoicesController controller) {
    return Obx(() {
      if (controller.postPaidIsLoading.value && controller.postPaidInvoicesList.isEmpty) {
        return Center(
          child: Image.asset(
            AppImages.loading,
            width: 150.w,
            height: 150.w,
          ),
        );
      }

      if (controller.postPaidInvoicesList.isEmpty) {
        return Center(
          child: Text(
            "no_invoices_available".tr,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
        );
      }

      return ListView.builder(
        controller: controller.postPaidScrollController,
        itemCount: controller.postPaidInvoicesList.length + (controller.postPaidIsLoading.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.postPaidInvoicesList.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final invoice = controller.postPaidInvoicesList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Obx(() => CustomerInvoiceCard(
              onTapDefaultersList: () {
                controller.onTapDefaultersList(invoice.client?.id ?? '');
              },
              onTapExtendTime: () {
                controller.onTapExtendTime(invoice.id ?? '');
              },
              onTapPay: (){
                controller.payInvoice(invoiceId:invoice.id??'');
              },
              invoiceStatus: "pay_invoice".tr,
              invoice: invoice,
              isLoading: controller.payingInvoiceId.value == invoice.id,
            )),
          );
        },
      );
    });
  }

  // Completed Invoices Tab
  Widget _buildCompletedTab(PreviousInvoicesController controller) {
    return Obx(() {
      if (controller.completeIsLoading.value && controller.completeInvoicesList.isEmpty) {
        return Center(
          child: Image.asset(
            AppImages.loading,
            width: 150.w,
            height: 150.w,
          ),
        );
      }

      if (controller.completeInvoicesList.isEmpty) {
        return Center(
          child: Text(
            "no_invoices_available".tr,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
        );
      }

      return ListView.builder(
        controller: controller.completeScrollController,
        itemCount: controller.completeInvoicesList.length + (controller.completeIsLoading.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.completeInvoicesList.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final invoice = controller.completeInvoicesList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: CustomerInvoiceCard(
              invoiceStatus: "view_invoice".tr,
              invoice: invoice,
            ),
          );
        },
      );
    });
  }
}
