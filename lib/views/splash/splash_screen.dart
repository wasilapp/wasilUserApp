import 'package:get/get.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/views/home/category_view/home_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay to simulate a long-running task
    Future.delayed(const Duration(seconds: 3), () {
      checkOnBoard();
    });
  }

  checkOnBoard() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? isChecked = sharedPreferences.getString("isChecked");
    String? token = sharedPreferences.getString('token');
    // isChecked=null;
  //  Get.log(token!);
    if (isChecked == null) {
      sharedPreferences.setString("isChecked", "1");
      Get.offAll(OnboardingScreen());
    } else {
      Get.offAll(const HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 60.0.w,
          height: 60.0.h,
        ),
      ),
    );
  }
}
