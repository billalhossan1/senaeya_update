import 'package:Senaeya/View/Screens/customer_invoice_screen/controller/customer_invoice_controller.dart';
import 'package:Senaeya/View/Widgegts/customer_invoice_card/customer_invoice_card.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerInvoiceScreen extends StatelessWidget {
  const CustomerInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerInvoiceController controller = Get.find<CustomerInvoiceController>();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF1771B7),
        appBar: CustomAppBar(
          title: "customer_invoices".tr,
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
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Obx(() {
                if (controller.isLoading.value && controller.invoicesList.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.invoicesList.isEmpty) {
                  return Center(
                    child: Text(
                      "no_invoices_found".tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: controller.invoicesList.length + (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.invoicesList.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final invoice = controller.invoicesList[index];
                    String invoiceStatus = "view_invoice".tr;

                    // Determine invoice status based on payment status
                    if (invoice.paymentStatus == "paid") {
                      invoiceStatus = "view_invoice".tr;
                    } else if (invoice.postPaymentDate!=null&& invoice.postPaymentDate!.toString().isNotEmpty) {
                      invoiceStatus = "pay_invoice".tr;
                    }else{
                      invoiceStatus = "release_invoice".tr;
                    }

                    return CustomerInvoiceCard(
                      onTapDefaultersList:()=> controller.onTapDefaultersList(invoice.client?.id ?? ''),
                      onTapExtendTime: () => controller.onTapExtendTime(invoice.id!),
                      invoice: invoice,
                      invoiceStatus: invoiceStatus,
                      onTapPay: () {
                        controller.payInvoice(invoiceId: invoice.id ?? '');
                      },
                      isLoading: controller.payingInvoiceId.value == invoice.id,
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
