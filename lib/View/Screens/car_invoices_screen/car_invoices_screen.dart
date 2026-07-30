import 'package:Senaeya/View/Screens/car_invoices_screen/controller/car_invoices_controller.dart';
import 'package:Senaeya/View/Widgegts/customer_invoice_card/customer_invoice_card.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CarInvoicesScreen extends StatelessWidget {
  const CarInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    CarInvoicesController controller = Get.find<CarInvoicesController>();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF1771B7),
        appBar: CustomAppBar(
          title: "car_invoices".tr,
          titleColor: Colors.black,
          //redCloud: true,
          centerTitle: true,
          onBack: Get.back,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 1.sh,
                maxHeight: 1.sh,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Obx(() {
                if (controller.isLoading.value && controller.invoicesList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.invoicesList.isEmpty) {
                  return Center(
                    child: Text(
                      "no_invoices_available".tr,
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.invoicesList.length + (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.invoicesList.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final invoice = controller.invoicesList[index];

                    // Determine invoice status based on paymentStatus
                    String invoiceStatus;
                    if (invoice.paymentStatus == "paid") {
                      invoiceStatus = "view_invoice".tr;
                    } else if (invoice.paymentMethod == "postpaid") {
                      invoiceStatus = "pay_invoice".tr;
                    } else {
                      invoiceStatus = "release_invoice".tr;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CustomerInvoiceCard(
                        onTapDefaultersList: ()=>controller.onTapDefaultersList(invoice.client?.id ?? '') ,
                        onTapExtendTime: ()=>controller.onTapExtendTime(invoice.car!.id!) ,
                        invoice: invoice,
                        invoiceStatus: invoiceStatus,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
