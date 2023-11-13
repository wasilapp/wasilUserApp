import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/custom_package.dart';
import '../../../controller/AuthController_new.dart';
import '../../../core/constant/colors.dart';
import '../../../core/locale/locale.controller.dart';
import '../../old/api/api_util.dart';
import '../signIn/signin_screen.dart';

class DeleteUser extends GetxController{
  LocaleController controller = Get.put(LocaleController());
  AuthController authControllerUser = Get.put(AuthController());
  Future deleteUser() async {

    String? token = await authControllerUser.getApiToken();
    print(token);
    var response = await http.post(Uri.parse('https://news.wasiljo.com/public/api/v1/user/delete'),
      headers: ApiUtil.getHeader(requestType: RequestType.PostWithAuth,token: token!),);

if(response.statusCode==200){
  Map<String, dynamic> data = json.decode(response.body);
  // Deleted Successfully
  if(data['stateNum']==204){
    log("Deleting : ");
    log(response.body.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('id');
    await sharedPreferences.remove('name');
    await sharedPreferences.remove('email');
    await sharedPreferences.remove('avatar_url');
    await sharedPreferences.remove('token');
    await sharedPreferences.remove('mobile');
    await sharedPreferences.remove('mobile_verified');
    await sharedPreferences.remove('blocked');

    Get.snackbar('success delete ', data['message'],
        backgroundColor: AppColors.primaryColor, snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.done_outline_rounded));
    Get.to(const SignInScreen());
    return true;
  }

  else{
    // if stateNum==200 =>You have active orders, please cancel all orders first
    Get.back();
    Get.snackbar('error massage ', data['error'],messageText: Text(data['error'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM,colorText: Colors.white,
        icon: const Icon(Icons.error,color: Colors.white,));

  }
}



  }
}