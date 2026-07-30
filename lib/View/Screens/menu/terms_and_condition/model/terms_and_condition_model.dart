import 'dart:convert';

class TermsandConditionModel {
    bool? success;
    String? message;
    int? statusCode;
    TermsData? data;

    TermsandConditionModel({
        this.success,
        this.message,
        this.statusCode,
        this.data,
    });

    factory TermsandConditionModel.fromRawJson(String str) =>
        TermsandConditionModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TermsandConditionModel.fromJson(Map<String, dynamic> json) =>
        TermsandConditionModel(
            success: json["success"],
            message: json["message"],
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : TermsData.fromJson(json["data"]),
        );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "data": data?.toJson(),
    };
}

class TermsData {
    String? id;
    String? content;
    int? v;

    TermsData({
        this.id,
        this.content,
        this.v,
    });

    factory TermsData.fromJson(Map<String, dynamic> json) => TermsData(
        id: json["_id"],
        content: json["content"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "__v": v,
    };
}
