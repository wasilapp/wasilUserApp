
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:userwasil/model/cart_model.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';

import '../../../controller/general_status_model.dart';
import '../shops/shop_model.dart';
import '../wallet_shop/wallet_by_shop_controller.dart';




class SubCategoriesController extends GetxController {
  WalletShopController walletcontroller = Get.put(WalletShopController());
  int counter = 0;
  var productList = [].obs;
  String ?logo;
  int ?shopId;
  ShopsModel ?shop;
  var totalPrice=0.0.obs;




  var _cartList = <SubCategoriesModel>[].obs;
  var  cartOrder;



  get  cartList {
    var cartList1 = productList.value.where((product) => product.counter > 0).toList();
  var cartWallet  = walletcontroller.productList==null&&walletcontroller.productList.length==0?[]:walletcontroller.productList.where((product) => product.counter > 0).toList();



    return [...cartList1, ...cartWallet];

  }


  void  gett(){
    cartOrder=  cartList.map((e) =>e.tooJson()).toList();

    print(cartOrder);
    print(calculateTotal());
  }

  double calculateTotal() {
    totalPrice.value=0.0;
    for (int i = 0; i < cartList.length; i++) {
      totalPrice.value += cartList[i].counter * (cartList[i]?.price?? 0);

    }
    return totalPrice.value;
  }


  // get cartOrder {
  //
  //
  //   productList.forEach((cartItem) {
  //     cartOrder.add(Carts(
  //       subCategoriesId: cartItem['id'],
  //       price:  cartItem['price'],
  //
  //
  //     ));
  //   });
  // }


  // set cartOrder(value) {
  //   _cartOrder = value;
  // }

  set cartList(value) {
    _cartList = value;
  }




  late var statusModel = GeneralStatusModel().obs;
  @override
  void onInit() {
    shopId=Get.arguments['shopId'];
    shop=Get.arguments['shop'];
    logo=Get.arguments['logo'];

    getProducts(shopId);
    print('-****************************');
    print(shop);
print(productList);
print(cartList);
    super.onInit();
  }
  double getTotalPriceInCart2() {


    for (var item in cartList) {
      if(cartList.length==0){
        totalPrice.value=0.0;
      }
      totalPrice.value=0.0;
      if (item.counter > 0) {
        totalPrice.value += (item.price * item.counter);
      }
    }

    return totalPrice.value;
  }
  void updateCounter(int productId, int newCounterValue) {
    var product = productList.firstWhere((p) => p.id == productId);
    product.counter = newCounterValue;
    update(); // يحدث الواجهة بعد التحديث
  }

  void getProducts(shopId) async {
    print('start get product  id$shopId');
    statusModel.value.updateStatus(GeneralStatus.waiting);
    var url = Uri.parse('https://news.wasiljo.com/public/api/v1/user/shops/$shopId/subcategory');
    var response = await http.get(
      url,
    );

    if ((response.statusCode >= 200 && response.statusCode < 300)) {
      // قبل إضافة المنتجات الجديدة، قم بحفظ قيم العدادات الحالية
      Map<int, int> counters = {};
      for (var product in productList) {
        counters[product.id] = product.counter;
      }
      productList.clear();
      print('response.statusCode  id${response.statusCode}');
      print('response.body  id${json.decode(response.body)['data']['sub_categories']}');

      if (json.decode(response.body)['data']['sub_categories'].isEmpty) {
        print('response.isEmpty  id${json.decode(response.body)['data']['sub_categories']}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body)['data']['sub_categories'];
      print('start for');

      for (int index = 0; index < result.length; index++) {
        SubCategoriesModel product = SubCategoriesModel.fromJson(result[index]);

        if (counters.containsKey(product.id)) {
          product.counter = counters[product.id];
        }
        productList.add(product);

      }
      statusModel.value.updateStatus(GeneralStatus.success);
print(response.body);
      return;
    }
    statusModel.value.updateStatus(GeneralStatus.error);
    statusModel.value.updateError("Something went wrong");
  }
  plus(){

  }
     getTotalPriceInCart() {
    for (var  item in cartList) {
      if (item.counter > 0) {
        totalPrice.value= totalPrice.value + (item.price*item.counter);

  }
   }
    return totalPrice.value ;}
  get isWaiting => statusModel.value.status.value == GeneralStatus.waiting;

  get isError => statusModel.value.status.value == GeneralStatus.error;

  get isSuccess => statusModel.value.status.value == GeneralStatus.success;
  double get totalCount {
    double sum = 0;
    for (var model in cartList) {
      print(model.counter);
      print('model.total');
      sum += model.counter;
    }
    return sum;
  }}
