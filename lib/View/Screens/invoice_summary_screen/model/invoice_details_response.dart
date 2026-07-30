import 'dart:convert';

class InvoiceDetailsResponse {
  bool? success;
  String? message;
  int? statusCode;
  InvoiceDetailsModel? data;

  InvoiceDetailsResponse({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory InvoiceDetailsResponse.fromRawJson(String str) => InvoiceDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceDetailsResponse.fromJson(Map<String, dynamic> json) => InvoiceDetailsResponse(
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? null : InvoiceDetailsModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "statusCode": statusCode,
    "data": data?.toJson(),
  };
}

class InvoiceDetailsModel {
  String? id;
  ProviderWorkShop? providerWorkShopId;
  Client? client;
  Car? car;
  int? discount;
  String? discountType;
  List<SList>? worksList;
  List<SList>? sparePartsList;
  String? paymentMethod;
  String? paymentStatus;
  DateTime? postPaymentDate;
  dynamic payment;
  bool? isDeleted;
  int? totalCostExcludingTax;
  double? taxAmount;
  double? totalCostIncludingTax;
  int? finalDiscountInFlatAmount;
  int? taxPercentage;
  double? finalCost;
  int? totalCostOfWorkShopExcludingTax;
  int? totalCostOfSparePartsExcludingTax;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  InvoiceDetailsModel({
    this.id,
    this.providerWorkShopId,
    this.client,
    this.car,
    this.discount,
    this.discountType,
    this.worksList,
    this.sparePartsList,
    this.paymentMethod,
    this.paymentStatus,
    this.postPaymentDate,
    this.payment,
    this.isDeleted,
    this.totalCostExcludingTax,
    this.taxAmount,
    this.totalCostIncludingTax,
    this.finalDiscountInFlatAmount,
    this.taxPercentage,
    this.finalCost,
    this.totalCostOfWorkShopExcludingTax,
    this.totalCostOfSparePartsExcludingTax,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory InvoiceDetailsModel.fromRawJson(String str) => InvoiceDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) => InvoiceDetailsModel(
    id: json["_id"],
      providerWorkShopId: json["providerWorkShopId"] == null
          ? null
          : ProviderWorkShop.fromJson(json["providerWorkShopId"]),

    client: json["client"] == null ? null : Client.fromJson(json["client"]),
    car: json["car"] == null ? null : Car.fromJson(json["car"]),
    discount: json["discount"],
    discountType: json["discountType"],
    worksList: json["worksList"] == null ? [] : List<SList>.from(json["worksList"]!.map((x) => SList.fromJson(x))),
    sparePartsList: json["sparePartsList"] == null ? [] : List<SList>.from(json["sparePartsList"]!.map((x) => SList.fromJson(x))),
    paymentMethod: json["paymentMethod"],
    paymentStatus: json["paymentStatus"],
    postPaymentDate: json["postPaymentDate"] == null ? null : DateTime.parse(json["postPaymentDate"]),
    payment: json["payment"],
    isDeleted: json["isDeleted"],
    totalCostExcludingTax: json["totalCostExcludingTax"],
    taxAmount: json["taxAmount"]?.toDouble(),
    totalCostIncludingTax: json["totalCostIncludingTax"]?.toDouble(),
    finalDiscountInFlatAmount: json["finalDiscountInFlatAmount"],
    taxPercentage: json["taxPercentage"],
    finalCost: json["finalCost"]?.toDouble(),
    totalCostOfWorkShopExcludingTax: json["totalCostOfWorkShopExcludingTax"],
    totalCostOfSparePartsExcludingTax: json["totalCostOfSparePartsExcludingTax"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "providerWorkShopId": providerWorkShopId?.toJson(),
    "client": client?.toJson(),
    "car": car?.toJson(),
    "discount": discount,
    "discountType": discountType,
    "worksList": worksList == null ? [] : List<dynamic>.from(worksList!.map((x) => x.toJson())),
    "sparePartsList": sparePartsList == null ? [] : List<dynamic>.from(sparePartsList!.map((x) => x.toJson())),
    "paymentMethod": paymentMethod,
    "paymentStatus": paymentStatus,
    "postPaymentDate": postPaymentDate?.toIso8601String(),
    "payment": payment,
    "isDeleted": isDeleted,
    "totalCostExcludingTax": totalCostExcludingTax,
    "taxAmount": taxAmount,
    "totalCostIncludingTax": totalCostIncludingTax,
    "finalDiscountInFlatAmount": finalDiscountInFlatAmount,
    "taxPercentage": taxPercentage,
    "finalCost": finalCost,
    "totalCostOfWorkShopExcludingTax": totalCostOfWorkShopExcludingTax,
    "totalCostOfSparePartsExcludingTax": totalCostOfSparePartsExcludingTax,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Car {
  String? id;
  dynamic brand;
  Model? model;
  String? year;
  PlateNumberForSaudi? plateNumberForSaudi;
  String? plateNumberForInternational;

  Car({
    this.id,
    this.brand,
    this.model,
    this.year,
    this.plateNumberForSaudi,
    this.plateNumberForInternational,
  });

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["_id"],
    brand: json["brand"],
    model: json["model"] == null ? null : Model.fromJson(json["model"]),
    year: json["year"],
    plateNumberForSaudi: json["plateNumberForSaudi"] == null ? null : PlateNumberForSaudi.fromJson(json["plateNumberForSaudi"]),
    plateNumberForInternational: json["plateNumberForInternational"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "brand": brand,
    "model": model?.toJson(),
    "year": year,
    "plateNumberForSaudi": plateNumberForSaudi?.toJson(),
  };
}

class Model {
  String? id;
  String? brand;
  String? title;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Model({
    this.id,
    this.brand,
    this.title,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Model.fromRawJson(String str) => Model.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: json["_id"],
    brand: json["brand"],
    title: json["title"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "brand": brand,
    "title": title,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class PlateNumberForSaudi {
  Symbol? symbol;
  String? numberEnglish;
  String? numberArabic;
  List<String>? alphabetsCombinations;
  String? id;

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
    symbol: json["symbol"] == null ? null : Symbol.fromJson(json["symbol"]),
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
  String? id;
  String? image;
  String? title;
  String? type;
  String? description;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Symbol({
    this.id,
    this.image,
    this.title,
    this.type,
    this.description,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Symbol.fromRawJson(String str) => Symbol.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Symbol.fromJson(Map<String, dynamic> json) => Symbol(
    id: json["_id"],
    image: json["image"],
    title: json["title"],
    type: json["type"],
    description: json["description"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "title": title,
    "type": type,
    "description": description,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Client {
  String? id;
  String? clientType;
  ClientId? clientId;
  String? contact;
  String? workShopNameAsClient;

  Client({
    this.id,
    this.clientType,
    this.clientId,
    this.contact,
    this.workShopNameAsClient,
  });

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["_id"],
    clientType: json["clientType"],
    clientId: json["clientId"] == null ? null : ClientId.fromJson(json["clientId"]),
    contact: json["contact"],
    workShopNameAsClient: json["workShopNameAsClient"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "clientType": clientType,
    "clientId": clientId?.toJson(),
    "contact": contact,
    "workShopNameAsClient": workShopNameAsClient,
  };
}

class ClientId {
  String? id;
  String? name;
  String? contact;

  ClientId({
    this.id,
    this.name,
    this.contact,
  });

  factory ClientId.fromRawJson(String str) => ClientId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientId.fromJson(Map<String, dynamic> json) => ClientId(
    id: json["_id"],
    name: json["name"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "contact": contact,
  };
}

class SList {
  Work? work;
  int? quantity;
  String? id;
  int? finalCost;

  SList({
    this.work,
    this.quantity,
    this.id,
    this.finalCost,
  });

  factory SList.fromRawJson(String str) => SList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SList.fromJson(Map<String, dynamic> json) => SList(
    work: json["work"] == null ? null : Work.fromJson(json["work"]),
    quantity: json["quantity"],
    id: json["_id"],
    finalCost: json["finalCost"],
  );

  Map<String, dynamic> toJson() => {
    "work": work?.toJson(),
    "quantity": quantity,
    "_id": id,
    "finalCost": finalCost,
  };
}

class Work {
  String? id;
  Title? title;
  int? cost;

  Work({
    this.id,
    this.title,
    this.cost,
  });

  factory Work.fromRawJson(String str) => Work.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    id: json["_id"],
    title: json["title"] == null ? null : Title.fromJson(json["title"]),
    cost: json["cost"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title?.toJson(),
    "cost": cost,
  };
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
class ProviderWorkShop {
  final String? id;
  final String? workshopNameArabic;
  final String? crn;
  final String? address;
  final String? taxVatNumber;
  final String? bankAccountNumber;
  final Owner? ownerId;

  ProviderWorkShop({
    this.id,
    this.workshopNameArabic,
    this.crn,
    this.address,
    this.taxVatNumber,
    this.bankAccountNumber,
    this.ownerId,
  });

  factory ProviderWorkShop.fromJson(Map<String, dynamic> json) {
    return ProviderWorkShop(
      id: json['_id'],
      workshopNameArabic: json['workshopNameArabic'],
      crn: json['crn'],
      address: json['address'],
      taxVatNumber: json['taxVatNumber'],
      bankAccountNumber: json['bankAccountNumber'],
      ownerId:
      json['ownerId'] != null ? Owner.fromJson(json['ownerId']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "workshopNameArabic": workshopNameArabic,
    "crn": crn,
    "address": address,
    "taxVatNumber": taxVatNumber,
    "bankAccountNumber": bankAccountNumber,
    "ownerId": ownerId?.toJson(),
  };
}

class Owner {
  final String? id;
  final String? name;

  Owner({this.id, this.name});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

