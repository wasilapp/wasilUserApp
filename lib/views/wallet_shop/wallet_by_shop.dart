

class WalletByShop {
  int? id;
  int? counter;
  Title? title;
  Title? description;
  int? usage;
  int? price;
  int? active;
  String? imageUrl;

  String? statu;
  int? shopId;
  int? subcategoryId;
  String? createdAt;
  String? updatedAt;
  Shop? shop;
  SubCategory? subCategory;

  WalletByShop(
      {this.id,
        this.title,
        this.counter,
        this.description,
        this.usage,
        this.price,
        this.imageUrl,
        this.active,
        this.statu,
        this.shopId,
        this.subcategoryId,
        this.createdAt,
        this.updatedAt,
        this.shop,
        this.subCategory});

  WalletByShop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    counter =0;
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
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    subCategory = json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
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
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.toJson();
    }
    return data;
  }
  Map<String, dynamic> tooJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_categories_id'] = this.id;

    data['price'] = this.price;

    data['total'] = this.counter;

    data['quantity'] =this.id;


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

class Shop {
  int? id;
  Title? name;
  String? email;
  String? mobile;
  String? barcode;
  dynamic? latitude;
  dynamic? longitude;
  String? address;
  String? imageUrl;
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

  Shop(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.barcode,
        this.latitude,
        this.longitude,
        this.address,
        this.imageUrl,
        this.rating,
        this.deliveryRange,
        this.totalRating,
        this.defaultTax,
        this.availableForDelivery,
        this.open,
        this.managerId,
        this.categoryId,
        this.distance,
        this.createdAt,
        this.updatedAt});

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

class SubCategory {
  int? id;
  Title? title;
  Title? description;
  dynamic? price;
  Null? shopId;
  int? categoryId;
  int? active;
  int? isPrimary;
  String? imageUrl;
  int? isApproval;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  SubCategory(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.shopId,
        this.categoryId,
        this.active,
        this.isPrimary,
        this.imageUrl,
        this.isApproval,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? new Title.fromJson(json['description'])
        : null;
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
