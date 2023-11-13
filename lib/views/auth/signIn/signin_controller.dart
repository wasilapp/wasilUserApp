
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:userwasil/views/home/category_view/home_screen.dart';
import '../../../config/custom_package.dart';
import '../../../core/locale/locale.controller.dart';
import '../../../services/PushNotificationsManager.dart';
import '../../../utils/helper/InternetUtils.dart';
import '../../../utils/ui/progress_hud.dart';
import '../../old/api/api_util.dart';
import '../../old/models/MyResponse.dart';

class SignInController extends GetxController {
  var errorText = ''.obs;
  LocaleController controller = Get.put(LocaleController());
//--------------------- Register  ---------------------------------------------//
  Future SignInUser({
 required String mobile, required String password,}) async {
    ProgressHud.shared.startLoading(Get.context);
    //Add FCM Token
    PushNotificationsManager pushNotificationsManager = PushNotificationsManager();
    await pushNotificationsManager.init();
    String? fcmToken = await pushNotificationsManager.getToken();

    //URL
    var loginUrl = Uri.parse(
        'https://news.wasiljo.com/public/api/v1/user/login?lang=${controller.language}');

    //Body
    Map data = {
      "mobile": mobile,
      'password': password,
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
      var response = await http.post(loginUrl,
          headers: ApiUtil.getHeader(requestType: RequestType.Post),
          body: body);
      ProgressHud.shared.stopLoading();
      log(response.body.toString());

      if (response.statusCode == 200) {
        errorText.value='';
        log("i am is the success method");
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> user = data['data']['user'];
        String token = data['data']['token'];
        await sharedPreferences.setString('name', user['name']);
        var name = await sharedPreferences.getString('name');
        await sharedPreferences.setString('email', user['email']);
        await sharedPreferences.setString('token', token);
      // user['referrer_link']??   await sharedPreferences.setString('referrer_link', user['referrer_link']);
       await sharedPreferences.setString('referrer', user['referrer']);
        await sharedPreferences.setString('mobile', user['mobile']);
        await sharedPreferences.setBool('mobile_verified', true);
        Get.off(const HomeScreen());
        // Get.snackbar('success register', 'welcome $name to application wasil',
        //     backgroundColor: AppColors.primaryColor, snackPosition: SnackPosition.BOTTOM,
        //     icon: Icon(Icons.waving_hand));
        return;
      } else {
        log("i am is the not 200 method");
        Map<String, dynamic> data = json.decode(response.body!);
        log('error${data["error"]}');
        var errors = data['error'];
        errorText.value = errors;
        print(errorText.value);
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