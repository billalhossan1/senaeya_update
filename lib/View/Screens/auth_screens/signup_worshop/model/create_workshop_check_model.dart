import 'dart:convert';

class CreateWorkShopCheckingModel {
    bool? success;
    String? message;
    int? statusCode;
    Data? data;

    CreateWorkShopCheckingModel({
        this.success,
        this.message,
        this.statusCode,
        this.data,
    });

    factory CreateWorkShopCheckingModel.fromRawJson(String str) => CreateWorkShopCheckingModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CreateWorkShopCheckingModel.fromJson(Map<String, dynamic> json) => CreateWorkShopCheckingModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "data": data?.toJson(),
    };
}

class Data {
    bool? isExistWorkshopByCrn;
    bool? isExistWorkshopByTax;
    bool? isExistWorkshopByUnn;
    bool? isExistWorkshopByMln;

    Data({
        this.isExistWorkshopByCrn,
        this.isExistWorkshopByTax,
        this.isExistWorkshopByUnn,
        this.isExistWorkshopByMln,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        isExistWorkshopByCrn: json["isExistWorkshopByCrn"],
        isExistWorkshopByTax: json["isExistWorkshopByTax"],
        isExistWorkshopByUnn: json["isExistWorkshopByUnn"],
        isExistWorkshopByMln: json["isExistWorkshopByMln"],
    );

    Map<String, dynamic> toJson() => {
        "isExistWorkshopByCrn": isExistWorkshopByCrn,
        "isExistWorkshopByTax": isExistWorkshopByTax,
        "isExistWorkshopByUnn": isExistWorkshopByUnn,
        "isExistWorkshopByMln": isExistWorkshopByMln,
    };
}
