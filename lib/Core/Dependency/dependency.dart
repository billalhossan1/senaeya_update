import 'package:Senaeya/View/Screens/add_customer_screen/controller/add_customer_screen_controller.dart';
import 'package:Senaeya/View/Screens/car_invoices_screen/controller/car_invoices_controller.dart';
import 'package:Senaeya/View/Screens/invoice_screen/controller/invoice_screen_controller.dart';
import 'package:Senaeya/View/Screens/invoice_summary_screen/controller/invoice_summary_controller.dart';
import 'package:Senaeya/View/Screens/nav_screen/controller/navigation_controller.dart';
import 'package:Senaeya/View/Screens/previous_invoices_screen/controller/previous_invoices_controller.dart';
import 'package:Senaeya/View/Screens/profile_screen/controller/profile_screen_controller.dart';
import 'package:Senaeya/View/Screens/subscription_screen/controller/subscription_screen_controller.dart';
import 'package:get/get.dart';
import 'package:Senaeya/View/Screens/home_screen/controller/home_controller.dart';
import '../../View/Screens/add_works_screen/controller/add_works_controller.dart';
import '../../View/Screens/customer_invoice_screen/controller/customer_invoice_controller.dart';
import '../../View/Screens/customers_screen/controller/customers_screen_controller.dart';
import '../../View/Screens/edit_workshop_screen/controller/edit_workshop_controller.dart';
import '../../View/Screens/expenses_screen/controller/expenses_screen_controller.dart';
import '../../View/Screens/menu/about_us/controller/about_us_controller.dart';
import '../../View/Screens/menu/contact_us_screen/controller/contact_us_controller.dart';
import '../../View/Screens/menu/terms_and_condition/controller/terms_and_condition_controller.dart';
import '../../View/Screens/notification_screen/controller/notification_controller.dart';
import '../../View/Screens/report_screen/controller/report_screen_controller.dart';
import '../../View/Screens/splash_screen/controller/splash_screen_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///================ Auth controller =================
// Get.put(HomeController());
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SplashScreenController(), fenix: true);
    Get.lazyPut(() => NavigationController(), fenix: true);
    Get.lazyPut(() => AddCustomerScreenController(), fenix: true);
    Get.lazyPut(() => CustomersScreenController(), fenix: true);
    Get.lazyPut(() => ExpensesScreenController(), fenix: true);
    Get.lazyPut(() => EditWorkshopController(), fenix: true);
    // Get.lazyPut(() => CustomerCarDataController(), fenix: true);
    Get.lazyPut(() => TermsAndConditionController(), fenix: true);
    Get.lazyPut(() => AboutUsController(), fenix: true);
    Get.lazyPut(() => ReportScreenController(), fenix: true);
    Get.lazyPut(() => ContactUsController(), fenix: true);
    Get.lazyPut(() => CarInvoicesController(), fenix: true);
    Get.lazyPut(() => AddWorksController(), fenix: true);
    Get.lazyPut(() => InvoiceSummaryController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => SubscriptionScreenController(), fenix: true);
    Get.lazyPut(() => CustomerInvoiceController(), fenix: true);
    Get.lazyPut(() => ProfileScreenController(), fenix: true);
    Get.lazyPut(() => PreviousInvoicesController(), fenix: true);
    Get.lazyPut(() => InvoiceScreenController(), fenix: true);
  }
}
