
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userwasil/models/UserWallet.dart';
import 'package:userwasil/utils/ui/common_views.dart';
import 'package:userwasil/views/home_screen/home_screen.dart';
import 'package:userwasil/views/sign_up/sign_up.dart';
import '../../config/colors.dart';
import '../../providers/darktheme.dart';
import '../../utils/font.dart';

import '../../../services/AppLocalizations.dart';
import '../../utils/helper/navigator.dart';
import '../../utils/size.dart';
import '../../utils/theme/theme.dart';
import '../../utils/ui/user_text.dart';
import '../../widget/textfeildwidget.dart';
import '../ForgotPasswordScreen/ForgotPasswordScreen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  //Text-Field Controller

  TextEditingController? passwordTFController;
  TextEditingController? _numberController;


  //Global Keys
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
       GlobalKey<ScaffoldMessengerState>();



  String contryCode = "962";







  @override
  void initState() {
    super.initState();



    passwordTFController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {

    passwordTFController!.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);

        return  SafeArea(
              child: Scaffold(
                  key: _scaffoldKey,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      child: ListView(
                        padding: Spacing.top(80),
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logo.png',
width: 50
                            ,
                            height: 50,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(

                           ("Sign In"),
                            style: boldPrimary,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.backgroundColor),
                                onPressed: () {

                                  showCountryPicker(
                                    context: context,
                                    //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                    exclude: <String>['KN', 'MF'],
                                    favorite: <String>['SE'],
                                    //Optional. Shows phone code before the country name.
                                    showPhoneCode: true,
                                    onSelect: (Country country) {
                                      setState(() {
                                        contryCode = country.phoneCode;
                                      });

                                    },
                                    // Optional. Sets the theme for the country list picker.
                                    countryListTheme: CountryListThemeData(
                                      // Optional. Sets the border radius for the bottomsheet.
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                      // Optional. Styles the search field.
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search',
                                        hintText: 'Start typing to search',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color(0xFF8C98A8)
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                      // Optional. Styles the text in the search field
                                      searchTextStyle: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(contryCode),
                              ),
                              const SizedBox(width: 5,),
                              Expanded(
                                child: TextFeildWidget(
                                    hintText: "Phone Number",
                                    controller: _numberController!,
                                    keyBoard: TextInputType.phone,
                                    prefixIconData: Icons.phone_android),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFeildWidget(
                              hintText: "Password",
                              controller: passwordTFController!,
                              keyBoard: TextInputType.text,
                              prefixIconData: Icons.lock),
                          Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(value: false, onChanged: (value) {

                                  },),

                                  const Text(
                                      "Remember me",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      )
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               ForgotPasswordScreen()));
                                },
                                child:const UserText(
                                    title:  "Forgot password?",
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),

                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CommonViews().createButton(title: Translator.translate("Sign In"),
                          onPressed: () {
                            UserNavigator.of(context).pushReplacement(const HomeScreen());
                          },),

                          Center(
                            child: Container(
                              margin: Spacing.top(16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignupScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Translator.translate(
                                          " Dont have an account ?"),
                                      style: AppTheme.getTextStyle(
                                        themeData.textTheme.bodyMedium,
                                        color: themeData.colorScheme.onBackground,
                                        fontWeight: 500,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      Translator.translate("SignUp"),
                                      style: basicPrimary,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  )),
            );
      },
    );
  }

}
