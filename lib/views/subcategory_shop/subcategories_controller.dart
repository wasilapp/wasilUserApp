import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';
import 'package:userwasil/controller/general_status_model.dart';
import 'package:userwasil/views/shops/shop_model.dart';
import 'package:userwasil/views/wallet_shop/wallet_by_shop_controller.dart';

List<SubCategoriesModel> subCategoriesModel = <SubCategoriesModel>[].obs;
String orderType = '0';

class SubCategoriesController extends GetxController {
  WalletShopController walletcontroller = Get.put(WalletShopController());
  int counter = 0;

  String? logo;
  int? shopId;
  ShopsModel? shop;
  var totalPrice = 0.0.obs;

  List<SubCategoriesModel> _cartList = <SubCategoriesModel>[].obs;
  var cartOrder;

  List get cartList {
    var cartList1 =
        subCategoriesModel.where((product) => product.counter! > 0).toList();
    var cartWallet = walletcontroller.productList.isEmpty
        ? []
        : walletcontroller.productList
            .where((product) => product.counter! > 0)
            .toList();

    return [...cartList1, ...cartWallet];
  }

  void gett() {
    cartOrder = cartList.map((e) => e.tooJson()).toList();
  }

  double calculateTotal() {
    totalPrice.value = 0.0;
    for (int i = 0; i < cartList.length; i++) {
      totalPrice.value += cartList[i].counter! * (cartList[i].price ?? 0);
    }
    update();

    return totalPrice.value;
  }

  void cartLists(List<SubCategoriesModel> value) {
    _cartList = value;
    Get.log(_cartList[0].toJson().toString());
  }

  late var statusModel = GeneralStatusModel().obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      shopId = Get.arguments['shopId'];
      shop = Get.arguments['shop'];
      logo = Get.arguments['logo'];

      getProducts(shopId);
    }
    super.onInit();
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

  void updateCounter(int productId, int newCounterValue) {
    var product = subCategoriesModel.firstWhere((p) => p.id == productId);
    product.counter = newCounterValue;
    update(); // يحدث الواجهة بعد التحديث
  }

  void getProducts(shopId) async {
    statusModel.value.updateStatus(GeneralStatus.waiting);
    var url = Uri.parse(
        'https://news.wasiljo.com/public/api/v1/user/shops/$shopId/subcategory');
    var response = await http.get(
      url,
    );

    if ((response.statusCode >= 200 && response.statusCode < 300)) {
      // قبل إضافة المنتجات الجديدة، قم بحفظ قيم العدادات الحالية
      Map<int, int> counters = {};
      for (var product in subCategoriesModel) {
        counters[product.id!] = product.counter!;
      }
      subCategoriesModel.clear();

      if (json.decode(response.body)['data']['sub_categories'].isEmpty) {
        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body)['data']['sub_categories'];

      for (int index = 0; index < result.length; index++) {
        SubCategoriesModel product = SubCategoriesModel.fromJson(result[index]);

        if (counters.containsKey(product.id)) {
          product.counter = counters[product.id];
        }
        subCategoriesModel.add(product);
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
      sum += model.counter!;
    }
    return sum;
  }
}
