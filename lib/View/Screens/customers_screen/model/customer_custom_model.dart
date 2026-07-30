class CustomerCustomModel{
  String? id;
  String? name;
  String? phone;
  bool? isWarning;

  CustomerCustomModel({required this.id,required this.name,required this.phone,required this.isWarning});

  // factory CustomerCustomModel.fromJson(Map<String, dynamic> json) {
  //   return CustomerCustomModel(
  //     id: json['id'] as String?,
  //     name: json['name'] as String?,
  //     email: json['email'] as String?,
  //     phone: json['phone'] as String?,
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'email': email,
  //     'phone': phone,
  //   };
  // }
}