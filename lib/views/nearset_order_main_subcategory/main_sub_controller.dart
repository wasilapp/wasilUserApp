
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:userwasil/model/cart_model.dart';

import '../../controller/general_status_model.dart';
import '../favourite/favourite_controller.dart';
import 'main_sub_model.dart';





class MainSubcategoryController extends GetxController {

  var mainSubcategoryList = [].obs;
  late var statusModel = GeneralStatusModel().obs;
  favouriteController controller=Get.put(favouriteController());
  var _cartList = <MainSubcategoryModel>[].obs;
  int ?driverId;
  var totalPrice=0.0.obs;
  set cartList(value) {
    _cartList = value;
  }
  var  cartOrder;
  get cartList => mainSubcategoryList.value.where((element) => element.counter!>0).toSet().toList();
  void  gett(){
    cartOrder=  cartList.map((e) =>e.tooJson()).toList();

    print(cartOrder);
    print(calculateTotal());
  }
  @override
  void onInit() {
 //  driverId=Get.arguments['driverId'];

getMainSubcategory();
    print('-****************************');

  //  print(cartList);
    super.onInit();
  }
  double calculateTotal() {
    totalPrice.value=0.0;
    for (int i = 0; i < cartList.length; i++) {
      totalPrice.value += cartList[i].counter * (cartList[i]?.price?? 0);
    }
    return totalPrice.value;
  }
  void getMainSubcategory() async {
    print('start get product  id');
    statusModel.value.updateStatus(GeneralStatus.waiting);
    var url = Uri.parse('https://news.wasiljo.com/public/api/v1/user/categories/2/subcategories');
    var response = await http.get(
      url,
    );

    if ((response.statusCode >= 200 && response.statusCode < 300)) {
      print('response.statusCode  id${response.statusCode}');
      print('response.body  id${json.decode(response.body)}');

      if (response.body.isEmpty) {
        print('response.isEmpty  id${json.decode(response.body)}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body);
      print('start for');

      for (int index = 0; index < result.length; index++) {
        mainSubcategoryList.add(MainSubcategoryModel.fromJson(result[index]));
      }
      statusModel.value.updateStatus(GeneralStatus.success);
      print(mainSubcategoryList);
      return;
    }
    statusModel.value.updateStatus(GeneralStatus.error);
    statusModel.value.updateError("Something went wrong");
  }

  get isWaiting => statusModel.value.status.value == GeneralStatus.waiting;

  get isError => statusModel.value.status.value == GeneralStatus.error;

  get isSuccess => statusModel.value.status.value == GeneralStatus.success;
}
