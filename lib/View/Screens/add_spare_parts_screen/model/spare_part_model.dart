class SparePartByCode {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  SparePartByCode({this.success, this.message, this.statusCode, this.data});

  SparePartByCode.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Meta? meta;
  List<SparePartResult>? result;

  Data({this.meta, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['result'] != null) {
      result = <SparePartResult>[];
      json['result'].forEach((v) {
        result!.add(SparePartResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPage'] = totalPage;
    return data;
  }
}

class SparePartResult {
  String? sId;
  Title? title;
  String? itemName;
  ProviderWorkShop? providerWorkShopId;
  String? type;
  String? code;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  SparePartResult({
    this.sId,
    this.title,
    this.itemName,
    this.providerWorkShopId,
    this.type,
    this.code,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  SparePartResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    itemName = json['itemName'];
    providerWorkShopId = json['providerWorkShopId'] != null
        ? ProviderWorkShop.fromJson(json['providerWorkShopId'])
        : null;
    type = json['type'];
    code = json['code'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['itemName'] = itemName;
    if (providerWorkShopId != null) {
      data['providerWorkShopId'] = providerWorkShopId!.toJson();
    }
    data['type'] = type;
    data['code'] = code;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ProviderWorkShop {
  String? sId;
  String? workshopNameEnglish;
  String? workshopNameArabic;

  ProviderWorkShop({
    this.sId,
    this.workshopNameEnglish,
    this.workshopNameArabic,
  });

  ProviderWorkShop.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    workshopNameEnglish = json['workshopNameEnglish'];
    workshopNameArabic = json['workshopNameArabic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['workshopNameEnglish'] = workshopNameEnglish;
    data['workshopNameArabic'] = workshopNameArabic;
    return data;
  }
}

class Title {
  String? ar;
  String? bn;
  String? ur;
  String? hi;
  String? tl;
  String? en;
  String? sId;

  Title({this.ar, this.bn, this.ur, this.hi, this.tl, this.en, this.sId});

  Title.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    bn = json['bn'];
    ur = json['ur'];
    hi = json['hi'];
    tl = json['tl'];
    en = json['en'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    data['bn'] = bn;
    data['ur'] = ur;
    data['hi'] = hi;
    data['tl'] = tl;
    data['en'] = en;
    data['_id'] = sId;
    return data;
  }

  // Helper method to get localized title
  String getLocalizedTitle(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return ar ?? en ?? '';
      case 'bn':
        return bn ?? en ?? '';
      case 'ur':
        return ur ?? en ?? '';
      case 'hi':
        return hi ?? en ?? '';
      case 'tl':
        return tl ?? en ?? '';
      default:
        return en ?? '';
    }
  }
}
