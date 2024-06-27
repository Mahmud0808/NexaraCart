class Order {
  ShippingAddress? shippingAddress;
  OrderTotal? orderTotal;
  String? sId;
  UserID? userID;
  String? orderStatus;
  List<Items>? items;
  double? totalPrice;
  String? paymentMethod;
  CouponCode? couponCode;
  String? trackingUrl;
  String? orderDate;
  int? iV;

  Order(
      {this.shippingAddress,
        this.orderTotal,
        this.sId,
        this.userID,
        this.orderStatus,
        this.items,
        this.totalPrice,
        this.paymentMethod,
        this.couponCode,
        this.trackingUrl,
        this.orderDate,
        this.iV});

  Order.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    orderTotal = json['orderTotal'] != null
        ? OrderTotal.fromJson(json['orderTotal'])
        : null;
    sId = json['_id'];
    userID =
    json['userID'] != null ? UserID.fromJson(json['userID']) : null;
    orderStatus = json['orderStatus'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    totalPrice = json['totalPrice']?.toDouble();
    paymentMethod = json['paymentMethod'];
    couponCode = json['couponCode'] != null
        ? CouponCode.fromJson(json['couponCode'])
        : null;
    trackingUrl = json['trackingUrl'];
    orderDate = json['orderDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    if (orderTotal != null) {
      data['orderTotal'] = orderTotal!.toJson();
    }
    data['_id'] = sId;
    if (userID != null) {
      data['userID'] = userID!.toJson();
    }
    data['orderStatus'] = orderStatus;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['paymentMethod'] = paymentMethod;
    if (couponCode != null) {
      data['couponCode'] = couponCode!.toJson();
    }
    data['trackingUrl'] = trackingUrl;
    data['orderDate'] = orderDate;
    data['__v'] = iV;
    return data;
  }
}

class ShippingAddress {
  String? phone;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  ShippingAddress(
      {this.phone,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      this.country});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['postalCode'] = postalCode;
    data['country'] = country;
    return data;
  }
}

class OrderTotal {
  double? subTotal;
  double? discount;
  double? total;

  OrderTotal({this.subTotal, this.discount, this.total});

  OrderTotal.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal']?.toDouble();
    discount = json['discount']?.toDouble();
    total = json['total']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subTotal;
    data['discount'] = discount;
    data['total'] = total;
    return data;
  }
}

class UserID {
  String? sId;
  String? name;

  UserID({this.sId, this.name});

  UserID.fromJson(Map<String, dynamic> json) {
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

class Items {
  String? productID;
  String? productName;
  int? quantity;
  double? price;
  String? variant;
  String? sId;

  Items(
      {this.productID,
        this.productName,
        this.quantity,
        this.price,
        this.variant,
        this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    quantity = json['quantity'];
    price = json['price']?.toDouble();
    variant = json['variant'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productID'] = productID;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['variant'] = variant;
    data['_id'] = sId;
    return data;
  }
}

class CouponCode {
  String? sId;
  String? couponCode;
  String? discountType;
  int? discountAmount;

  CouponCode(
      {this.sId, this.couponCode, this.discountType, this.discountAmount});

  CouponCode.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponCode = json['couponCode'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['couponCode'] = couponCode;
    data['discountType'] = discountType;
    data['discountAmount'] = discountAmount;
    return data;
  }
}