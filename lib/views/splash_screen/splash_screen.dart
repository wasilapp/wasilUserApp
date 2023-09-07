import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/helper/navigator.dart';
import '../home_screen/home_screen.dart';
import '../on_boarding_screen/on_boarding_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    // Add a delay to simulate a long-running task
    Future.delayed(const Duration(seconds: 3), () {
      checkOnBoard();
    });
  }

  checkOnBoard()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? isChecked = sharedPreferences.getString("isChecked");
    // isChecked=null;
    if(isChecked==null){
      sharedPreferences.setString("isChecked","1");
      UserNavigator.of(context).pushReplacement( const OnboardingScreen());

    }else{
      UserNavigator.of(context).pushReplacement( const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 200.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}