class Coupon {
  String? sId;
  String? couponCode;
  String? discountType;
  double? discountAmount;
  double? minimumPurchaseAmount;
  String? endDate;
  String? status;
  String? applicableCategory;
  Null applicableSubCategory;
  Null applicableProduct;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Coupon(
      {this.sId,
      this.couponCode,
      this.discountType,
      this.discountAmount,
      this.minimumPurchaseAmount,
      this.endDate,
      this.status,
      this.applicableCategory,
      this.applicableSubCategory,
      this.applicableProduct,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Coupon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponCode = json['couponCode'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount']?.toDouble();
    minimumPurchaseAmount = json['minimumPurchaseAmount']?.toDouble();
    endDate = json['endDate'];
    status = json['status'];
    applicableCategory = json['applicableCategory'];
    applicableSubCategory = json['applicableSubCategory'];
    applicableProduct = json['applicableProduct'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['couponCode'] = couponCode;
    data['discountType'] = discountType;
    data['discountAmount'] = discountAmount;
    data['minimumPurchaseAmount'] = minimumPurchaseAmount;
    data['endDate'] = endDate;
    data['status'] = status;
    data['applicableCategory'] = applicableCategory;
    data['applicableSubCategory'] = applicableSubCategory;
    data['applicableProduct'] = applicableProduct;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
