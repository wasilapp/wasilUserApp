import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:userwasil/views/auth/signup/signup_controller.dart';

import '../../../config/custom_package.dart';
import '../../../core/locale/locale.controller.dart';
import '../../../utils/theme/theme.dart';
import '../../../utils/ui/textfeild.dart';
export 'package:userwasil/config/custom_package.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  List<String> errorMessages = [];

  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  //Text Field Editing Controller
  TextEditingController? _numberController;
  TextEditingController? nameTFController;
  TextEditingController? emailTFController;
  TextEditingController? passwordTFController;
  TextEditingController? referrerLinkTFController;
  String selectedItem = "individual".tr; // Default selected item
  int selectedCountryCode = 0;
  List<PopupMenuEntry<Object>>? countryList;
  List<dynamic> countryCode = TextUtils.countryCode;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  //Other Variables
  bool isInProgress = false;
  bool showPassword = false;
  String contryCode = "962";

  //UI Variables
  OutlineInputBorder? allTFBorder;

  @override
  void initState() {
    super.initState();
    nameTFController = TextEditingController();
    referrerLinkTFController = TextEditingController();
    emailTFController = TextEditingController();
    passwordTFController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    nameTFController!.dispose();
    emailTFController!.dispose();
    passwordTFController!.dispose();
    _numberController!.dispose();
    super.dispose();
  }
  LocaleController controller = Get.put(LocaleController());
  SignUpController signUpController=Get.put(SignUpController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {



          return SafeArea(
              child: Scaffold(
              body: Form(
              key: formKey,
              child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20)
          ,
          children
          :
          <
          Widget
          >[
          const SizedBox(
          height: 40,
          ),
          const LogoAsset(),
          const SizedBox(
          height: 40,
          ),
          Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
          Translator.translate("Sign Up".tr),
          style: boldPrimary,
          ),
          ),
          const SizedBox(
          height: 30,
          ),
          Row(
          children: [
          Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10),
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
          contryCode = country.phoneCode;
          });
          log('Select country: ${country.displayName}');
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
          color: const Color(0xFF8C98A8).withOpacity(0.2),
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
          child:
          Text(contryCode, style: const TextStyle(color: Colors.white)),
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
          return 'mobile number not eqiual 9 '.tr;
          }
          },
          hintText: 'mobile Number'.tr,
          controller: _numberController!,
          prefixIconData: Icons.phone_android,
          keyBoard: TextInputType.number,
          )),
          ],
          ),
          CustomTextField(
          validator: (value) {
          if (value == null || value.isEmpty) {
          return 'Please enter your  Name'.tr;
          }

          },
          keyBoard: TextInputType.text,
          controller: nameTFController!,
          hintText: Translator.translate("Name".tr),
          prefixIconData: Icons.perm_identity,
          onPrefixIconPress: () {
          setState(() {});
          },
          ),
          CustomTextField(
          keyBoard: TextInputType.emailAddress,
          controller: emailTFController!,
          hintText: Translator.translate("Email".tr),
          prefixIconData: Icons.email_outlined,
          onPrefixIconPress: () {
          setState(() {});
          },
          ),
          Container(
          height: MediaQuery.of(context).size.height * 0.06,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) ,border: Border.all(color: const Color(0xffdcdee3), width: 1.5 ),),
          padding: const EdgeInsets.all(10),
          child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(

          borderRadius: BorderRadius.circular(20),
          dropdownColor: Colors.white,
          isExpanded: true,
          value: selectedItem,
          hint: Text(Translator.translate("type".tr)),
          onChanged:(value) {
          setState(() {
          selectedItem = value!;
          });
          },
          items: <String>[
          'individual'.tr,
          'institution'.tr,
          ].map<DropdownMenuItem<String>>(
          (String value) {
          return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          );
          },
          ).toList(),
          ),
          ),
          ),


          CustomTextField(

          validator: (value) {
          if (value == null || value.isEmpty) {
          return 'Please enter your  password'.tr;
          }
          if (value.length <= 8) {
          return 'password length at least 8 character'.tr;
          }
          },
          keyBoard: TextInputType.text,
          controller: passwordTFController!,
          isPassword: showPassword,
          hintText: Translator.translate("password".tr),
          prefixIconData: Icons.lock_outline,
          onPrefixIconPress: () {
          setState(() {
          showPassword = !showPassword;
          });
          },),
            CustomTextField(


          keyBoard: TextInputType.text,
          controller: referrerLinkTFController!,

          hintText: Translator.translate("referrerLink".tr),
          prefixIconData: Icons.link,
        ),

          //       Container(
          //
          //         height: 90,
          //         child: errorMessages.isNotEmpty
          //             ? ListView.builder(
          //           itemCount: errorMessages.length,
          //           itemBuilder: (context, index) {
          //             return Row(
          //               children: [
          //                 const Icon(Icons.error_outline,color: Colors.red,),
          //                 SizedBox(width: 5,),
          //                 Text(
          //                   errorMessages[index],
          //                   style: TextStyle(
          //                     color: Colors.red,
          //                   ),
          //                 ),
          //               ],
          //             );
          //           },
          //         )
          //             : const Text(''),
          //       ),
          //         CommonViews().createButton(
          //           title: 'Sign Up'.tr,
          //           onPressed: () async {
          //             Dio dio = Dio();
          //            print( contryCode.toString()+_numberController!.text);
          //            print(' countryCode.toString()+_numberController!.text');
          //             if (formKey.currentState!.validate()) {
          //
          // try {
          // final response = await dio.post(
          // 'https://news.wasiljo.com/public/api/v1/user/register?lang=${controller.language}',
          // data: {
          // "name": nameTFController!.text,
          // "mobile":contryCode.toString()+_numberController!.text,
          // "password": passwordTFController!.text,
          // "email": emailTFController!.text,
          //   "account_type":selectedItem=='individual'?0:1
          // },
          // );
          //
          // if (response.statusCode == 200) {
          //   setState(() {
          //     errorMessages.clear();
          //   });
          // // Registration was successful
          // // You can handle success here, such as navigating to a success screen
          // log('Registration successful');
          // UserNavigator.of(context).pushReplacement(const SignInScreen());
          // } else {
          //   log(
          //       "Registration failed with status code: ${response.statusCode}");
          //   log("Response data: ${response.data}");
          // }
          // } catch (e) {
          //   if (e is DioError) {
          //     if (e.response != null) {
          //       // log only the error message from the API response
          //       final responseData = e.response!.data;
          //       if (responseData is Map<String, dynamic> &&
          //           responseData.containsKey('message')) {
          //
          //         log(
          //             "Error during registration: ${responseData['message']}");
          //       } else {
          //
          //
          //         log(
          //             "An error occurred: ${responseData['error']}");
          //
          //         log(
          //             "An error occurred: ${responseData['error']}");
          //
          //         log(";p");
          //
          //         setState(() {
          //           errorMessages =
          //           List<String>.from(responseData['error']);
          //         });
          //         log(errorMessages as String);
          //       }
          //     } else {
          //       // If there's no response, log a generic error message
          //       log("An error occurred: ${e.message}");
          //     }
          //   } else {
          //     // Handle other exceptions, if any
          //     log("Unexpected error: $e");
          //   }
          // }
          // log(errorMessages as String);
          // }
          //           },
          //         ),
          const SizedBox(height: 10,),
            Obx(() =>    Container(
              margin: EdgeInsets.only(left: 20,top: 20),
              height: 90,
              child: signUpController.errorList.isNotEmpty
                  ? ListView.builder(
                itemCount: signUpController.errorList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Icon(Icons.error_outline,color: Colors.red,),
                      SizedBox(width: 5,),
                      Text(
                        signUpController.errorList[index],
                        softWrap: false,
                        style: TextStyle(

                          overflow: TextOverflow.ellipsis,

                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                },
              )
                  : Text(''),
            )),
          CommonViews().createButton(title: 'Sign up', onPressed: () {
          if(formKey.currentState!.validate()){
            signUpController.registerUser(name: nameTFController!.text, email: emailTFController!.text,referrerLink:referrerLinkTFController!.text??'2',
          mobile: contryCode.toString()+_numberController!.text, password: passwordTFController!.text, accountType: 1);
          }},),
          Center(
          child: InkWell(
          onTap: () {
          UserNavigator.of(context).push(const SignInScreen());
          },
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          UserText(
          title: Translator.translate("Already have an account ? signIn").tr,
          ),


          ],
          ),
          ),
          ),
          ],
          ),
          ),),
          );

        }



    List<PopupMenuEntry<Object>> getCountryList() {
      if (countryList != null) return countryList!;
      countryList = <PopupMenuEntry<Object>>[];
      for (int i = 0; i < countryCode.length; i++) {
        countryList!.add(PopupMenuItem(
          value: i,
          child: Container(
            margin: Spacing.vertical(2),
            child: Text(
                countryCode[i]['name'] + " ( " + countryCode[i]['code'] + " )",
                style: TextStyle(
                  color: themeData.colorScheme.onBackground,
                )),
          ),
        ));
        countryList!.add(
          const PopupMenuDivider(
            height: 10,
          ),
        );
      }
      return countryList!;
    }
  }
