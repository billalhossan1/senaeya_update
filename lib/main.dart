import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Core/Dependency/dependency.dart';
import 'package:Senaeya/Service/protrait_lock.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'Core/AppTranslations/app_translations.dart';
import 'package:flutter/services.dart';
import 'Helper/shared_prefe/shared_prefe.dart';
import 'Service/internet_connectivity.dart';
import 'Service/notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DeviceUtils.lockDevicePortrait();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1771B7), // White status bar
      statusBarIconBrightness: Brightness.light, // Dark icons for visibility
      statusBarBrightness: Brightness.light,
    ),
  );
  DependencyInjection di = DependencyInjection();
  //SocketApi.init();
  di.dependencies();
  Get.put(InternetController(), permanent: true);
  // Load saved language preference before launching the app
  String savedLang = await SharePrefsHelper.getString(SharedPreferenceValue.language);
  Locale? initialLocale;
  if (savedLang.isNotEmpty) {
    initialLocale = Locale(savedLang);
  }

//   if (Platform.isIOS) {
// // Initialize Firebase for iOS
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//         apiKey: 'd04abdd5fe67e7e0d01c5955f0759705baadd291',
//         appId: '1:353734963603:ios:090d36d13900d76a787866',
//         messagingSenderId: '353734963603',
//         projectId: 'senaeya-59503',
//         storageBucket: 'senaeya-59503.firebasestorage.app',
//         iosBundleId: 'ccom.fahadalfayez.senaeya',
//       ),
//     );
//   } else {
// Initialize Firebase for Android
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  // }

  // Create custom notification channel BEFORE setupFCM
  await NotificationService.createCustomNotificationChannel();

  await NotificationService().setupFCM();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (BuildContext context) {
        return MyApp(initialLocale: initialLocale);
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale? initialLocale;
  const MyApp({super.key, this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GetMaterialApp(
          navigatorKey: Get.key,
          initialRoute: AppRoute.splashScreen,
          getPages: AppRoute.routes,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
          translations: AppTranslations(),
          // Prefer the loaded initialLocale, otherwise use Get.locale or default to English
          locale: initialLocale ?? Get.locale ?? const Locale('en'),
          fallbackLocale: const Locale('en'),
          // Include all supported locales
          supportedLocales: const [Locale('en'), Locale('ar'), Locale('fil'), Locale('bn'), Locale('hi'), Locale('ur')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
