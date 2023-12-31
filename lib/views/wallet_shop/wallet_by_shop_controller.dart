import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:userwasil/controller/AuthController_new.dart';
import 'package:userwasil/model/cart_model.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';
import 'package:userwasil/views/wallet_shop/wallet_by_shop.dart';

import '../../../controller/general_status_model.dart';
import '../old/api/api_util.dart';

class WalletShopController extends GetxController {
  int counter = 0;
  List<SubCategoriesModel> productList = <SubCategoriesModel>[].obs;
  String? logo;
  int? shopId;
  var totalPrice = 0.0.obs;

  List<SubCategoriesModel> _cartList = <SubCategoriesModel>[].obs;

  set cartList(value) {
    _cartList = value;
  }

  List<SubCategoriesModel> get cartList => _cartList;
  AuthController authController = Get.put(AuthController());

  late var statusModel = GeneralStatusModel().obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      shopId = Get.arguments['shopId'] ?? '';
      logo = Get.arguments['logo'] ?? '';
      getProducts(shopId);
    }
    super.onInit();
  }

  void getProducts(shopId) async {
    print('start get product  id$shopId');
    statusModel.value.updateStatus(GeneralStatus.waiting);
    var token = await authController.getApiToken();

    var url = Uri.parse(
      'https://admin.wasiljo.com/public/api/v1/user/wallets/accepted-by-admin/$shopId',
    );
    var response = await http.get(url,
        headers: ApiUtil.getHeader(
            requestType: RequestType.PostWithAuth, token: token));
    print(response.body);
    if ((response.statusCode >= 200 && response.statusCode < 300)) {
      // قبل إضافة المنتجات الجديدة، قم بحفظ قيم العدادات الحالية
      Map<int, int> counters = {};
      for (var product in productList) {
        counters[product.id!] = product.counter!;
      }
      productList.clear();
      print('response.statusCode  id${response.statusCode}');
      print(
          'response.body  id${json.decode(response.body)['data']['wallets']}');

      if (response.body.isEmpty) {
        print(
            'response.isEmpty  id${json.decode(response.body)['data']['wallets']}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body)['data']['wallets'];
      print('start for');

      for (int index = 0; index < result.length; index++) {
        SubCategoriesModel product = SubCategoriesModel.fromJson(result[index]);

        if (counters.containsKey(product.id)) {
          product.counter = counters[product.id];
        }
        productList.add(product);
      }
      statusModel.value.updateStatus(GeneralStatus.success);

      return;
    }
    statusModel.value.updateStatus(GeneralStatus.error);
    statusModel.value.updateError("Something went wrong");
  }

  plus() {}

  getTotalPriceInCart() {
    for (var item in cartList) {
      if (item.counter! > 0) {
        totalPrice.value = totalPrice.value + (item.price * item.counter);
      }
    }
    return totalPrice.value;
  }

  get isWaiting => statusModel.value.status.value == GeneralStatus.waiting;

  get isError => statusModel.value.status.value == GeneralStatus.error;

  get isSuccess => statusModel.value.status.value == GeneralStatus.success;

  double get totalCount {
    double sum = 0;
    for (var model in cartList) {
      print(model.counter);
      print('model.total');
      sum += model.counter!;
    }
    return sum;
  }

  getCart(model) {
    if (cartList.where((item) => item.id == model.id).isEmpty) {
      cartList.add(model);
    }



  if(cartList.length>=1){
    cartList.clear();
    if (cartList.where((item) => item.id == model.id).isEmpty) {
      cartList.add(model);


    }}
    else {


   
      cartList.remove(model);
    }
  }
  double getTotalPriceInCart2() {
    for (var item in cartList) {
      if (cartList.isEmpty) {
        totalPrice.value = 0.0;
      }
      totalPrice.value = 0.0;
      if (item.counter! > 0) {
        totalPrice.value += (item.price * item.counter);
      }
    }
    update();
    return totalPrice.value;
  }
  double calculateTotal() {
    totalPrice.value = 0.0;
    for (int i = 0; i < cartList.length; i++) {
      totalPrice.value += cartList[i].counter! * (cartList[i].price ?? 0);
    }
    update();

    return totalPrice.value;
  }
}
