class SubscriptionDetailsModel {
  bool? success;
  String? message;
  int? statusCode;
  SubsriptionItem? subsriptionItem;

  SubscriptionDetailsModel({
    this.success,
    this.message,
    this.statusCode,
    this.subsriptionItem,
  });

  SubscriptionDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    subsriptionItem =
    json['data'] != null ? SubsriptionItem.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (subsriptionItem != null) {
      data['data'] = subsriptionItem!.toJson();
    }
    return data;
  }
}

class SubsriptionItem {
  String? sId;
  String? trxId;
  int? iV;
  double? amountPaid;
  String? contact;
  String? coupon;
  String? createdAt;
  String? currentPeriodEnd;
  String? currentPeriodStart;
  String? package;
  dynamic price;
  String? status;
  String? updatedAt;
  String? workshop; // only workshop _id

  SubsriptionItem({
    this.sId,
    this.trxId,
    this.iV,
    this.amountPaid,
    this.contact,
    this.coupon,
    this.createdAt,
    this.currentPeriodEnd,
    this.currentPeriodStart,
    this.package,
    this.price,
    this.status,
    this.updatedAt,
    this.workshop,
  });

  SubsriptionItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    trxId = json['trxId'];
    iV = json['__v'];
    amountPaid = (json['amountPaid'] as num?)?.toDouble();
    contact = json['contact'];
    coupon = json['coupon'];
    createdAt = json['createdAt'];
    currentPeriodEnd = json['currentPeriodEnd'];
    currentPeriodStart = json['currentPeriodStart'];
    package = json['package'];
    price = json['price'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    workshop = json['workshop'] is String
        ? json['workshop'] // it's already a string
        : json['workshop']?['_id']; // it's an object, get _id

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['trxId'] = trxId;
    data['__v'] = iV;
    data['amountPaid'] = amountPaid;
    data['contact'] = contact;
    data['coupon'] = coupon;
    data['createdAt'] = createdAt;
    data['currentPeriodEnd'] = currentPeriodEnd;
    data['currentPeriodStart'] = currentPeriodStart;
    data['package'] = package;
    data['price'] = price;
    data['status'] = status;
    data['updatedAt'] = updatedAt;
    data['workshop'] = workshop;
    return data;
  }
}
