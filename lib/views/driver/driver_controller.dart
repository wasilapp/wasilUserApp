
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userwasil/controller/general_status_model.dart';
import 'driver_model.dart';




class DriverController extends GetxController {
  late int id;
  dynamic latitude, longitude;
  DriverController({required this.id,required this.latitude,required this.longitude});
  var driverList = [].obs;
  late var statusModel = GeneralStatusModel().obs;
  @override
  void onInit() {

    getDrivers();

    super.onInit();
  }

  void getDrivers() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    var token=prefs.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };
    print('start get product  id');
    statusModel.value.updateStatus(GeneralStatus.waiting);
    var url = Uri.parse('https://news.wasiljo.com/public/api/v1/user/get-delivery-or-shop-by-location/$id/location?latitude=$latitude&longitude=$longitude');
    var response = await http.get(
      url,headers: headers
    );

    if ((response.statusCode >= 200 && response.statusCode < 300)) {
      print('response.statusCode  id${response.statusCode}');
      print('response.body  id${json.decode(response.body)['data']['deliveryBoy']}');

      if (response.body.isEmpty) {
        print('response.isEmpty  id${json.decode(response.body)['data']['deliveryBoy']}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body)['data']['deliveryBoy'];
      print('start for');

      for (int index = 0; index < result.length; index++) {
        driverList.add(DeliveryBoy.fromJson(result[index]));
      }
      statusModel.value.updateStatus(GeneralStatus.success);
print(driverList);
      return;
    }
    statusModel.value.updateStatus(GeneralStatus.error);
    statusModel.value.updateError("Something went wrong");
  }

  get isWaiting => statusModel.value.status.value == GeneralStatus.waiting;

  get isError => statusModel.value.status.value == GeneralStatus.error;

  get isSuccess => statusModel.value.status.value == GeneralStatus.success;
}
