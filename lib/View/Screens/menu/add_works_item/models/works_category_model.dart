import 'dart:convert';
import 'package:get/get.dart';

class WorkCategoryModel {
  bool? success;
  String? message;
  int? statusCode;
  List<Datum>? data;

  WorkCategoryModel({this.success, this.message, this.statusCode, this.data});

  factory WorkCategoryModel.fromRawJson(String str) =>
      WorkCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkCategoryModel.fromJson(Map<String, dynamic> json) =>
      WorkCategoryModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "statusCode": statusCode,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? image;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? workCategoryName;
  Title? title;
  Description? description;

  Datum({
    this.id,
    this.image,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.workCategoryName,
    this.title,
    this.description,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    image: json["image"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    workCategoryName: json["workCategoryName"],
    title: json["title"] == null ? null : Title.fromJson(json["title"]),
    description: json["description"] == null ? null : Description.fromJson(json["description"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "workCategoryName": workCategoryName,
    "title": title?.toJson(),
    "description": description?.toJson(),
  };

  // Get localized title based on current locale
  String getLocalizedTitle(String locale) {
    if (title == null) return workCategoryName ?? '';

    switch (locale) {
      case 'ar':
        return title!.ar ?? workCategoryName ?? '';
      case 'bn':
        return title!.bn ?? workCategoryName ?? '';
      case 'ur':
        return title!.ur ?? workCategoryName ?? '';
      case 'hi':
        return title!.hi ?? workCategoryName ?? '';
      case 'fil':
      case 'tl':
        return title!.tl ?? workCategoryName ?? '';
      case 'en':
      default:
        return title!.en ?? workCategoryName ?? '';
    }
  }

  // Convenient getter that uses current GetX locale
  String get localizedTitle {
    final currentLocale = Get.locale?.languageCode ?? 'en';
    return getLocalizedTitle(currentLocale);
  }
}

class Title {
  String? ar;
  String? bn;
  String? ur;
  String? hi;
  String? tl;
  String? en;
  String? id;

  Title({
    this.ar,
    this.bn,
    this.ur,
    this.hi,
    this.tl,
    this.en,
    this.id,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    ar: json["ar"],
    bn: json["bn"],
    ur: json["ur"],
    hi: json["hi"],
    tl: json["tl"],
    en: json["en"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "ar": ar,
    "bn": bn,
    "ur": ur,
    "hi": hi,
    "tl": tl,
    "en": en,
    "_id": id,
  };
}

class Description {
  String? ar;
  String? bn;
  String? ur;
  String? hi;
  String? tl;
  String? en;
  String? id;

  Description({
    this.ar,
    this.bn,
    this.ur,
    this.hi,
    this.tl,
    this.en,
    this.id,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    ar: json["ar"],
    bn: json["bn"],
    ur: json["ur"],
    hi: json["hi"],
    tl: json["tl"],
    en: json["en"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "ar": ar,
    "bn": bn,
    "ur": ur,
    "hi": hi,
    "tl": tl,
    "en": en,
    "_id": id,
  };
}