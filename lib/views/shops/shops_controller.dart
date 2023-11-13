import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userwasil/views/shops/shop_model.dart';
import 'package:http/http.dart'as http;

import '../../controller/general_status_model.dart';
import '../../core/locale/locale.controller.dart';
class ShopsController extends GetxController{
  List shops=[].obs;

  late var statusModel = GeneralStatusModel().obs;
  @override
  void onInit() {
    fetchShops();
  }
  void fetchShops() async {
    shops.clear();
    LocaleController controller = Get.put(LocaleController());
    statusModel.value.updateStatus(GeneralStatus.waiting);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };

    statusModel.value.updateStatus(GeneralStatus.waiting);
    final response = await http.get(Uri.parse(
      'https://news.wasiljo.com/public/api/v1/user/get-delivery-or-shop-by-location/1/location?latitude=37.4235492&longitude=122.0924447lang=${controller
          .language}',
    ), headers: headers);


    if ((response.statusCode >= 200 && response.statusCode < 300)) {
      print('response.statusCode  id${response.statusCode}');
      print('response.body  id${json.decode(response.body)['data']['shops']}');

      if (json.decode(response.body)['data']['shops'].isEmpty) {
        print('response.isEmpty  id${json.decode(
            response.body)['data']['shops']}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body)['data']['shops'];
      print('start for');

      for (int index = 0; index < result.length; index++) {
        shops.add(ShopsModel.fromJson(result[index]));
      }
      statusModel.value.updateStatus(GeneralStatus.success);
      print(response.body);
      return;
    }
  }  get isWaiting => statusModel.value.status.value == GeneralStatus.waiting;

  get isError => statusModel.value.status.value == GeneralStatus.error;

  get isSuccess => statusModel.value.status.value == GeneralStatus.success;
}