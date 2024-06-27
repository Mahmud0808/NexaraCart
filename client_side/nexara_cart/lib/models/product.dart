class Product {
  String? sId;
  String? name;
  String? description;
  int? quantity;
  double? price;
  double? offerPrice;
  ProRef? proCategoryId;
  ProRef? proSubCategoryId;
  ProRef? proBrandId;
  ProTypeRef? proVariantTypeId;
  List<String>? proVariantId;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product(
      {this.sId,
        this.name,
        this.description,
        this.quantity,
        this.price,
        this.offerPrice,
        this.proCategoryId,
        this.proSubCategoryId,
        this.proBrandId,
        this.proVariantTypeId,
        this.proVariantId,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price']?.toDouble();
    offerPrice = json['offerPrice']?.toDouble();
    proCategoryId = json['proCategoryId'] != null
        ? ProRef.fromJson(json['proCategoryId'])
        : null;
    proSubCategoryId = json['proSubCategoryId'] != null
        ? ProRef.fromJson(json['proSubCategoryId'])
        : null;
    proBrandId = json['proBrandId'] != null
        ? ProRef.fromJson(json['proBrandId'])
        : null;
    proVariantTypeId = json['proVariantTypeId'] != null
        ? ProTypeRef.fromJson(json['proVariantTypeId'])
        : null;
    proVariantId = json['proVariantId'].cast<String>();
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['quantity'] = quantity;
    data['price'] = price;
    data['offerPrice'] = offerPrice;
    if (proCategoryId != null) {
      data['proCategoryId'] = proCategoryId!.toJson();
    }
    if (proSubCategoryId != null) {
      data['proSubCategoryId'] = proSubCategoryId!.toJson();
    }
    if (proBrandId != null) {
      data['proBrandId'] = proBrandId!.toJson();
    }
    if (proVariantTypeId != null) {
      data['proVariantTypeId'] = proVariantTypeId!.toJson();
    }
    data['proVariantId'] = proVariantId;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ProRef {
  String? sId;
  String? name;

  ProRef({this.sId, this.name});

  ProRef.fromJson(Map<String, dynamic> json) {
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

class ProTypeRef {
  String? sId;
  String? type;

  ProTypeRef({this.sId, this.type});

  ProTypeRef.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    return data;
  }
}

class Images {
  int? image;
  String? url;
  String? sId;

  Images({this.image, this.url, this.sId});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['url'] = url;
    data['_id'] = sId;
    return data;
  }
}