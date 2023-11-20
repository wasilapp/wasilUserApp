
import 'package:get/get.dart';
import 'package:userwasil/views/auth/signIn/signin_controller.dart';
import 'package:userwasil/views/auth/signup/signup_screen.dart';

import '../../../controller/AuthController.dart';





class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //Text-Field Controller

  TextEditingController? passwordTFController;
  TextEditingController? _mobileTFController;

  //Other Variables
  late bool isInProgress;
  bool showPassword = false;
  String countryCode = "962";

  //UI Variables

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // String errorMessages = '';

  @override
  void initState() {
    super.initState();
    //_checkUserLoginOrNot();
    isInProgress = false;

    passwordTFController = TextEditingController();
    _mobileTFController = TextEditingController();
  }

  @override
  void dispose() {

    _mobileTFController!.dispose();
    passwordTFController!.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    SignInController controllerSignIn = Get.put(SignInController());
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ListView(
              padding:const EdgeInsets.only(top: 150,right: 20,left: 20),
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 120.0,
                    height: 120.0,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      Translator.translate("Sign in".tr),
                      style: boldPrimary,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only( top: 10,),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
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
                                countryCode = country.phoneCode;
                              });
                            },
                            // Optional. Sets the theme for the country list picker.
                            countryListTheme: CountryListThemeData(
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
                        child: Text(countryCode,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                    Spacing.width(8),
                    Expanded(
                        child: CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number'.tr;
                        }
                        if (value.length != 9) {
                          return 'mobile number not equal 9 '.tr;
                        }
                        return null;
                      },
                      hintText: 'mobile Number'.tr,
                      controller: _mobileTFController!,
                      prefixIconData: Icons.phone_android,
                      keyBoard: TextInputType.phone,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your  password'.tr;
                    }
                    if (value.length <= 8) {
                      return 'password length at least 8 character'.tr;
                    }
                    return null ;
                  },
                  keyBoard: TextInputType.text,
                  controller: passwordTFController!,
                  isPassword: showPassword,
                  hintText: Translator.translate("password".tr),
                  prefixIconData: Icons.lock,
                  onPrefixIconPress: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(style: const TextStyle(color: AppColors.secondaryColor),
                      "forget password".tr,
                    ),
                  ),
                ),


                          Obx(() =>    Text(
                            controllerSignIn.errorText.value,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                          ) ),



                const SizedBox(height: 10,),
                CommonViews().createButton(
                  title: 'SignIn'.tr,

                  onPressed: () {
                   if (_formKey.currentState!.validate()) {

                     controllerSignIn.SignInUser(mobile:
                         countryCode.toString() + _mobileTFController!.text,
                       password:   passwordTFController!.text);
                   } },
                ),
                Center(
                  child: Container(
                    margin: Spacing.top(16),
                    child: InkWell(
                      onTap: () {
                        controllerSignIn.errorText.value='';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Translator.translate("Don't have an Account?".tr),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            Translator.translate("SignUp".tr),
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
                InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                 ("SignIn with visitor".tr),
                    ),
                  ),
                ),
              ],
            )));
  }
}
