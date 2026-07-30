class ClientByCarModel {
  bool? success;
  String? message;
  int? statusCode;
  List<ClientItem>? clientList;

  ClientByCarModel({
    this.success,
    this.message,
    this.statusCode,
    this.clientList,
  });

  ClientByCarModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      clientList = <ClientItem>[];
      json['data'].forEach((v) {
        clientList!.add(ClientItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (clientList != null) {
      data['data'] = clientList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientItem {
  String? sId;
  String? providerWorkShopId;
  String? clientType;
  String? contact;
  String? workShopNameAsClient;
  List<String>? cars;
  bool? isWarning;
  List<dynamic>? invoices;
  String? documentNumber;
  bool? isDeleted;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  ClientId? clientId;

  ClientItem({
    this.sId,
    this.providerWorkShopId,
    this.clientType,
    this.contact,
    this.workShopNameAsClient,
    this.cars,
    this.invoices,
    this.documentNumber,
    this.isDeleted,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.clientId,
    this.isWarning
  });

  ClientItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    providerWorkShopId = json['providerWorkShopId'];
    clientType = json['clientType'];
    contact = json['contact'];
    workShopNameAsClient = json['workShopNameAsClient'];
    cars = json['cars'] != null ? List<String>.from(json['cars']) : [];
    invoices = json['invoices'] ?? [];
    documentNumber = json['documentNumber'];
    isDeleted = json['isDeleted'];
    status = json['status'];
    createdAt = json['createdAt'];
    isWarning = json['hasPaymentIssues'] ?? false;
    updatedAt = json['updatedAt'];
    iV = json['__v'];

    // ✅ Handle nested clientId object or null
    if (json['clientId'] != null && json['clientId'] is Map<String, dynamic>) {
      clientId = ClientId.fromJson(json['clientId']);
    } else {
      clientId = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['providerWorkShopId'] = providerWorkShopId;
    data['clientType'] = clientType;
    data['contact'] = contact;
    data['workShopNameAsClient'] = workShopNameAsClient;
    data['cars'] = cars;
    data['invoices'] = invoices;
    data['documentNumber'] = documentNumber;
    data['isDeleted'] = isDeleted;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (clientId != null) {
      data['clientId'] = clientId!.toJson();
    }
    return data;
  }
}

class ClientId {
  String? sId;
  String? name;

  ClientId({this.sId, this.name});

  ClientId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
