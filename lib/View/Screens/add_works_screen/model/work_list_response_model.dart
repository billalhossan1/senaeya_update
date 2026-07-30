import 'dart:convert';

class WorksListResponse {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  WorksListResponse({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory WorksListResponse.fromRawJson(String str) => WorksListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorksListResponse.fromJson(Map<String, dynamic> json) => WorksListResponse(
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
  List<WorksModel>? workList;

  Data({
    this.meta,
    this.workList,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    workList: json["result"] == null ? [] : List<WorksModel>.from(json["result"]!.map((x) => WorksModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "result": workList == null ? [] : List<dynamic>.from(workList!.map((x) => x.toJson())),
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

class WorksModel {
  String? id;
  Title? title;
  String? workCategoryName;
  String? type;
  String? code;
  int? cost;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  WorksModel({
    this.id,
    this.title,
    this.workCategoryName,
    this.type,
    this.code,
    this.cost,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory WorksModel.fromRawJson(String str) => WorksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorksModel.fromJson(Map<String, dynamic> json) => WorksModel(
    id: json["_id"],
    title: json["title"] == null ? null : Title.fromJson(json["title"]),
    workCategoryName: json["workCategoryName"],
    type: json["type"],
    code: json["code"],
    cost: json["cost"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title?.toJson(),
    "workCategoryName": workCategoryName,
    "type": type,
    "code": code,
    "cost": cost,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  // Helper method to get localized title
  String getLocalizedTitle(String languageCode) {
    if (title == null) return '';

    switch (languageCode) {
      case 'ar':
        return title?.ar ?? title?.en ?? '';
      case 'bn':
        return title?.bn ?? title?.en ?? '';
      case 'ur':
        return title?.ur ?? title?.en ?? '';
      case 'hi':
        return title?.hi ?? title?.en ?? '';
      case 'tl':
        return title?.tl ?? title?.en ?? '';
      default:
        return title?.en ?? '';
    }
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

  factory Title.fromRawJson(String str) => Title.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
