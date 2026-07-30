import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../Core/AppRoute/app_route.dart';
import '../../../../../Helper/shared_prefe/shared_prefe.dart';

class LanguageOption {
  final String code;
  final String name;
  final String flagAsset;
  const LanguageOption(this.code, this.name, this.flagAsset);
}


class SelectLanguageController extends GetxController {

  String arg = '';
  @override
  void onInit() {
    arg = Get.arguments?['from'] ?? '';
    // Load saved language preference (if any) and apply it
    _loadSavedLanguage();
    super.onInit();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final saved = await SharePrefsHelper.getString(SharedPreferenceValue.language);
      if (saved.isNotEmpty) {
        selectedLang.value = saved;
        Get.updateLocale(Locale(saved));
      }
    } catch (e) {
      // ignore and keep default locale
    }
  }
  final languages = [
     LanguageOption('ar', 'عربي', AppLogo.saudi),
     LanguageOption('en', 'English', AppLogo.uk),
     LanguageOption('fil', 'Filipino', AppLogo.phili),
     LanguageOption('bn', 'বাংলা', AppLogo.bangla),
     LanguageOption('hi', 'हिंदी', AppLogo.india),
     LanguageOption('ur', 'اردو',AppLogo.pakistan),
  ];

  RxString selectedLang = (Get.locale?.languageCode ?? 'en').obs;

  void selectLanguage(String code) {
    selectedLang.value = code;
    Locale locale;
    switch (code) {
      case 'ar':
        locale = const Locale('ar');
        break;
      case 'en':
        locale = const Locale('en');
        break;
      case 'fil':
        locale = const Locale('fil');
        break;
      case 'bn':
        locale = const Locale('bn');
        break;
      case 'hi':
        locale = const Locale('hi');
        break;
      case 'ur':
        locale = const Locale('ur');
        break;
      default:
        locale = const Locale('en');
    }
    // Persist selection so it survives app/device restart
    SharePrefsHelper.setString(SharedPreferenceValue.language, code);
    // Apply immediately
    Get.updateLocale(locale);
  }

  void confirmSelection() {
    // Update the app locale before navigation
    final locale = Locale(selectedLang.value);
    Get.updateLocale(locale);
    if(arg.isNotEmpty){
      arg = '';
      Get.offAllNamed(AppRoute.loginScreen);
    }else{
      Get.offNamed(AppRoute.splashScreen);
    }
  }
}
