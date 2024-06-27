class Brand {
  String? sId;
  String? name;
  SubcategoryId? subCategoryId;
  String? createdAt;
  String? updatedAt;

  Brand(
      {this.sId,
      this.name,
      this.subCategoryId,
      this.createdAt,
      this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    subCategoryId = json['subcategoryId'] != null
        ? new SubcategoryId.fromJson(json['subcategoryId'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.subCategoryId != null) {
      data['subcategoryId'] = this.subCategoryId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
