//
// class SubCategoriesModel {
//   int? id;
//   int counter;
//   Title? title;
//   Title? description;
//   final price;
//   double? shopId;
//   double? categoryId;
//   double? active;
//   double? isPrimary;
//   String? imageUrl;
//   double? isApproval;
//   double? quantity;
//   String? createdAt;
//   String? updatedAt;
//
//
//   SubCategoriesModel(
//       { this.id,
//           this.counter=0,
//         this.title,
//         this.description,
//         this.price,
//         this.shopId,
//         this.categoryId,
//         this.active,
//         this.isPrimary,
//         this.imageUrl,
//         this.isApproval,
//         this.quantity,
//         this.createdAt,
//         this.updatedAt,
//         });
//

//
// class Title {
//   String? en;
//   String? ar;
//
//   Title({this.en, this.ar});
//
//   Title.fromJson(Map<String, dynamic> json) {
//     en = json['en'];
//     ar = json['ar'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['en'] = this.en;
//     data['ar'] = this.ar;
//     return data;
//   }
// }
//
//


class SubCategoriesModel {
  int? id;
  int? counter;
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
;counter=0;
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }

  Map<String, dynamic> tooJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_categories_id'] = this.id;

    data['price'] = this.price;

    data['total'] = this.price* this.counter;

    data['quantity'] = this.counter;


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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['sub_category_id'] = this.subCategoryId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
