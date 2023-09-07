// To parse this JSON data, do
//
//     final walletsModel = walletsModelFromJson(jsonString);

import 'dart:convert';

WalletsModel walletsModelFromJson(String str) => WalletsModel.fromJson(json.decode(str));

String walletsModelToJson(WalletsModel data) => json.encode(data.toJson());

class WalletsModel {

    double? total;

    WalletsModel({
      
        this.total,
    });

    factory WalletsModel.fromJson(Map<String, dynamic> json) => WalletsModel(
       // coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
        total: json["total"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
       // "coupons": coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x.toJson())),
        "total": total,
    };
}

class Coupon {
    int? id;
    int? userId;
    int? shopId;
    int? price;
    int? maxUsage;
    int? currentUsage;
    int? status;
    int? type;
    String? createdAt;
    String? updatedAt;
    Shop? shop;

    Coupon({
        this.id,
        this.userId,
        this.shopId,
        this.price,
        this.maxUsage,
        this.currentUsage,
        this.status,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.shop,
    });

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        price: json["price"],
        maxUsage: json["max_usage"],
        currentUsage: json["current_usage"],
        status: json["status"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shop_id": shopId,
        "price": price,
        "max_usage": maxUsage,
        "current_usage": currentUsage,
        "status": status,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "shop": shop?.toJson(),
    };
}

class Shop {
    int? id;
    String? name;
    String? email;
    String? mobile;
    String? barcode;
    double? latitude;
    double? longitude;
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
    String? createdAt;
    String? updatedAt;
    Category? category;

    Shop({
        this.id,
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
        this.createdAt,
        this.updatedAt,
        this.category,
    });

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        barcode: json["barcode"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        imageUrl: json["image_url"],
        rating: json["rating"],
        deliveryRange: json["delivery_range"],
        totalRating: json["total_rating"],
        defaultTax: json["default_tax"],
        availableForDelivery: json["available_for_delivery"],
        open: json["open"],
        managerId: json["manager_id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "barcode": barcode,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "image_url": imageUrl,
        "rating": rating,
        "delivery_range": deliveryRange,
        "total_rating": totalRating,
        "default_tax": defaultTax,
        "available_for_delivery": availableForDelivery,
        "open": open,
        "manager_id": managerId,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category": category?.toJson(),
    };
}

class Category {
    int? id;
    String? title;
    double? commesion;
    String? imageUrl;
    double? deliveryFee;
    int? active;
    String? createdAt;
    String? updatedAt;

    Category({
        this.id,
        this.title,
        this.commesion,
        this.imageUrl,
        this.deliveryFee,
        this.active,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        commesion: json["commesion"]?.toDouble(),
        imageUrl: json["image_url"],
        deliveryFee: json["delivery_fee"]?.toDouble(),
        active: json["active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "commesion": commesion,
        "image_url": imageUrl,
        "delivery_fee": deliveryFee,
        "active": active,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
