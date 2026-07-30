import 'dart:convert';

class ClientCarListResponse {
  final bool? success;
  final String? message;
  final int? statusCode;
  final Data? data;

  ClientCarListResponse({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory ClientCarListResponse.fromRawJson(String str) => ClientCarListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientCarListResponse.fromJson(Map<String, dynamic> json) => ClientCarListResponse(
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
  final Meta? meta;
  final List<CarModel>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<CarModel>.from(json["result"]!.map((x) => CarModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

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

class CarModel {
  final String? id;
  final Brand? brand;
  final String? year;
  final String? vin;
  final Client? client;
  final ModelName? model;
  final String? carType;
  final dynamic plateNumberForInternational;
  final String? slugForSaudiCarPlateNumber;
  final PlateNumberForSaudi? plateNumberForSaudi;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CarModel({
    this.id,
    this.brand,
    this.year,
    this.model,
    this.vin,
    this.client,
    this.carType,
    this.plateNumberForInternational,
    this.slugForSaudiCarPlateNumber,
    this.plateNumberForSaudi,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory CarModel.fromRawJson(String str) => CarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    id: json["_id"],
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    model: json["model"] == null
        ? null
        : (json["model"] is String
            ? ModelName(id: json["model"])
            : ModelName.fromJson(json["model"])),
    year: json["year"],
    vin: json["vin"],
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
    carType: json["carType"],
    plateNumberForInternational: json["plateNumberForInternational"],
    slugForSaudiCarPlateNumber: json["slugForSaudiCarPlateNumber"],
    plateNumberForSaudi: json["plateNumberForSaudi"] == null ? null : PlateNumberForSaudi.fromJson(json["plateNumberForSaudi"]),
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "brand": brand?.toJson(),
    "year": year,
    "vin": vin,
    "client": client?.toJson(),
    "carType": carType,
    "plateNumberForInternational": plateNumberForInternational,
    "slugForSaudiCarPlateNumber": slugForSaudiCarPlateNumber,
    "plateNumberForSaudi": plateNumberForSaudi?.toJson(),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class ModelName {
  final String? id;
  final String? title;

  ModelName({
    this.id,
    this.title,
  });

  factory ModelName.fromRawJson(String str) =>
      ModelName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelName.fromJson(Map<String, dynamic> json) => ModelName(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}

class Brand {
  final String? id;
  final String? image;
  final String? title;
  final Brand? country;

  Brand({
    this.id,
    this.image,
    this.title,
    this.country,
  });

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["_id"],
    image: json["image"],
    title: json["title"],
    country: json["country"] == null ? null : Brand.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "title": title,
    "country": country?.toJson(),
  };
}

class Client {
  final String? status;
  final String? id;
  final String? providerWorkShopId;
  final String? clientType;
  final ClientId? clientId;
  final String? contact;
  final List<String>? cars;
  final List<dynamic>? invoices;
  final String? document;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Client({
    this.status,
    this.id,
    this.providerWorkShopId,
    this.clientType,
    this.clientId,
    this.contact,
    this.cars,
    this.invoices,
    this.document,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    status: json["status"],
    id: json["_id"],
    providerWorkShopId: json["providerWorkShopId"],
    clientType: json["clientType"],
    clientId: json["clientId"] == null ? null : ClientId.fromJson(json["clientId"]),
    contact: json["contact"],
    cars: json["cars"] == null ? [] : List<String>.from(json["cars"]!.map((x) => x)),
    invoices: json["invoices"] == null ? [] : List<dynamic>.from(json["invoices"]!.map((x) => x)),
    document: json["document"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "providerWorkShopId": providerWorkShopId,
    "clientType": clientType,
    "clientId": clientId?.toJson(),
    "contact": contact,
    "cars": cars == null ? [] : List<dynamic>.from(cars!.map((x) => x)),
    "invoices": invoices == null ? [] : List<dynamic>.from(invoices!.map((x) => x)),
    "document": document,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ClientId {
  final String? id;
  final String? name;
  final String? role;
  final String? contact;
  final String? image;
  final String? status;
  final bool? verified;
  final bool? isDeleted;
  final String? stripeCustomerId;
  final dynamic helperUserId;
  final dynamic subscribedPackage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ClientId({
    this.id,
    this.name,
    this.role,
    this.contact,
    this.image,
    this.status,
    this.verified,
    this.isDeleted,
    this.stripeCustomerId,
    this.helperUserId,
    this.subscribedPackage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ClientId.fromRawJson(String str) => ClientId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientId.fromJson(Map<String, dynamic> json) => ClientId(
    id: json["_id"],
    name: json["name"],
    role: json["role"],
    contact: json["contact"],
    image: json["image"],
    status: json["status"],
    verified: json["verified"],
    isDeleted: json["isDeleted"],
    stripeCustomerId: json["stripeCustomerId"],
    helperUserId: json["helperUserId"],
    subscribedPackage: json["subscribedPackage"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "role": role,
    "contact": contact,
    "image": image,
    "status": status,
    "verified": verified,
    "isDeleted": isDeleted,
    "stripeCustomerId": stripeCustomerId,
    "helperUserId": helperUserId,
    "subscribedPackage": subscribedPackage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class PlateNumberForSaudi {
  final Symbol? symbol;
  final String? numberEnglish;
  final String? numberArabic;
  final List<String>? alphabetsCombinations;
  final String? id;

  PlateNumberForSaudi({
    this.symbol,
    this.numberEnglish,
    this.numberArabic,
    this.alphabetsCombinations,
    this.id,
  });

  factory PlateNumberForSaudi.fromRawJson(String str) => PlateNumberForSaudi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlateNumberForSaudi.fromJson(Map<String, dynamic> json) => PlateNumberForSaudi(
    symbol: json["symbol"] == null
        ? null
        : (json["symbol"] is String
            ? Symbol(id: json["symbol"], image: null, title: null)
            : Symbol.fromJson(json["symbol"])),
    numberEnglish: json["numberEnglish"],
    numberArabic: json["numberArabic"],
    alphabetsCombinations: json["alphabetsCombinations"] == null ? [] : List<String>.from(json["alphabetsCombinations"]!.map((x) => x)),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol?.toJson(),
    "numberEnglish": numberEnglish,
    "numberArabic": numberArabic,
    "alphabetsCombinations": alphabetsCombinations == null ? [] : List<dynamic>.from(alphabetsCombinations!.map((x) => x)),
    "_id": id,
  };
}

class Symbol {
  final String? id;
  final String? image;
  final String? title;

  Symbol({
    this.id,
    this.image,
    this.title,
  });

  factory Symbol.fromRawJson(String str) => Symbol.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Symbol.fromJson(Map<String, dynamic> json) => Symbol(
    id: json["_id"],
    image: json["image"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "title": title,
  };
}
