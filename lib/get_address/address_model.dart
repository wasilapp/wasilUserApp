import 'dart:core';


class AddressesModel {
  int id;
  String? longitude;
  String? latitude;
  String? name;
  String? street;
  String? buildingNumber;
  String? city;
  int? defaultAddress ;
  int? apartmentNum;
  int? active;
  int? type;
  int? userId;
  String? createdAt;
  String? updatedAt;
// -----------------------


  AddressesModel(
      {required this.id,
   this.name,
        this.longitude,
        this.latitude,
        this.type,
        this.street,
        this.userId,
        this.active,
        this.apartmentNum,
        this.buildingNumber,
        this.city,
        this.createdAt,
        this.defaultAddress,
        this.updatedAt,

       });

}
