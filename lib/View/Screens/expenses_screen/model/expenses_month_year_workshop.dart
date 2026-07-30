import 'dart:convert';

class ExpensesMonthYearModel {
    bool? success;
    String? message;
    int? statusCode;
    Data? data;

    ExpensesMonthYearModel({
        this.success,
        this.message,
        this.statusCode,
        this.data,
    });

    factory ExpensesMonthYearModel.fromRawJson(String str) => ExpensesMonthYearModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ExpensesMonthYearModel.fromJson(Map<String, dynamic> json) => ExpensesMonthYearModel(
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
    Meta? meta;
    List<Result>? result;

    Data({
        this.meta,
        this.result,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Meta {
    int? page;
    int? limit;
    int? total;
    int? totalPage;

    Meta({
        this.page,
        this.limit,
        this.total,
        this.totalPage,
    });

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPage: json["totalPage"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "totalPage": totalPage,
    };
}

class Result {
    String? id;
    String? providerWorkShopId;
    String? title;
    dynamic amount;
    DateTime? spendingDate;
    String? description;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? item;

    Result({
        this.id,
        this.providerWorkShopId,
        this.title,
        this.amount,
        this.spendingDate,
        this.description,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.item,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        providerWorkShopId: json["providerWorkShopId"],
        title: json["title"],
        amount: json["amount"],
        spendingDate: json["spendingDate"] == null ? null : DateTime.parse(json["spendingDate"]),
        description: json["description"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        item: json["item"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "providerWorkShopId": providerWorkShopId,
        "title": title,
        "amount": amount,
        "spendingDate": spendingDate?.toIso8601String(),
        "description": description,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "item": item,
    };
}
