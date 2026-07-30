import 'package:Senaeya/View/Screens/add_customer_screen/add_customer_screen.dart';
import 'package:Senaeya/View/Screens/add_customer_screen/vin_scanner_screen.dart';
import 'package:Senaeya/View/Screens/add_spare_parts_screen/add_spare_parts_screen.dart';
import 'package:Senaeya/View/Screens/auth_screens/forgot_screen/forgot_screen.dart';
import 'package:Senaeya/View/Screens/auth_screens/otp_verification_screen/otp_verification_screen.dart';
import 'package:Senaeya/View/Screens/auth_screens/reset_password_screen/reset_password_screen.dart';
import 'package:Senaeya/View/Screens/auth_screens/select_language_screen/select_language_screen.dart';
import 'package:Senaeya/View/Screens/auth_screens/signup_screen/signup_screen.dart';
import 'package:Senaeya/View/Screens/auth_screens/signup_worshop/signup_workshop.dart';
import 'package:Senaeya/View/Screens/car_invoices_screen/car_invoices_screen.dart';
import 'package:Senaeya/View/Screens/invoice_screen/invoice_screen.dart';
import 'package:Senaeya/View/Screens/menu/about_us/about_us_screen.dart';
import 'package:Senaeya/View/Screens/menu/app_explain_screen/app_explain_screen.dart';
import 'package:Senaeya/View/Screens/menu/contact_us_screen/contact_us_screen.dart';
import 'package:Senaeya/View/Screens/menu/terms_and_condition/terms_and_condition_screen.dart';
import 'package:Senaeya/View/Screens/profile_screen/profile_screen.dart';
import 'package:Senaeya/View/Screens/report_screen/report_screen.dart';
import 'package:get/get.dart';
import '../../View/Screens/add_works_screen/add_works_screen.dart';
import '../../View/Screens/auth_screens/login_screen/login_screen.dart';
import '../../View/Screens/customer_cars_screen/cars_screen.dart';
import '../../View/Screens/customer_invoice_screen/customer_invoice_screen.dart';
import '../../View/Screens/customers_screen/customers_screen.dart';
import '../../View/Screens/edit_profile_screen/edit_profile_screen.dart';
import '../../View/Screens/edit_workshop_screen/edit_workshop_screen.dart';
import '../../View/Screens/expenses_screen/expenses_screen.dart';
import '../../View/Screens/invoice_summary_screen/invoice_summary_screen.dart';
import '../../View/Screens/menu/add_works_item/add_works_item.dart';
import '../../View/Screens/nav_screen/navigation_screen.dart';
import '../../View/Screens/notification_screen/notification_screen.dart';
import '../../View/Screens/pdf_download_screen/pdf_download_screen.dart';
import '../../View/Screens/previous_invoices_screen/previous_invoices_screen.dart';
import '../../View/Screens/splash_screen/screen/splash_screen.dart';
import '../../View/Screens/subscription_screen/subscription_screen.dart';
import '../../View/Screens/types_of_car_screen/types_of_car_screen.dart';
import '../../View/Screens/work_shop_work_screen/work_shop_work_screen.dart';

class AppRoute {
  ///==================== Initial Routes ====================
  static const String splashScreen = "/splash_screen";
  static const String navScreen = "/navScreen";
  static const String homeScreen = "/homeScreen";
  static const String loginScreen = "/loginScreen";
  static const String forgetScreen = "/forgetScreen";
  static const String otpVerificationScreen = "/otpVerificationScreen";
  static const String resetPasswordScreen = "/resetPasswordScreen";
  static const String signupScreen = "/signupScreen";
  static const String selectLanguageScreen = "/selectLanguageScreen";
  static const String signupWorkshopScreen = "/signupWorkshopScreen";
  static const String contactUsScreen = "/contactUsScreen";
  static const String termsAndCondition = "/termsAndCondition";
  static const String aboutUsScreen = "/aboutUsScreen";
  static const String addCustomerScreen = "/addCustomerScreen";
  static const String vinScannerScreen = "/vinScannerScreen";
  static const String addWorksScreen = "/addWorksScreen";
  static const String addSparePartScreen = "/addSparePartScreen";
  static const String invoiceSummaryScreen = "/invoiceSummaryScreen";
  static const String customersScreen = "/customersScreen";
  static const String carsScreen = "/carsScreen";
  static const String customerInvoiceScreen = "/customerInvoiceScreen";
  static const String previousInvoicesScreen = "/previousInvoicesScreen";
  static const String reportScreen = "/reportScreen";
  static const String expensesScreen = "/expensesScreen";
  static const String workShopWorkScreen = "/workShopWorkScreen";
  static const String carsCardScreen = "/carsCardScreen";
  static const String subscriptionScreen = "/SubscriptionScreen";
  static const String editWorkshopScreen = "/EditWorkshopScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String addWorksItem = "/AddWorksItem";
  static const String notificationScreen = "/notificationScreen";
  static const String customerCarDataScreen = "/customerCarDataScreen";
  static const String invoiceScreen = "/invoiceScreen";
  static const String profileScreen = "/profileScreen";
  static const String carInvoiceScreen = "/carInvoiceScreen";
  static const String pdfDownLoadSceen = "/PdfDownloadScreen";
  static const String appExplainScreen = "/appExplainScreen";

  static List<GetPage> routes = [
    ///==================== Initial Routes ====================
    GetPage(name: splashScreen, page: () => const SplashScreen()),

    ///==================== Auth Routes ====================
    GetPage(name: navScreen, page: () => const NavigationScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: forgetScreen, page: () => const ForgotScreen()),
    GetPage(name: otpVerificationScreen, page: () => const OtpVerificationScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: signupScreen, page: () =>  const SignupScreen()),
    GetPage(name: signupWorkshopScreen, page: () =>  const SignupWorkshopScreen()),
    GetPage(name: selectLanguageScreen, page: () =>  const SelectLanguageScreen()),

    ///==================== Home Routes ====================

    GetPage(name: addCustomerScreen, page: () =>  const AddCustomerScreen()),
    GetPage(name: vinScannerScreen, page: () =>  const VinScannerScreen()),
    GetPage(name: addWorksScreen, page: () =>  const AddWorksScreen()),
    GetPage(name: addSparePartScreen, page: () =>  const AddSparePartsScreen()),
    GetPage(name: invoiceSummaryScreen, page: () =>  const InvoiceSummaryScreen()),
    GetPage(name: customersScreen, page: () =>  const CustomersScreen()),
    GetPage(name: carsScreen, page: () =>  const CarsScreen()),
    GetPage(name: customerInvoiceScreen, page: () =>  const CustomerInvoiceScreen()),
    GetPage(name: previousInvoicesScreen, page: () =>  const PreviousInvoicesScreen()),
    GetPage(name: reportScreen, page: () =>  const ReportScreen()),
    GetPage(name: expensesScreen, page: () =>  const ExpensesScreen()),
    GetPage(name: notificationScreen, page: () =>  const NotificationScreen()),
    GetPage(name: termsAndCondition, page: () =>  const TermsAndConditionScreen()),
    GetPage(name: aboutUsScreen, page: () => const AboutUsScreen()),
    // GetPage(name: customerCarDataScreen, page: () =>  const CustomerCarDataScreen()),
    GetPage(name: invoiceScreen, page: () =>  const InvoiceScreen()),
    GetPage(name: carInvoiceScreen, page: () =>  const CarInvoicesScreen()),
    GetPage(name: pdfDownLoadSceen, page: () =>  const PdfDownloadScreen()),


    ///==================== Menu Routes ====================
    GetPage(name: contactUsScreen, page: () =>  const ContactUsScreen()),
    GetPage(name: addWorksItem, page: () =>  const AddWorksItem()),



    ///==================== Profile Routes ====================
    GetPage(name: subscriptionScreen, page: () =>  const SubscriptionScreen()),
    GetPage(name: editWorkshopScreen, page: () =>  const EditWorkshopScreen()),
    GetPage(name: editProfileScreen, page: () =>  const EditProfileScreen()),


    ///==================== Setting Routes ====================
    GetPage(name: workShopWorkScreen, page: () =>  const WorkShopWorkScreen()),
    GetPage(name: carsCardScreen, page: () =>  const CarsCardScreen()),
    GetPage(name: profileScreen, page: () =>  const ProfileScreen()),
    GetPage(name: appExplainScreen, page: () =>  const AppExplainScreen()),
  ];
}
