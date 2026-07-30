import 'dart:convert';

class WorkshopModel {
    bool? success;
    String? message;
    int? statusCode;
    Data? data;

    WorkshopModel({
        this.success,
        this.message,
        this.statusCode,
        this.data,
    });

    factory WorkshopModel.fromRawJson(String str) => WorkshopModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WorkshopModel.fromJson(Map<String, dynamic> json) => WorkshopModel(
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
    WorkshopGeOlocation? workshopGeOlocation;
    String? id;
    String? workshopNameEnglish;
    String? workshopNameArabic;
    String? contact;
    String? unn;
    String? crn;
    String? mln;
    String? address;
    String? taxVatNumber;
    String? bankAccountNumber;
    bool? isAvailableMobileWorkshop;
    WorkingSchedule? regularWorkingSchedule;
    WorkingSchedule? ramadanWorkingSchedule;
    String? ownerId;
    dynamic helperUserId;
    bool? isDeleted;
    int? generatedInvoiceCount;
    dynamic subscribedPackage;
    dynamic subscriptionId;
    bool? isUsedTrial;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
        this.workshopGeOlocation,
        this.id,
        this.workshopNameEnglish,
        this.workshopNameArabic,
        this.contact,
        this.unn,
        this.crn,
        this.mln,
        this.address,
        this.taxVatNumber,
        this.bankAccountNumber,
        this.isAvailableMobileWorkshop,
        this.regularWorkingSchedule,
        this.ramadanWorkingSchedule,
        this.ownerId,
        this.helperUserId,
        this.isDeleted,
        this.generatedInvoiceCount,
        this.subscribedPackage,
        this.subscriptionId,
        this.isUsedTrial,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        workshopGeOlocation: json["workshopGEOlocation"] == null ? null : WorkshopGeOlocation.fromJson(json["workshopGEOlocation"]),
        id: json["_id"],
        workshopNameEnglish: json["workshopNameEnglish"],
        workshopNameArabic: json["workshopNameArabic"],
        contact: json["contact"],
        unn: json["unn"],
        crn: json["crn"],
        mln: json["mln"],
        address: json["address"],
        taxVatNumber: json["taxVatNumber"],
        bankAccountNumber: json["bankAccountNumber"],
        isAvailableMobileWorkshop: json["isAvailableMobileWorkshop"],
        regularWorkingSchedule: json["regularWorkingSchedule"] == null ? null : WorkingSchedule.fromJson(json["regularWorkingSchedule"]),
        ramadanWorkingSchedule: json["ramadanWorkingSchedule"] == null ? null : WorkingSchedule.fromJson(json["ramadanWorkingSchedule"]),
        ownerId: json["ownerId"],
        helperUserId: json["helperUserId"],
        isDeleted: json["isDeleted"],
        generatedInvoiceCount: json["generatedInvoiceCount"],
        subscribedPackage: json["subscribedPackage"],
        subscriptionId: json["subscriptionId"],
        isUsedTrial: json["isUsedTrial"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "workshopGEOlocation": workshopGeOlocation?.toJson(),
        "_id": id,
        "workshopNameEnglish": workshopNameEnglish,
        "workshopNameArabic": workshopNameArabic,
        "contact": contact,
        "unn": unn,
        "crn": crn,
        "mln": mln,
        "address": address,
        "taxVatNumber": taxVatNumber,
        "bankAccountNumber": bankAccountNumber,
        "isAvailableMobileWorkshop": isAvailableMobileWorkshop,
        "regularWorkingSchedule": regularWorkingSchedule?.toJson(),
        "ramadanWorkingSchedule": ramadanWorkingSchedule?.toJson(),
        "ownerId": ownerId,
        "helperUserId": helperUserId,
        "isDeleted": isDeleted,
        "generatedInvoiceCount": generatedInvoiceCount,
        "subscribedPackage": subscribedPackage,
        "subscriptionId": subscriptionId,
        "isUsedTrial": isUsedTrial,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class WorkingSchedule {
    String? startDay;
    String? endDay;
    String? startTime;
    String? endTime;

    WorkingSchedule({
        this.startDay,
        this.endDay,
        this.startTime,
        this.endTime,
    });

    factory WorkingSchedule.fromRawJson(String str) => WorkingSchedule.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WorkingSchedule.fromJson(Map<String, dynamic> json) => WorkingSchedule(
        startDay: json["startDay"],
        endDay: json["endDay"],
        startTime: json["startTime"],
        endTime: json["endTime"],
    );

    Map<String, dynamic> toJson() => {
        "startDay": startDay,
        "endDay": endDay,
        "startTime": startTime,
        "endTime": endTime,
    };
}

class WorkshopGeOlocation {
    String? type;
    List<double>? coordinates;

    WorkshopGeOlocation({
        this.type,
        this.coordinates,
    });

    factory WorkshopGeOlocation.fromRawJson(String str) => WorkshopGeOlocation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WorkshopGeOlocation.fromJson(Map<String, dynamic> json) => WorkshopGeOlocation(
        type: json["type"],
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}