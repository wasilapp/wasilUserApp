import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:userwasil/controller/general_status_model.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';
import 'main_sub_model.dart';

class MainCategoriesController extends GetxController {
  int counter = 0;
  List<SubCategoriesModel> productList = <SubCategoriesModel>[].obs;
  String? logo;
  int? shopId;
  var totalPrice = 0.0.obs;

  List<MainSubcategoryModel> _cartList = <MainSubcategoryModel>[].obs;
  var cartOrder;

  get cartList {
    var cartList1 =
        productList.where((product) => product.counter! > 0).toList();

    return [
      ...cartList1,
    ];
  }

  void gett() {
    cartOrder = cartList.map((e) => e.tooJson()).toList();
  }

  double calculateTotal() {
    totalPrice.value = 0.0;
    for (int i = 0; i < cartList.length; i++) {
      totalPrice.value += cartList[i].counter * (cartList[i]?.price ?? 0);
    }
    return totalPrice.value;
  }

  set cartList(value) {
    _cartList = value;
  }

  late Rx<GeneralStatusModel> statusModel = GeneralStatusModel().obs;
  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  double getTotalPriceInCart2() {
    for (var item in cartList) {
      if (cartList.length == 0) {
        totalPrice.value = 0.0;
      }
      totalPrice.value = 0.0;
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
    print('l');
    statusModel.value.updateStatus(GeneralStatus.waiting);
    var url = Uri.parse('https://admin.wasiljo.com/public/api/v1/user/categories/2/subcategories');
    var response = await http.get(
      url,
    );

    if ((response.statusCode >= 200 && response.statusCode < 300)) {
      // قبل إضافة المنتجات الجديدة، قم بحفظ قيم العدادات الحالية
      Map<int, int> counters = {};
      for (var product in productList) {
        counters[product.id!] = product.counter!;
      }
      productList.clear();

      if (json.decode(response.body).isEmpty) {
        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      var result = json.decode(response.body)['data']['subcategories'];

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
      if (item.counter > 0) {
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
      sum += model.counter;
    }
    return sum;
  }
}
