class MyOrder {
  int? id;
  int? status;
  int? categoryId;
  int? order;
  int? shopRevenue;
  Null? adminRevenue;
  int? deliveryFee;
  int? total;
  int? otp;
  Null? couponDiscount;
  double? latitude;
  double? longitude;
  Null? couponId;
  Null? deliveryBoyId;
  int? userId;
  int? addressId;
  int? shopId;
  int? orderPaymentId;
  String? orderType;
  int? count;
  int? type;
  int? isNotification;
  int? isPaid;
  int? isWallet;
  Null? walletId;
  Null? expeditedFees;
  Null? cancellationReason;
  String? createdAt;
  String? updatedAt;
  Statu? statu;
  List<Carts>? carts;
  Null? coupon;
  Address? address;
  Shop? shop;
  User? user;
  OrderPayment? orderPayment;
  Null? deliveryBoy;

  MyOrder({this.id, this.status, this.categoryId, this.order, this.shopRevenue, this.adminRevenue, this.deliveryFee, this.total, this.otp, this.couponDiscount, this.latitude, this.longitude, this.couponId, this.deliveryBoyId, this.userId, this.addressId, this.shopId, this.orderPaymentId, this.orderType, this.count, this.type, this.isNotification, this.isPaid, this.isWallet, this.walletId, this.expeditedFees, this.cancellationReason, this.createdAt, this.updatedAt, this.statu, this.carts, this.coupon, this.address, this.shop, this.user, this.orderPayment, this.deliveryBoy});

  MyOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    categoryId = json['category_id'];
    order = json['order'];
    shopRevenue = json['shop_revenue'];
    adminRevenue = json['admin_revenue'];
    deliveryFee = json['delivery_fee'];
    total = json['total'];
    otp = json['otp'];
    couponDiscount = json['coupon_discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    couponId = json['coupon_id'];
    deliveryBoyId = json['delivery_boy_id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    shopId = json['shop_id'];
    orderPaymentId = json['order_payment_id'];
    orderType = json['order_type'];
    count = json['count'];
    type = json['type'];
    isNotification = json['is_notification'];
    isPaid = json['is_paid'];
    isWallet = json['is_wallet'];
    walletId = json['wallet_id'];
    expeditedFees = json['expedited_fees'];
    cancellationReason = json['cancellation_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statu = json['statu'] != null ? new Statu.fromJson(json['statu']) : null;
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) { carts!.add(new Carts.fromJson(v)); });
    }
    coupon = json['coupon'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    orderPayment = json['order_payment'] != null ? new OrderPayment.fromJson(json['order_payment']) : null;
    deliveryBoy = json['delivery_boy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    data['order'] = this.order;
    data['shop_revenue'] = this.shopRevenue;
    data['admin_revenue'] = this.adminRevenue;
    data['delivery_fee'] = this.deliveryFee;
    data['total'] = this.total;
    data['otp'] = this.otp;
    data['coupon_discount'] = this.couponDiscount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['coupon_id'] = this.couponId;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['user_id'] = this.userId;
    data['address_id'] = this.addressId;
    data['shop_id'] = this.shopId;
    data['order_payment_id'] = this.orderPaymentId;
    data['order_type'] = this.orderType;
    data['count'] = this.count;
    data['type'] = this.type;
    data['is_notification'] = this.isNotification;
    data['is_paid'] = this.isPaid;
    data['is_wallet'] = this.isWallet;
    data['wallet_id'] = this.walletId;
    data['expedited_fees'] = this.expeditedFees;
    data['cancellation_reason'] = this.cancellationReason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.statu != null) {
      data['statu'] = this.statu!.toJson();
    }
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    data['coupon'] = this.coupon;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.orderPayment != null) {
      data['order_payment'] = this.orderPayment!.toJson();
    }
    data['delivery_boy'] = this.deliveryBoy;
    return data;
  }
}

class Statu {
  int? id;
  Title? title;

  Statu({this.id, this.title});

  Statu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    return data;
  }
}

class Title {
  String? en;
  String? ar;

  Title({this.en, this.ar});

  Title.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}

class Carts {
  int? id;
  int? orderId;
  int? subCategoriesId;
  int? quantity;
  int? price;
  int? total;
  String? createdAt;
  String? updatedAt;
  SubCategory? subCategory;

  Carts({this.id, this.orderId, this.subCategoriesId, this.quantity, this.price, this.total, this.createdAt, this.updatedAt, this.subCategory});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    subCategoriesId = json['sub_categories_id'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subCategory = json['sub_category'] != null ? new SubCategory.fromJson(json['sub_category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['sub_categories_id'] = this.subCategoriesId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.toJson();
    }
    return data;
  }
}

class SubCategory {
  int? id;
  Title? title;
  Title? description;
  dynamic? price;
  int? shopId;
  int? categoryId;
  int? active;
  int? isPrimary;
  String? imageUrl;
  int? isApproval;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  SubCategory({this.id, this.title, this.description, this.price, this.shopId, this.categoryId, this.active, this.isPrimary, this.imageUrl, this.isApproval, this.quantity, this.createdAt, this.updatedAt});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    description = json['description'] != null ? new Title.fromJson(json['description']) : null;
    price = json['price'];
    shopId = json['shop_id'];
    categoryId = json['category_id'];
    active = json['active'];
    isPrimary = json['is_primary'];
    imageUrl = json['image_url'];
    isApproval = json['is_approval'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['price'] = this.price;
    data['shop_id'] = this.shopId;
    data['category_id'] = this.categoryId;
    data['active'] = this.active;
    data['is_primary'] = this.isPrimary;
    data['image_url'] = this.imageUrl;
    data['is_approval'] = this.isApproval;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Address {
  int? id;
  String? longitude;
  String? latitude;
  int? distance;
  String? name;
  String? street;
  String? buildingNumber;
  String? city;
  int? defaultt;
  int? apartmentNum;
  int? active;
  int? type;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Address({this.id, this.longitude, this.latitude, this.distance, this.name, this.street, this.buildingNumber, this.city, this.defaultt, this.apartmentNum, this.active, this.type, this.userId, this.createdAt, this.updatedAt});

Address.fromJson(Map<String, dynamic> json) {
id = json['id'];
longitude = json['longitude'];
latitude = json['latitude'];
distance = json['distance'];
name = json['name'];
street = json['street'];
buildingNumber = json['building_number'];
city = json['city'];
defaultt = json['default'];
apartmentNum = json['apartment_num'];
active = json['active'];
type = json['type'];
userId = json['user_id'];
createdAt = json['created_at'];
updatedAt = json['updated_at'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['longitude'] = this.longitude;
data['latitude'] = this.latitude;
data['distance'] = this.distance;
data['name'] = this.name;
data['street'] = this.street;
data['building_number'] = this.buildingNumber;
data['city'] = this.city;
data['default'] = this.defaultt;
data['apartment_num'] = this.apartmentNum;
data['active'] = this.active;
data['type'] = this.type;
data['user_id'] = this.userId;
data['created_at'] = this.createdAt;
data['updated_at'] = this.updatedAt;
return data;
}
}

class Shop {
int? id;
Title? name;
Null? email;
Null? mobile;
String? barcode;
double? latitude;
double? longitude;
String? address;
Null? imageUrl;
int? rating;
int? deliveryRange;
int? totalRating;
int? defaultTax;
int? availableForDelivery;
int? open;
int? managerId;
int? categoryId;
int? distance;
String? createdAt;
String? updatedAt;

Shop({this.id, this.name, this.email, this.mobile, this.barcode, this.latitude, this.longitude, this.address, this.imageUrl, this.rating, this.deliveryRange, this.totalRating, this.defaultTax, this.availableForDelivery, this.open, this.managerId, this.categoryId, this.distance, this.createdAt, this.updatedAt});

Shop.fromJson(Map<String, dynamic> json) {
id = json['id'];
name = json['name'] != null ? new Title.fromJson(json['name']) : null;
email = json['email'];
mobile = json['mobile'];
barcode = json['barcode'];
latitude = json['latitude'];
longitude = json['longitude'];
address = json['address'];
imageUrl = json['image_url'];
rating = json['rating'];
deliveryRange = json['delivery_range'];
totalRating = json['total_rating'];
defaultTax = json['default_tax'];
availableForDelivery = json['available_for_delivery'];
open = json['open'];
managerId = json['manager_id'];
categoryId = json['category_id'];
distance = json['distance'];
createdAt = json['created_at'];
updatedAt = json['updated_at'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
if (this.name != null) {
data['name'] = this.name!.toJson();
}
data['email'] = this.email;
data['mobile'] = this.mobile;
data['barcode'] = this.barcode;
data['latitude'] = this.latitude;
data['longitude'] = this.longitude;
data['address'] = this.address;
data['image_url'] = this.imageUrl;
data['rating'] = this.rating;
data['delivery_range'] = this.deliveryRange;
data['total_rating'] = this.totalRating;
data['default_tax'] = this.defaultTax;
data['available_for_delivery'] = this.availableForDelivery;
data['open'] = this.open;
data['manager_id'] = this.managerId;
data['category_id'] = this.categoryId;
data['distance'] = this.distance;
data['created_at'] = this.createdAt;
data['updated_at'] = this.updatedAt;
return data;
}
}

class User {
int? id;
String? name;
String? email;
Null? emailVerifiedAt;
String? mobile;
int? mobileVerified;
String? fcmToken;
Null? avatarUrl;
int? blocked;
int? accountType;
int? defaultt;
String? referrer;
Null? referrerLink;
Null? otp;
Null? otpExpiration;
String? createdAt;
String? updatedAt;

User({this.id, this.name, this.email, this.emailVerifiedAt, this.mobile, this.mobileVerified, this.fcmToken, this.avatarUrl, this.blocked, this.accountType, this.defaultt, this.referrer, this.referrerLink, this.otp, this.otpExpiration, this.createdAt, this.updatedAt});

User.fromJson(Map<String, dynamic> json) {
id = json['id'];
name = json['name'];
email = json['email'];
emailVerifiedAt = json['email_verified_at'];
mobile = json['mobile'];
mobileVerified = json['mobile_verified'];
fcmToken = json['fcm_token'];
avatarUrl = json['avatar_url'];
blocked = json['blocked'];
accountType = json['account_type'];
defaultt = json['default'];
referrer = json['referrer'];
referrerLink = json['referrer_link'];
otp = json['otp'];
otpExpiration = json['otp_expiration'];
createdAt = json['created_at'];
updatedAt = json['updated_at'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['name'] = this.name;
data['email'] = this.email;
data['email_verified_at'] = this.emailVerifiedAt;
data['mobile'] = this.mobile;
data['mobile_verified'] = this.mobileVerified;
data['fcm_token'] = this.fcmToken;
data['avatar_url'] = this.avatarUrl;
data['blocked'] = this.blocked;
data['account_type'] = this.accountType;
data['default'] = this.defaultt;
data['referrer'] = this.referrer;
data['referrer_link'] = this.referrerLink;
data['otp'] = this.otp;
data['otp_expiration'] = this.otpExpiration;
data['created_at'] = this.createdAt;
data['updated_at'] = this.updatedAt;
return data;
}
}

class OrderPayment {
int? id;
int? paymentType;
int? success;
Null? paymentId;
String? createdAt;
String? updatedAt;

OrderPayment({this.id, this.paymentType, this.success, this.paymentId, this.createdAt, this.updatedAt});

OrderPayment.fromJson(Map<String, dynamic> json) {
id = json['id'];
paymentType = json['payment_type'];
success = json['success'];
paymentId = json['payment_id'];
createdAt = json['created_at'];
updatedAt = json['updated_at'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['payment_type'] = this.paymentType;
data['success'] = this.success;
data['payment_id'] = this.paymentId;
data['created_at'] = this.createdAt;
data['updated_at'] = this.updatedAt;
return data;
}
}


