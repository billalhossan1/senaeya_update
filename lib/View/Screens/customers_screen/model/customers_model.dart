class CarResponse {

  CarData? data;

  CarResponse({ this.data});

  CarResponse.fromJson(Map<String, dynamic> json) {

    data = json['data'] != null ? CarData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};

    if (data != null) map['data'] = data!.toJson();
    return map;
  }
}

class CarData {
  List<CarResult>? result;

  CarData({ this.result});

  CarData.fromJson(Map<String, dynamic> json) {

    if (json['result'] != null) {
      result = List<CarResult>.from(
        json['result'].map((x) => CarResult.fromJson(x)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (result != null) {
      map['result'] = result!.map((x) => x.toJson()).toList();
    }
    return map;
  }
}


class CarResult {
  String? id;
  Brand? brand;
  String? year;
  String? vin;
  Client? client;
  String? carType;
  String? plateNumberForInternational;
  String? slugForSaudiCarPlateNumber;
  PlateNumberForSaudi? plateNumberForSaudi;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  CarResult({
    this.id,
    this.brand,
    this.year,
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

  CarResult.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    year = json['year'];
    vin = json['vin'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    carType = json['carType'];
    plateNumberForInternational = json['plateNumberForInternational'];
    slugForSaudiCarPlateNumber = json['slugForSaudiCarPlateNumber'];
    plateNumberForSaudi = json['plateNumberForSaudi'] != null
        ? PlateNumberForSaudi.fromJson(json['plateNumberForSaudi'])
        : null;
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (brand != null) map['brand'] = brand!.toJson();
    map['year'] = year;
    map['vin'] = vin;
    if (client != null) map['client'] = client!.toJson();
    map['carType'] = carType;
    map['plateNumberForInternational'] = plateNumberForInternational;
    map['slugForSaudiCarPlateNumber'] = slugForSaudiCarPlateNumber;
    if (plateNumberForSaudi != null) {
      map['plateNumberForSaudi'] = plateNumberForSaudi!.toJson();
    }
    map['isDeleted'] = isDeleted;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

class Brand {
  String? id;
  String? image;
  String? title;
  Country? country;

  Brand({this.id, this.image, this.title, this.country});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
    title = json['title'];
    country = json['country'] != null
        ? Country.fromJson(json['country'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['image'] = image;
    map['title'] = title;
    if (country != null) map['country'] = country!.toJson();
    return map;
  }
}

class Country {
  String? id;
  String? image;
  String? title;

  Country({this.id, this.image, this.title});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'title': title,
    };
  }
}

class Client {
  String? status;
  String? id;
  String? providerWorkShopId;
  String? clientType;
  ClientId? clientId;
  String? contact;
  List<String>? cars;
  List<dynamic>? invoices;
  String? document;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? v;

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

  Client.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['_id'];
    providerWorkShopId = json['providerWorkShopId'];
    clientType = json['clientType'];
    clientId =
    json['clientId'] != null ? ClientId.fromJson(json['clientId']) : null;
    contact = json['contact'];
    cars = json['cars'] != null ? List<String>.from(json['cars']) : [];
    invoices = json['invoices'];
    document = json['document'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['providerWorkShopId'] = providerWorkShopId;
    map['clientType'] = clientType;
    if (clientId != null) map['clientId'] = clientId!.toJson();
    map['contact'] = contact;
    map['cars'] = cars;
    map['invoices'] = invoices;
    map['document'] = document;
    map['isDeleted'] = isDeleted;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
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
  String? createdAt;
  String? updatedAt;
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

  ClientId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    role = json['role'];
    contact = json['contact'];
    image = json['image'];
    status = json['status'];
    verified = json['verified'];
    isDeleted = json['isDeleted'];
    stripeCustomerId = json['stripeCustomerId'];
    helperUserId = json['helperUserId'];
    subscribedPackage = json['subscribedPackage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['role'] = role;
    map['contact'] = contact;
    map['image'] = image;
    map['status'] = status;
    map['verified'] = verified;
    map['isDeleted'] = isDeleted;
    map['stripeCustomerId'] = stripeCustomerId;
    map['helperUserId'] = helperUserId;
    map['subscribedPackage'] = subscribedPackage;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class PlateNumberForSaudi {
  String? symbol;
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

  PlateNumberForSaudi.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    numberEnglish = json['numberEnglish'];
    numberArabic = json['numberArabic'];
    alphabetsCombinations =
    json['alphabetsCombinations'] != null ? List<String>.from(json['alphabetsCombinations']) : [];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['symbol'] = symbol;
    map['numberEnglish'] = numberEnglish;
    map['numberArabic'] = numberArabic;
    map['alphabetsCombinations'] = alphabetsCombinations;
    map['_id'] = id;
    return map;
  }
}
