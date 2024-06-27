class Variant {
  String? sId;
  String? name;
  VariantTypeId? variantTypeId;
  String? createdAt;
  String? updatedAt;

  Variant(
      {this.sId,
      this.name,
      this.variantTypeId,
      this.createdAt,
      this.updatedAt});

  Variant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    variantTypeId = json['variantTypeId'] != null
        ? new VariantTypeId.fromJson(json['variantTypeId'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.variantTypeId != null) {
      data['variantTypeId'] = this.variantTypeId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class VariantTypeId {
  String? sId;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;

  VariantTypeId(
      {this.sId, this.name, this.type, this.createdAt, this.updatedAt});

  VariantTypeId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
