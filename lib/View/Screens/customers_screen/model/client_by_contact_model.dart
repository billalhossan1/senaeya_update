import 'dart:convert';

class ClientByContactModel {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  ClientByContactModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory ClientByContactModel.fromRawJson(String str) => ClientByContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientByContactModel.fromJson(Map<String, dynamic> json) => ClientByContactModel(
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
  String? id;
  Brand? brand;
  String? year;
  String? vin;
  Client? client;
  String? description;
  String? carType;
  String? plateNumberForInternational;
  dynamic slugForSaudiCarPlateNumber;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.brand,
    this.year,
    this.vin,
    this.client,
    this.description,
    this.carType,
    this.plateNumberForInternational,
    this.slugForSaudiCarPlateNumber,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    year: json["year"],
    vin: json["vin"],
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
    description: json["description"],
    carType: json["carType"],
    plateNumberForInternational: json["plateNumberForInternational"],
    slugForSaudiCarPlateNumber: json["slugForSaudiCarPlateNumber"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "brand": brand?.toJson(),
    "year": year,
    "vin": vin,
    "client": client?.toJson(),
    "description": description,
    "carType": carType,
    "plateNumberForInternational": plateNumberForInternational,
    "slugForSaudiCarPlateNumber": slugForSaudiCarPlateNumber,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Brand {
  String? id;
  String? image;
  String? title;
  Brand? country;

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
  String? id;
  String? providerWorkShopId;
  String? clientType;
  ClientId? clientId;
  String? contact;
  List<String>? cars;
  List<dynamic>? invoices;
  String? document;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? status;

  Client({
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
    this.status,
  });

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
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
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
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
    "status": status,
  };
}

class ClientId {
  String? id;
  String? name;
  String? role;
  String? contact;
  String? image;
  String? status;
  bool? verified;
  bool? isDeleted;
  String? stripeCustomerId;
  dynamic helperUserId;
  dynamic subscribedPackage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

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
