class CommonListModel {

  List<CommonItemModel>? data;

  CommonListModel({ this.data});

  CommonListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      data = <CommonItemModel>[];
      json['data'].forEach((v) {
        if (v != null) {
          data!.add(CommonItemModel.fromJson(v));
        }
      });
    } else {
      data = <CommonItemModel>[]; // Always initialize to an empty list
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonItemModel {
  String? sId;
  String? image;
  String? title;

  CommonItemModel({this.sId, this.image, this.title});

  CommonItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}
class WorkshopWorksModel {
  bool? success;
  String? message;
  int? statusCode;
  List<WorkItem>? worksList;

  WorkshopWorksModel({this.success, this.message, this.statusCode, this.worksList});

  WorkshopWorksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      worksList = <WorkItem>[];
      json['data'].forEach((v) {
        worksList!.add(WorkItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (worksList != null) {
      data['data'] = worksList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkItem {
  String? sId;
  String? workCategoryName;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? image;
  WorkTitle? title;
  WorkDescription? description;

  WorkItem({
    this.sId,
    this.workCategoryName,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.image,
    this.title,
    this.description,
  });

  WorkItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    workCategoryName = json['workCategoryName'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
    title = json['title'] != null ? WorkTitle.fromJson(json['title']) : null;
    description = json['description'] != null ? WorkDescription.fromJson(json['description']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['workCategoryName'] = workCategoryName;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['image'] = image;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    return data;
  }

  // Get localized title based on current locale
  String getLocalizedTitle(String locale) {
    if (title == null) return workCategoryName ?? '';

    switch (locale) {
      case 'ar':
        return title!.ar ?? workCategoryName ?? '';
      case 'bn':
        return title!.bn ?? workCategoryName ?? '';
      case 'ur':
        return title!.ur ?? workCategoryName ?? '';
      case 'hi':
        return title!.hi ?? workCategoryName ?? '';
      case 'fil':
      case 'tl':
        return title!.tl ?? workCategoryName ?? '';
      case 'en':
      default:
        return title!.en ?? workCategoryName ?? '';
    }
  }
}

class WorkTitle {
  String? ar;
  String? bn;
  String? ur;
  String? hi;
  String? tl;
  String? en;
  String? id;

  WorkTitle({
    this.ar,
    this.bn,
    this.ur,
    this.hi,
    this.tl,
    this.en,
    this.id,
  });

  WorkTitle.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    bn = json['bn'];
    ur = json['ur'];
    hi = json['hi'];
    tl = json['tl'];
    en = json['en'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ar'] = ar;
    data['bn'] = bn;
    data['ur'] = ur;
    data['hi'] = hi;
    data['tl'] = tl;
    data['en'] = en;
    data['_id'] = id;
    return data;
  }
}

class WorkDescription {
  String? ar;
  String? bn;
  String? ur;
  String? hi;
  String? tl;
  String? en;
  String? id;

  WorkDescription({
    this.ar,
    this.bn,
    this.ur,
    this.hi,
    this.tl,
    this.en,
    this.id,
  });

  WorkDescription.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    bn = json['bn'];
    ur = json['ur'];
    hi = json['hi'];
    tl = json['tl'];
    en = json['en'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ar'] = ar;
    data['bn'] = bn;
    data['ur'] = ur;
    data['hi'] = hi;
    data['tl'] = tl;
    data['en'] = en;
    data['_id'] = id;
    return data;
  }
}
