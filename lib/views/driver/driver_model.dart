



class DeliveryBoy {
  int? id;
  Name? name;
  AgencyName? agencyName;
  String? carNumber;
  String? email;
  String? emailVerifiedAt;
  String? password;
  Null? fcmToken;
  double? latitude;
  double? longitude;
  int? isFree;
  int? isOffline;
  int? isActive;
  String? avatarUrl;
  String? mobile;
  int? mobileVerified;
  int? rating;
  int? totalRating;
  int? categoryId;
  int? shopId;
  String? rememberToken;
  int? isVerified;
  String? drivingLicense;
  int? isApproval;
  double? distance;
  Null? otp;
  int? fullGasBottles;
  int? emptyGasBottles;
  int? gasBottlesCapacity;
  String? createdAt;
  String? updatedAt;

  DeliveryBoy(
      {this.id,
        this.name,
        this.agencyName,
        this.carNumber,
        this.email,
        this.emailVerifiedAt,
        this.password,
        this.fcmToken,
        this.latitude,
        this.longitude,
        this.isFree,
        this.isOffline,
        this.isActive,
        this.avatarUrl,
        this.mobile,
        this.mobileVerified,
        this.rating,
        this.totalRating,
        this.categoryId,
        this.shopId,
        this.rememberToken,
        this.isVerified,
        this.drivingLicense,
        this.isApproval,
        this.distance,
        this.otp,
        this.fullGasBottles,
        this.emptyGasBottles,
        this.gasBottlesCapacity,
        this.createdAt,
        this.updatedAt});

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    agencyName = json['agency_name'] != null
        ? new AgencyName.fromJson(json['agency_name'])
        : null;
    carNumber = json['car_number'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    fcmToken = json['fcm_token'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isFree = json['is_free'];
    isOffline = json['is_offline'];
    isActive = json['is_active'];
    avatarUrl = json['avatar_url'];
    mobile = json['mobile'];
    mobileVerified = json['mobile_verified'];
    rating = json['rating'];
    totalRating = json['total_rating'];
    categoryId = json['category_id'];
    shopId = json['shop_id'];
    rememberToken = json['remember_token'];
    isVerified = json['is_verified'];
    drivingLicense = json['driving_license'];
    isApproval = json['is_approval'];
    distance = json['distance'];
    otp = json['otp'];
    fullGasBottles = json['full_gas_bottles'];
    emptyGasBottles = json['empty_gas_bottles'];
    gasBottlesCapacity = json['gas_bottles_capacity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.agencyName != null) {
      data['agency_name'] = this.agencyName!.toJson();
    }
    data['car_number'] = this.carNumber;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['fcm_token'] = this.fcmToken;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_free'] = this.isFree;
    data['is_offline'] = this.isOffline;
    data['is_active'] = this.isActive;
    data['avatar_url'] = this.avatarUrl;
    data['mobile'] = this.mobile;
    data['mobile_verified'] = this.mobileVerified;
    data['rating'] = this.rating;
    data['total_rating'] = this.totalRating;
    data['category_id'] = this.categoryId;
    data['shop_id'] = this.shopId;
    data['remember_token'] = this.rememberToken;
    data['is_verified'] = this.isVerified;
    data['driving_license'] = this.drivingLicense;
    data['is_approval'] = this.isApproval;
    data['distance'] = this.distance;
    data['otp'] = this.otp;
    data['full_gas_bottles'] = this.fullGasBottles;
    data['empty_gas_bottles'] = this.emptyGasBottles;
    data['gas_bottles_capacity'] = this.gasBottlesCapacity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
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

class AgencyName {
  String? en;

  AgencyName({this.en});

  AgencyName.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    return data;
  }
}
