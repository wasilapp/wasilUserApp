
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:userwasil/model/cart_model.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';

import '../../../controller/general_status_model.dart';
import '../wallet_shop/wallet_by_shop_controller.dart';
import 'main_sub_model.dart';




class MainCategoriesController extends GetxController {

  int counter = 0;
  var productList = [].obs;
  String ?logo;
  int ?shopId;
  var totalPrice=0.0.obs;




  var _cartList = <MainSubcategoryModel>[].obs;
  var  cartOrder;



  get  cartList {
    var cartList1 = productList.value.where((product) => product.counter > 0).toList();



    return [...cartList1, ];

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


    getProducts();
    print('-****************************');
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

  void getProducts() async {
    print('start get product  id$shopId');
    statusModel.value.updateStatus(GeneralStatus.waiting);
    var url = Uri.parse('https://news.wasiljo.com/public/api/v1/user/categories/2/subcategories');
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
      print('response.body  id${json.decode(response.body)}');

      if (json.decode(response.body).isEmpty) {
        print('response.isEmpty  id${json.decode(response.body)}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body);
      print('start for');

      for (int index = 0; index < result.length; index++) {
        MainSubcategoryModel product = MainSubcategoryModel.fromJson(result[index]);

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
