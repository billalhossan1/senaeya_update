import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../View/Screens/add_customer_screen/model/car_brand_model.dart';
import '../../View/Screens/home_screen/model/country_list_model.dart';
import 'package:get/get.dart';

class SharedPreferenceValue {
  static const String searchHistory = "searchHistory";
  static const String token = "token";
  static const String email = "email";
  static const String userId = "userId";
  static const String isRemember = "isRemember";
  static const String isOnboarding = "isOnboarding";
  static const String fcmToken = "fcmToken";
  static const String language = "language";
  static const String role="role";
  static const String teacherType="teacherType";
  static const String number="number";
  static const String password="password";
  static const String workshopId="workshopId";
  static const String contactNumber = "contactNumber";
  static const String subscriptionId =  "subscriptionId";
  static const String carSymbolList =  "carSymbolList";
  static const String carBrandList =  "carBrandList";
  static const String prefsKey = 'selected_country_ids';
  static const String prefsKeyWorkShop = 'selected_workshopwork_ids';
}

class SharePrefsHelper {
  //===========================Get Data From Shared Preference===================

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(key) ?? "";
  }

  static Future<List<String>> getLisOfString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var getListData = preferences.getStringList(key);

    return getListData ?? [];

  }



  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

//===========================Save Data To Shared Preference===================

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  static Future<bool> setListOfString(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var setListData = await preferences.setStringList(key, value);

    return setListData;
  }

  /// Save Car Symbol List

  static Future<void> setCarSymbolList(String key, RxList<CommonItemModel> carSymbols) async {
    final preferences = await SharedPreferences.getInstance();
    List<String> stringList = carSymbols.map((item) => jsonEncode(item.toJson())).toList();
    await preferences.setStringList(key, stringList);
  }

  /// Save Car Symbol List
  static Future<void> setCarBrandList(String key, RxList<CarBrand> carBrands) async {
    final preferences = await SharedPreferences.getInstance();
    List<String> stringList = carBrands.map((item) => jsonEncode(item.toJson())).toList();
    await preferences.setStringList(key, stringList);
  }

  /// Save Car Brand List
  static Future<RxList<CommonItemModel>> getCarSymbolList(String key) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      List<String>? stringList = preferences.getStringList(key);
      if (stringList != null) {
        List<CommonItemModel> carSymbols = stringList
            .map((item) => CommonItemModel.fromJson(jsonDecode(item)))
            .toList();
        return RxList<CommonItemModel>(carSymbols);
      } else {
        return RxList<CommonItemModel>();
      }
    } catch (e) {
      // If there's a type mismatch, remove the invalid data and return empty list
      final preferences = await SharedPreferences.getInstance();
      await preferences.remove(key);
      return RxList<CommonItemModel>();
    }
  }


  /// Save Car Brand List
  static Future<RxList<CarBrand>> getCarBrand(String key) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      List<String>? stringList = preferences.getStringList(key);
      if (stringList != null) {
        List<CarBrand> carBrand = stringList
            .map((item) => CarBrand.fromJson(jsonDecode(item)))
            .toList();
        return RxList<CarBrand>(carBrand);
      } else {
        return RxList<CarBrand>();
      }
    } catch (e) {
      // If there's a type mismatch, remove the invalid data and return empty list
      final preferences = await SharedPreferences.getInstance();
      await preferences.remove(key);
      return RxList<CarBrand>();
    }
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }
  static clearData() async {
    SharePrefsHelper.remove(SharedPreferenceValue.workshopId);
    SharePrefsHelper.remove(SharedPreferenceValue.token);
    SharePrefsHelper.remove(SharedPreferenceValue.userId);
    SharePrefsHelper.remove(SharedPreferenceValue.role);
  }

//===========================Remove Value===================

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
