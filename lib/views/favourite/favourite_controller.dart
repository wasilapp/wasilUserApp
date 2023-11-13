import 'package:get/get.dart';

import '../../controller/address.dart';

class favouriteController extends GetxController{
  AddressController controllerAddress = Get.put(AddressController());

  // String? latitude;
  // String ?longitude;
  int ?id;
  @override
  void onInit(){
    id=Get.arguments['id'];
    // latitude=Get.arguments['lat'];
    // longitude=Get.arguments['long'];
    print("******************************************************");
    print(id.toString());
    print(controllerAddress.long);
    super.onInit();
  }
}