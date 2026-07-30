import 'dart:convert';

class AboutUsModel {
    bool? success;
    String? message;
    int? statusCode;
    String? data;

    AboutUsModel({
        this.success,
        this.message,
        this.statusCode,
        this.data,
    });

    factory AboutUsModel.fromRawJson(String str) => AboutUsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "data": data,
    };
}
