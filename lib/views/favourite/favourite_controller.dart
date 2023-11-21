import 'package:get/get.dart';

import '../../controller/address.dart';
import '../shops/shop_model.dart';

class favouriteController extends GetxController{
  AddressController controllerAddress = Get.put(AddressController());
  String? logo;
  int? shopId;
  ShopsModel? shop;
  void onInit() {
    if (Get.arguments != null) {
      shopId = Get.arguments['shopId'];
      shop = Get.arguments['shop'];
      logo = Get.arguments['logo'];


    }
    super.onInit();
  }
  // String? latitude;
  // String ?longitude;
  int ?id;
  // @override
  // void onInit(){
  //   id=Get.arguments['id'];
  //   // latitude=Get.arguments['lat'];
  //   // longitude=Get.arguments['long'];
  //   print("******************************************************");
  //   print(id.toString());
  //   print(controllerAddress.long);
  //   super.onInit();
  // }
}