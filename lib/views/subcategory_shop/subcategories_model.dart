class SubCategoriesModel {
  int? id;
  int? counter;
  Title? title;
  Title? description;
  dynamic price;
  int? shopId;
  int? categoryId;
  int? active;
  int? isPrimary;
  String? imageUrl;
  int? isApproval;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  SubCategoriesModel(
      {this.id,
      this.counter,
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
      this.updatedAt,
      this.pivot});
  @override
  String toString() {
    return 'SubCategoriesModel{id: $id, counter: $counter, title: $title, description: $description, price: $price, shopId: $shopId, categoryId: $categoryId, active: $active, isPrimary: $isPrimary, imageUrl: $imageUrl, isApproval: $isApproval, quantity: $quantity, createdAt: $createdAt, updatedAt: $updatedAt, }';
  }

  SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counter = 0;
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? Title.fromJson(json['description'])
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
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['price'] = price;
    data['shop_id'] = shopId;
    data['category_id'] = categoryId;
    data['active'] = active;
    data['is_primary'] = isPrimary;
    data['image_url'] = imageUrl;
    data['is_approval'] = isApproval;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }

  Map<String, dynamic> tooJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_categories_id'] = id;

    data['price'] = price;

    data['total'] = price * counter;

    data['quantity'] = counter;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}

class Pivot {
  int? shopId;
  int? subCategoryId;
  String? price;
  String? quantity;

  Pivot({this.shopId, this.subCategoryId, this.price, this.quantity});

  Pivot.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    subCategoryId = json['sub_category_id'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shop_id'] = shopId;
    data['sub_category_id'] = subCategoryId;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
