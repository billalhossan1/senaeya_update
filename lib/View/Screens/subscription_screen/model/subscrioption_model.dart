class SubscriptionResponseModel {
  bool? success;
  String? message;
  int? statusCode;
  List<SubscriptionItem>? subscriptionList;

  SubscriptionResponseModel({this.success, this.message, this.statusCode, this.subscriptionList});

  SubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];

    // Normalize different backend shapes for `data`:
    // - data can be a List (direct list of items)
    // - data can be a Map containing a `packages` (or similar) list
    // - data can be a single object representing one item
    final dynamic data = json['data'];
    if (data == null) {
      subscriptionList = null;
    } else {
      subscriptionList = <SubscriptionItem>[];
      if (data is List) {
        for (var v in data) {
          if (v is Map<String, dynamic>) {
            subscriptionList!.add(SubscriptionItem.fromJson(Map<String, dynamic>.from(v)));
          }
        }
      } else if (data is Map) {
        // Common key used by API: 'packages'
        List? listCandidate;
        if (data.containsKey('packages') && data['packages'] is List) {
          listCandidate = data['packages'];
        } else if (data.containsKey('subscriptionList') && data['subscriptionList'] is List) {
          listCandidate = data['subscriptionList'];
        } else if (data.values.any((v) => v is List)) {
          // pick the first List value (fallback)
          listCandidate = data.values.firstWhere((v) => v is List, orElse: () => null) as List?;
        } else if (data.containsKey('_id') || data.containsKey('title')) {
          // single item object
          listCandidate = [data];
        }

        if (listCandidate != null) {
          for (var v in listCandidate) {
            if (v is Map<String, dynamic>) {
              subscriptionList!.add(SubscriptionItem.fromJson(Map<String, dynamic>.from(v)));
            }
          }
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (subscriptionList != null) {
      // Serialize back under 'packages' to match API shape that returns packages inside data
      data['data'] = {'packages': subscriptionList!.map((v) => v.toJson()).toList()};
    }
    return data;
  }
}

class SubscriptionItem {
  String? sId;
  String? title;
  String? description;
  List<String>? features;
  dynamic price;
  dynamic monthlyBasePrice;
  dynamic cutOffprice;
  String? duration;
  String? paymentType;
  String? subscriptionType;
  String? status;
  bool? isDeleted;
  dynamic discountPercentage;
  String? createdAt;
  String? updatedAt;
  dynamic yearlyBasePrice;

  SubscriptionItem(
      {this.sId,
        this.title,
        this.description,
        this.features,
        this.price,
        this.monthlyBasePrice,
        this.duration,
        this.paymentType,
        this.subscriptionType,
        this.status,
        this.isDeleted,
        this.cutOffprice,
        this.discountPercentage,
        this.createdAt,
        this.updatedAt,
        this.yearlyBasePrice});

  SubscriptionItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    // Robust parsing for features: backend may return a List, String, Map or null
    final rawFeatures = json['features'];
    if (rawFeatures == null) {
      features = null;
    } else if (rawFeatures is List) {
      features = rawFeatures.map((e) => e?.toString() ?? '').where((s) => s.isNotEmpty).toList();
    } else if (rawFeatures is String) {
      // Single string -> wrap into list
      features = [rawFeatures];
    } else if (rawFeatures is Map) {
      // Try common keys, else take first value
      if (rawFeatures.containsKey('name')) {
        features = [rawFeatures['name'].toString()];
      } else if (rawFeatures.values.isNotEmpty) {
        features = [rawFeatures.values.first.toString()];
      } else {
        features = [rawFeatures.toString()];
      }
    } else {
      // Fallback: stringify
      features = [rawFeatures.toString()];
    }
    price = json['price'];
    monthlyBasePrice = json['monthlyBasePrice'];
    duration = json['duration'];
    cutOffprice = json['cutOffprice'];
    paymentType = json['paymentType'];
    subscriptionType = json['subscriptionType'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    discountPercentage = json['discountPercentage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    yearlyBasePrice = json['yearlyBasePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['features'] = features;
    data['price'] = price;
    data['monthlyBasePrice'] = monthlyBasePrice;
    data['duration'] = duration;
    data['paymentType'] = paymentType;
    data['cutOffprice'] = cutOffprice;
    data['subscriptionType'] = subscriptionType;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['discountPercentage'] = discountPercentage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['yearlyBasePrice'] = yearlyBasePrice;
    return data;
  }
}
