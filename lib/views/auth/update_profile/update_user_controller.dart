import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:userwasil/controller/AuthController.dart';
import 'package:userwasil/controller/AuthController_new.dart';
import 'package:userwasil/views/home/category_view/home_screen.dart';
import '../../../config/custom_package.dart';
import '../../../core/locale/locale.controller.dart';
import '../../../services/PushNotificationsManager.dart';
import '../../../utils/helper/InternetUtils.dart';
import '../../../utils/ui/progress_hud.dart';
import '../../old/api/api_util.dart';
import '../../old/models/MyResponse.dart';

class UpdateUserController extends GetxController {
  var errorList = [].obs;
  LocaleController controller = Get.put(LocaleController());
  AuthController authControllerUser = Get.put(AuthController());
//--------------------- Register  ---------------------------------------------//
  Future updateUser({
    String? name,
    String? email,
    String? mobile,
    String? password,
  }) async {
    ProgressHud.shared.startLoading(Get.context);
    //Add FCM Token
    PushNotificationsManager pushNotificationsManager =
        PushNotificationsManager();
    await pushNotificationsManager.init();
    String? fcmToken = await pushNotificationsManager.getToken();

    //URL
    var updateUrl = Uri.parse(
        'https://admin.wasiljo.com/public/api/v1/user/update_profile?lang=${controller.language}');

    //Body
    Map data = {
      'name': name,
      'email': email,
      "mobile": mobile,
      // 'password': password,
      // 'account_type': accountType,
      // 'fcm_token': fcmToken
    };

    // //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    //Response
    try {
      var token = await authControllerUser.getApiToken();
      var response = await http.put(updateUrl,
          headers: ApiUtil.getHeader(
              requestType: RequestType.PostWithAuth, token: token),
          body: body);
      ProgressHud.shared.stopLoading();
      log(response.body.toString());

      if (response.statusCode == 200) {
        log("i am is the success method");
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        Map<String, dynamic> data = json.decode(response.body);

        Map<String, dynamic> user = data['data']['user'];

        await sharedPreferences.setString('name', user['name']);
        var name = await sharedPreferences.getString('name');
        await sharedPreferences.setString('email', user['email']);

        await sharedPreferences.setString('mobile', user['mobile']);

        Get.snackbar('success update', '',
            backgroundColor: AppColors.primaryColor,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(Icons.done_outline_rounded));
        Get.off(HomeScreen());
        return;
      } else {
        log("i am is the not 200 method");
        // Map<String, dynamic> data = json.decode(response.body!);
        // log('error${data["error"]}');
        // var errors = data['error'];
        // errorList.value = List<String>.from(errors);
        // print(errorList.value.length);
        return;
      }
    } catch (e) {
      //If any server error...
      log("i am in the catch method");
      log(e.toString());
      return MyResponse.makeServerProblemError();
    }
  }
}
