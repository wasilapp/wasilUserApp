



class WalletCouponsPending {
  int? id;
  int? status;
  int? categoryId;
  int? order;
  int? shopRevenue;
  Null? adminRevenue;
  int? deliveryFee;
  double? total;
  int? otp;
  Null? couponDiscount;
  int? latitude;
  int? longitude;
  Null? couponId;
  int? deliveryBoyId;
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
  int? walletId;
  Null? expeditedFees;
  String? createdAt;
  String? updatedAt;
  Wallet? wallet;
  Statu? statu;

  WalletCouponsPending(
      {this.id,
        this.status,
        this.categoryId,
        this.order,
        this.shopRevenue,
        this.adminRevenue,
        this.deliveryFee,
        this.total,
        this.otp,
        this.couponDiscount,
        this.latitude,
        this.longitude,
        this.couponId,
        this.deliveryBoyId,
        this.userId,
        this.addressId,
        this.shopId,
        this.orderPaymentId,
        this.orderType,
        this.count,
        this.type,
        this.isNotification,
        this.isPaid,
        this.isWallet,
        this.walletId,
        this.expeditedFees,
        this.createdAt,
        this.updatedAt,
        this.wallet,
        this.statu});

  WalletCouponsPending.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    statu = json['statu'] != null ? new Statu.fromJson(json['statu']) : null;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    if (this.statu != null) {
      data['statu'] = this.statu!.toJson();
    }
    return data;
  }
}
class WalletCouponsAccepted {
  int? id;
  int? status;
  int? categoryId;
  int? order;
  int? shopRevenue;
  Null? adminRevenue;
  int? deliveryFee;
  double? total;
  int? otp;
  Null? couponDiscount;
  int? latitude;
  int? longitude;
  Null? couponId;
  int? deliveryBoyId;
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
  int? walletId;
  Null? expeditedFees;
  String? createdAt;
  String? updatedAt;
  Wallet? wallet;
  Statu? statu;

  WalletCouponsAccepted(
      {this.id,
        this.status,
        this.categoryId,
        this.order,
        this.shopRevenue,
        this.adminRevenue,
        this.deliveryFee,
        this.total,
        this.otp,
        this.couponDiscount,
        this.latitude,
        this.longitude,
        this.couponId,
        this.deliveryBoyId,
        this.userId,
        this.addressId,
        this.shopId,
        this.orderPaymentId,
        this.orderType,
        this.count,
        this.type,
        this.isNotification,
        this.isPaid,
        this.isWallet,
        this.walletId,
        this.expeditedFees,
        this.createdAt,
        this.updatedAt,
        this.wallet,
        this.statu});

  WalletCouponsAccepted.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    statu = json['statu'] != null ? new Statu.fromJson(json['statu']) : null;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    if (this.statu != null) {
      data['statu'] = this.statu!.toJson();
    }
    return data;
  }
}

class Wallet {
  int? id;
  Title? title;
  Title? description;
  int? usage;
  int? price;
  int? active;
  String? statu;
  int? shopId;
  int? subcategoryId;
  String? createdAt;
  String? updatedAt;

  Wallet(
      {this.id,
        this.title,
        this.description,
        this.usage,
        this.price,
        this.active,
        this.statu,
        this.shopId,
        this.subcategoryId,
        this.createdAt,
        this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? new Title.fromJson(json['description'])
        : null;
    usage = json['usage'];
    price = json['price'];
    active = json['active'];
    statu = json['statu'];
    shopId = json['shop_id'];
    subcategoryId = json['subcategory_id'];
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
    data['usage'] = this.usage;
    data['price'] = this.price;
    data['active'] = this.active;
    data['statu'] = this.statu;
    data['shop_id'] = this.shopId;
    data['subcategory_id'] = this.subcategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
