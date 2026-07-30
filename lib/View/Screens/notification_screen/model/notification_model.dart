import 'dart:convert';

class NotificationModelResponse {
  bool? success;
  String? message;
  int? statusCode;
  NotificationListModel? data;

  NotificationModelResponse({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory NotificationModelResponse.fromRawJson(String str) =>
      NotificationModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModelResponse.fromJson(Map<String, dynamic> json) =>
      NotificationModelResponse(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        data: json["data"] == null
            ? null
            : NotificationListModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "data": data?.toJson(),
      };
}

class NotificationListModel {
  List<NotificationModel>? notificationList;
  int? unreadCount;

  NotificationListModel({
    this.notificationList,
    this.unreadCount,
  });

  factory NotificationListModel.fromRawJson(String str) =>
      NotificationListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationListModel.fromJson(Map<String, dynamic> json) =>
      NotificationListModel(
        notificationList: json["result"] == null
            ? []
            : List<NotificationModel>.from(
                json["result"]!.map((x) => NotificationModel.fromJson(x))),
        unreadCount: json["unreadCount"],
      );

  Map<String, dynamic> toJson() => {
        "result": notificationList == null
            ? []
            : List<dynamic>.from(notificationList!.map((x) => x.toJson())),
        "unreadCount": unreadCount,
      };
}

class NotificationModel {
  String? id;
  String? title;
  String? message;
  String? messageAr;
  String? messageBn;
  String? messageTl;
  String? messageHi;
  String? messageUr;
  String? receiver;
  String? presentDevice;
  bool? read;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.messageAr,
    this.messageBn,
    this.messageTl,
    this.messageHi,
    this.messageUr,
    this.receiver,
    this.presentDevice,
    this.read,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["_id"],
        title: json["title"],
        message: json["message"],
        messageAr: json["message_ar"],
        messageBn: json["message_bn"],
        messageTl: json["message_tl"],
        messageHi: json["message_hi"],
        messageUr: json["message_ur"],
        receiver: json["receiver"],
        presentDevice: json["presentDevice"],
        read: json["read"],
        type: json["type"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "message": message,
        "message_ar": messageAr,
        "message_bn": messageBn,
        "message_tl": messageTl,
        "message_hi": messageHi,
        "message_ur": messageUr,
        "receiver": receiver,
        "presentDevice": presentDevice,
        "read": read,
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
