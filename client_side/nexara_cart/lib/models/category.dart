class Category {
  String? sId;
  String? name;
  String? image;
  bool isSelected;
  String? createdAt;
  String? updatedAt;

  Category({
    this.sId,
    this.name,
    this.image,
    this.isSelected = false,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json)
      : sId = json['_id'],
        name = json['name'],
        image = json['image'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        isSelected = false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
