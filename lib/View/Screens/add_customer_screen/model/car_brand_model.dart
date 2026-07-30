class CarBrandResponse {

  final CarBrandData data;

  CarBrandResponse({

    required this.data,
  });

  factory CarBrandResponse.fromJson(Map<String, dynamic> json) {
    return CarBrandResponse(

      data: CarBrandData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class CarBrandData {
  final List<CarBrand> result;

  CarBrandData({required this.result});

  factory CarBrandData.fromJson(Map<String, dynamic> json) {
    return CarBrandData(
      result: List<CarBrand>.from(
        (json['result'] as List).map((x) => CarBrand.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': List<dynamic>.from(result.map((x) => x.toJson())),
    };
  }
}

class CarBrand {
  final String id;
  final String image;
  final String title;
  final String? country;

  CarBrand({
    required this.id,
    required this.image,
    required this.title,
    this.country,
  });

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      id: json['_id'],
      image: json['image'],
      title: json['title'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'title': title,
      'country': country,
    };
  }
}
