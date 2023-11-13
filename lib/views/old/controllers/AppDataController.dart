
import 'dart:convert';
import 'dart:developer';



import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/AuthController.dart';
import '../../../controller/AuthController_new.dart';
import '../../../services/Network.dart';
import '../../../utils/helper/InternetUtils.dart';
import '../api/api_util.dart';
import '../models/AppData.dart';
import '../models/MyResponse.dart';


class AppDataController {

  //-------------------- Add user address --------------------------------//
  static Future<MyResponse<AppData>> getAppData() async {
    //Get Api Token
    AuthController authControllerUser = Get.put(AuthController());

    String? token = await authControllerUser.getApiToken();

    log("token : ${token.toString()}");
    if (token != null) {
      //Get Api Token

      String url ='https://news.wasiljo.com/public/api/v1/user/app_data/user';
      Map<String, String> headers =
          ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);

      //Check Internet
      bool isConnected = await InternetUtils.checkConnection();
      if (!isConnected) {
        return MyResponse.makeInternetConnectionError<AppData>();
      }

      try {
        NetworkResponse response = await Network.get(url, headers: headers);
        log("response : ${response.toString()}");

        MyResponse<AppData> myResponse = MyResponse(response.statusCode);
        if (response.statusCode == 200) {
          myResponse.success = true;
          myResponse.data = AppData.fromJson(json.decode(response.body!));

          log(myResponse.data.toString());

        } else {
          Map<String, dynamic> data = json.decode(response.body!);
          myResponse.success = false;
          myResponse.setError(data);
        }
        return myResponse;
      } catch (e) {
        //If any server error...
        return MyResponse.makeServerProblemError<AppData>();
      }
    }
    else {
      String url = ApiUtil.MAIN_API_URL + ApiUtil.APP_DATA ;
      Map<String, String> headers =
      ApiUtil.getHeader(requestType: RequestType.Get);

      //Check Internet
      bool isConnected = await InternetUtils.checkConnection();
      if (!isConnected) {
        return MyResponse.makeInternetConnectionError<AppData>();
      }

      try {
        NetworkResponse response = await Network.get(url, headers: headers);
        log("response : ${response.body.toString()}");
            log("response : ${response.statusCode.toString()}");
        MyResponse<AppData> myResponse = MyResponse(response.statusCode);
        if (response.statusCode == 200) {
          myResponse.success = true;

          myResponse.data = AppData.fromJson(json.decode(response.body!));
        } else {
          Map<String, dynamic> data = json.decode(response.body!);
          myResponse.success = false;
          myResponse.setError(data);
        }
        return myResponse;
      } catch (e) {
        //If any server error...
        return MyResponse.makeServerProblemError<AppData>();
      }
    }
  }
}

