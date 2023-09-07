import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:userwasil/views/signin/signin.dart';

import '../../providers/darktheme.dart';
import '../../utils/font.dart';

import '../../../services/AppLocalizations.dart';
import '../../utils/size.dart';
import '../../utils/theme/theme.dart';
import '../../widget/textfeildwidget.dart';
import '../ForgotPasswordScreen/ForgotPasswordScreen.dart';
import '../home_screen/home_screen.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  //Text-Field Controller

  TextEditingController? passwordTFController;
  TextEditingController? _numberController;
  TextEditingController? _nameController;
  TextEditingController? _emailController;


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
    _nameController = TextEditingController();
    _emailController = TextEditingController();

  }

  @override
  void dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              Translator.translate("Sign Up"),
                              style: boldPrimary,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFeildWidget(
                              hintText: "Name",
                              controller: _nameController!,
                              keyBoard: TextInputType.text,
                              prefixIconData: Icons.person),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
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
                          ),     const SizedBox(
                            height: 20,
                          ),

                          TextFeildWidget(
                              hintText: "Email",
                              controller: _emailController!,
                              keyBoard: TextInputType.emailAddress,
                              prefixIconData: Icons.email),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFeildWidget(
                              hintText: "Password",
                              controller: passwordTFController!,
                              keyBoard: TextInputType.text,
                              prefixIconData: Icons.lock),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(

                            style: const ButtonStyle(
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                                minimumSize:
                                MaterialStatePropertyAll(Size(50, 55))),
                            onPressed: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));},
                            child: Text(
                                Translator.translate("Sign Up"),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: Spacing.top(16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LoginScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Translator.translate(
                                          " have an account ? "),
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
                                      Translator.translate("sign in"),
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
