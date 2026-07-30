import 'dart:convert';

import '../../customer_cars_screen/model/client_car_list_model.dart';

class PreviousInvoicesResponse {
  bool? success;
  String? message;
  int? statusCode;
  PreviousInvoicesListModel? data;

  PreviousInvoicesResponse({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory PreviousInvoicesResponse.fromRawJson(String str) =>
      PreviousInvoicesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PreviousInvoicesResponse.fromJson(Map<String, dynamic> json) =>
      PreviousInvoicesResponse(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        data: json["data"] == null
            ? null
            : PreviousInvoicesListModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "statusCode": statusCode,
    "data": data?.toJson(),
  };
}

class PreviousInvoicesListModel {
  Meta? meta;
  List<InvoiceModel>? invoicesList;

  PreviousInvoicesListModel({
    this.meta,
    this.invoicesList,
  });

  factory PreviousInvoicesListModel.fromRawJson(String str) =>
      PreviousInvoicesListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PreviousInvoicesListModel.fromJson(Map<String, dynamic> json) =>
      PreviousInvoicesListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        invoicesList: json["result"] == null
            ? []
            : List<InvoiceModel>.from(
            json["result"]!.map((x) => InvoiceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "result": invoicesList == null
        ? []
        : List<dynamic>.from(invoicesList!.map((x) => x.toJson())),
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


class InvoiceModel {
  String? id;
  String? providerWorkShopId;
  ClientModel? client;
  CarModel? car;
  int? discount;
  String? discountType;
  List<SList>? worksList;
  List<SList>? sparePartsList;
  String? paymentMethod;
  String? paymentStatus;
  DateTime? postPaymentDate;
  Payment? payment; // 🔹 updated to object
  bool? isDeleted;
  double? totalCostExcludingTax;
  double? taxAmount;
  double? totalCostIncludingTax;
  int? finalDiscountInFlatAmount;
  int? taxPercentage;
  double? finalCost;
  double? totalCostOfWorkShopExcludingTax;
  double? totalCostOfSparePartsExcludingTax;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? invoiceAwsLink;

  InvoiceModel({
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
    this.invoiceAwsLink,
  });

  factory InvoiceModel.fromRawJson(String str) =>
      InvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
    id: json["_id"],
    providerWorkShopId: json["providerWorkShopId"],
    client: json["client"] == null ? null : ClientModel.fromJson(json["client"] as Map<String, dynamic>),
    car: json["car"] == null ? null : CarModel.fromJson(json["car"]),
    discount: json["discount"],
    discountType: json["discountType"],
    worksList: json["worksList"] == null
        ? []
        : List<SList>.from(json["worksList"]!.map((x) => SList.fromJson(x))),
    sparePartsList: json["sparePartsList"] == null
        ? []
        : List<SList>.from(
        json["sparePartsList"]!.map((x) => SList.fromJson(x))),
    paymentMethod: json["paymentMethod"],
    paymentStatus: json["paymentStatus"],
    postPaymentDate: json["postPaymentDate"] == null
        ? null
        : DateTime.parse(json["postPaymentDate"]),
    payment: json["payment"] == null || json["payment"] is! Map
        ? null
        : Payment.fromJson(json["payment"] as Map<String, dynamic>),
    isDeleted: json["isDeleted"],
    totalCostExcludingTax: json["totalCostExcludingTax"]?.toDouble(),
    taxAmount: json["taxAmount"]?.toDouble(),
    totalCostIncludingTax: json["totalCostIncludingTax"]?.toDouble(),
    finalDiscountInFlatAmount: json["finalDiscountInFlatAmount"],
    taxPercentage: json["taxPercentage"],
    finalCost: json["finalCost"]?.toDouble(),
    totalCostOfWorkShopExcludingTax:
    json["totalCostOfWorkShopExcludingTax"]?.toDouble(),
    totalCostOfSparePartsExcludingTax:
    json["totalCostOfSparePartsExcludingTax"]?.toDouble(),
    createdAt:
    json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
    json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    invoiceAwsLink: json["invoiceAwsLink"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "providerWorkShopId": providerWorkShopId,
    "client": client?.toJson(),
    "car": car?.toJson(),
    "discount": discount,
    "discountType": discountType,
    "worksList": worksList == null
        ? []
        : List<dynamic>.from(worksList!.map((x) => x.toJson())),
    "sparePartsList": sparePartsList == null
        ? []
        : List<dynamic>.from(sparePartsList!.map((x) => x.toJson())),
    "paymentMethod": paymentMethod,
    "paymentStatus": paymentStatus,
    "postPaymentDate": postPaymentDate?.toIso8601String(),
    "payment": payment?.toJson(), // 🔹 updated
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
    "invoiceAwsLink": invoiceAwsLink,
  };
}

/// 🔹 New Payment model
class Payment {
  String? id;
  DateTime? createdAt;

  Payment({this.id, this.createdAt});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["_id"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
  };
}




class Brand {
  String? id;
  String? image;
  String? title;

  Brand({this.id, this.image, this.title});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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

class ModelName {
  String? id;
  String? title;

  ModelName({this.id, this.title});

  factory ModelName.fromJson(Map<String, dynamic> json) => ModelName(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}

class SList {
  String? work;
  int? quantity;
  String? id;
  double? finalCost;

  SList({
    this.work,
    this.quantity,
    this.id,
    this.finalCost,
  });

  factory SList.fromRawJson(String str) => SList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SList.fromJson(Map<String, dynamic> json) => SList(
    work: json["work"],
    quantity: json["quantity"],
    id: json["_id"],
    finalCost: json["finalCost"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "work": work,
    "quantity": quantity,
    "_id": id,
    "finalCost": finalCost,
  };
}

/// New client models to represent the `client` object in the API response
class ClientModel {
  String? id;
  String? providerWorkShopId;
  String?workShopNameAsClient;
  String? clientType;
  ClientId? clientId;
  String? contact;
  List<String>? cars;
  List<dynamic>? invoices;
  dynamic document;
  String? documentNumber;
  bool? isDeleted;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ClientModel({
    this.workShopNameAsClient,
    this.id,
    this.providerWorkShopId,
    this.clientType,
    this.clientId,
    this.contact,
    this.cars,
    this.invoices,
    this.document,
    this.documentNumber,
    this.isDeleted,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json["_id"],
    providerWorkShopId: json["providerWorkShopId"],
    workShopNameAsClient: json["workShopNameAsClient"],
    clientType: json["clientType"],
    clientId: json["clientId"] == null
        ? null
        : ClientId.fromJson(json["clientId"] as Map<String, dynamic>),
    contact: json["contact"],
    cars: json["cars"] == null
        ? []
        : List<String>.from(json["cars"].map((x) => x.toString())),
    invoices: json["invoices"],
    document: json["document"],
    documentNumber: json["documentNumber"],
    isDeleted: json["isDeleted"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "providerWorkShopId": providerWorkShopId,
    "clientType": clientType,
    "clientId": clientId?.toJson(),
    "contact": contact,
    "cars": cars == null ? [] : List<dynamic>.from(cars!.map((x) => x)),
    "invoices": invoices,
    "document": document,
    "documentNumber": documentNumber,
    "isDeleted": isDeleted,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ClientId {
  String? id;
  String? name;
  String? contact;

  ClientId({this.id, this.name, this.contact});

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
