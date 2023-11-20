
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import '../../../config/custom_package.dart';
import '../../../core/locale/locale.controller.dart';
import '../../../services/PushNotificationsManager.dart';
import '../../../utils/helper/InternetUtils.dart';
import '../../../utils/ui/progress_hud.dart';
import '../../old/api/api_util.dart';
import '../../old/models/MyResponse.dart';

class SignUpController extends GetxController {
  var errorList = [].obs;
  LocaleController controller = Get.put(LocaleController());
//--------------------- Register  ---------------------------------------------//
  Future registerUser({String referrerLink='',
    required String name, required String email, required String mobile, required String password, required int accountType}) async {
    ProgressHud.shared.startLoading(Get.context);
    //Add FCM Token
    PushNotificationsManager pushNotificationsManager = PushNotificationsManager();
    await pushNotificationsManager.init();
    String? fcmToken = await pushNotificationsManager.getToken();
print("fcmToken$fcmToken");
    //URL
    var registerUrl = Uri.parse(
        'https://news.wasiljo.com/public/api/v1/user/register?lang=${controller.language}');

    //Body
    Map data = {
      'name': name,
      'email': email,
      "mobile": mobile,
      'password': password,
      'account_type': accountType,
    //  'referrer_link': accountType,
      'fcm_token': fcmToken
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
      var response = await http.post(registerUrl,
          headers: ApiUtil.getHeader(requestType: RequestType.Post),
          body: body);
      ProgressHud.shared.stopLoading();
      log(response.body.toString());

      if (response.statusCode == 200) {
        log("i am is the success method");
        print(response.body);
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> user = data['data']['user'];
        String token = data['data']['token'];
        await sharedPreferences.setString('name', user['name']);
        var name = await sharedPreferences.getString('name');
        await sharedPreferences.setString('email', user['email']);
        await sharedPreferences.setString('token', token);
        await sharedPreferences.setString('mobile', user['mobile']);
        await sharedPreferences.setBool('mobile_verified', true);
        Get.snackbar('success register'.tr, 'welcome'.tr   +'${name}' +  'to application wasil'.tr,
            backgroundColor: AppColors.primaryColor, snackPosition: SnackPosition.BOTTOM,
            icon: Icon(Icons.waving_hand));
        Get.off(SignInScreen());
        return;
      } else {
        log("i am is the not 200 method");
        Map<String, dynamic> data = json.decode(response.body!);
        log('error${data["error"]}');
        var errors = data['error'];
        errorList.value = List<String>.from(errors);
        print(errorList.value.length);
        return ;
      }
    } catch (e) {
      //If any server error...
      log("i am in the catch method");
      log(e.toString());
      return MyResponse.makeServerProblemError();
    }
  }
}