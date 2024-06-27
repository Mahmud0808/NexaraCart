class Brand {
  String? sId;
  String? name;
  SubcategoryId? subcategoryId;
  String? createdAt;
  String? updatedAt;

  Brand(
      {this.sId,
        this.name,
        this.subcategoryId,
        this.createdAt,
        this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    subcategoryId = json['subcategoryId'] != null
        ? SubcategoryId.fromJson(json['subcategoryId'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    if (subcategoryId != null) {
      data['subcategoryId'] = subcategoryId!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SubcategoryId {
  String? sId;
  String? name;
  String? categoryId;
  String? createdAt;
  String? updatedAt;

  SubcategoryId(
      {this.sId, this.name, this.categoryId, this.createdAt, this.updatedAt});

  SubcategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    categoryId = json['categoryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['categoryId'] = categoryId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}