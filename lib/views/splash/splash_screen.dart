
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/views/auth/signIn/signin_screen.dart';
import 'package:userwasil/views/home/category_view/home_screen.dart';

import '../../main.dart';
import '../../utils/helper/size.dart';
import '../onboarding/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    // Add a delay to simulate a long-running task
    Future.delayed(Duration(seconds: 3), () {
      checkOnBoard();
    });
  }

  checkOnBoard()async{


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();


    String? isChecked = sharedPreferences.getString("isChecked");
    String? token = sharedPreferences.getString('token');
    // isChecked=null;
    if(isChecked==null){
      sharedPreferences.setString("isChecked","1");
      Get.to( OnboardingScreen());
    }
  else if(token!=null){
      Get.to( HomeScreen());
    }
    else{
    Get.to(const SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 60.0.w,
            height: 60.0.h,
          ),
        ),
      ),
    );
  }
}
