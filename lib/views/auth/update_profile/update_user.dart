
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:userwasil/views/auth/update_profile/update_user_controller.dart';

import '../../../config/custom_package.dart';
import '../../../utils/theme/theme.dart';


class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  //Text Field Editing Controller
  TextEditingController? numberController=TextEditingController();
  TextEditingController? nameTFController=TextEditingController();
  TextEditingController? emailTFController=TextEditingController();
  TextEditingController? passwordTFController=TextEditingController();
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  String countryCode = "+962";
  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    nameTFController!.dispose();
    emailTFController!.dispose();

    super.dispose();
  }

  _initData() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    nameTFController!.text=   prefs.getString('name')!;
    emailTFController!.text=   prefs.getString('email')!;
    numberController!.text=   prefs.getString('mobile')!;
    numberController!.text=   prefs.getString('password')!;


  }

  @override
  Widget build(BuildContext context) {
    UpdateUserController controller = Get.put(UpdateUserController());

    return Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
      int themeType = value.themeMode();
      themeData = AppTheme.getThemeFromThemeMode(themeType);
      customAppTheme = AppTheme.getCustomAppTheme(themeType);
      return SafeArea(
        child: Scaffold(
          appBar:  AppBar(            iconTheme: IconThemeData(color: Colors.black),elevation: 0,
        title: Text("Update Profile".tr,style: TextStyle(color:Color(0xff373636),fontSize: 18,
        fontWeight: FontWeight.w400,)),
        backgroundColor: AppColors.backgroundColor,),
          body: Container(
              color: customAppTheme.bgLayer1,
              child: ListView(
                padding: EdgeInsets.only(top:45,right: 20,left: 20),
                children: <Widget>[
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0),
                  //       child: Text(Translator.translate("Update Profile".tr),style: boldPrimary,),
                  //     ),
                  //   ],
                  // ),
                  CustomTextField(
                                    hintText: 'mobile Number'.tr,
                                    controller: numberController!,
                                    prefixIconData: Icons.phone_android,
                                    keyBoard: TextInputType.number,
                                  ),
                  CustomTextField(
                      hintText: 'Name'.tr,
                      controller: nameTFController!,
                      keyBoard: TextInputType.name,
                      prefixIconData: Icons.person),
                  CustomTextField(
                      hintText: 'Email'.tr,
                      controller: emailTFController!,
                      keyBoard: TextInputType.emailAddress,
                      prefixIconData: Icons.email),
                  CustomTextField(
                      hintText: 'new password'.tr,
                      controller: passwordTFController!,
                      keyBoard: TextInputType.text,
                      prefixIconData: Icons.lock),
                  const SizedBox(height: 20,),
                  CommonViews().createButton(
                    title: 'save'.tr,
                    onPressed: () async {
controller.updateUser(name: nameTFController!.text,
    email: emailTFController!.text, mobile:numberController!.text, );
                    },
                  ),
                ],
              )),
        ),
      );
    });
  }
}
