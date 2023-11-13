
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:userwasil/controller/AuthController_new.dart';
import 'package:userwasil/model/cart_model.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';
import 'package:userwasil/views/wallet_shop/wallet_by_shop.dart';

import '../../../controller/general_status_model.dart';
import '../old/api/api_util.dart';
import 'my_wallet_model.dart';




class MyWalletController extends GetxController {

  var myWalletList = [].obs;




  AuthController authController = Get.put(AuthController());


  late var statusModel = GeneralStatusModel().obs;

  @override
  void onInit() {

    getProducts();
    super.onInit();
  }

  void getProducts() async {

    statusModel.value.updateStatus(GeneralStatus.waiting);
    var token = await authController.getApiToken();

    var url = Uri.parse(
      'https://news.wasiljo.com/public/api/v1/user/wallet-coupons/myWalletCoupons',);
    var response = await http.get(
        url, headers: ApiUtil.getHeader(
        requestType: RequestType.PostWithAuth, token: token
    ));

    if ((response.statusCode >= 200 && response.statusCode < 300)) {
      print('response.statusCode  id${response.statusCode}');
      print(
          'response.body  id${json.decode(response.body)['data']['walletCouponsPending']}');

      if (response.body.isEmpty) {
        print('response.isEmpty  id${json.decode(
            response.body)['data']['walletCouponsPending']}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body)['data']['walletCouponsPending'];
      print('start for');

      for (int index = 0; index < result.length; index++) {
        myWalletList.add(WalletCouponsAccepted.fromJson(result[index]));
      }
      statusModel.value.updateStatus(GeneralStatus.success);

      return;
    }
    statusModel.value.updateStatus(GeneralStatus.error);
    statusModel.value.updateError("Something went wrong");
  }

  get isWaiting => statusModel.value.status.value == GeneralStatus.waiting;

  get isError => statusModel.value.status.value == GeneralStatus.error;

  get isSuccess => statusModel.value.status.value == GeneralStatus.success;

}