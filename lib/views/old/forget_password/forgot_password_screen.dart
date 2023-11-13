
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/darktheme.dart';
import '../../../services/AppLocalizations.dart';
import '../../../utils/helper/size.dart';
import '../../../utils/theme/theme.dart';
import '../../auth/signup/signup_screen.dart';



class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  //Text Field Editing Controller
  TextEditingController? emailTFController;
    TextEditingController? _numberController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  bool isInProgress = false;

   String contrycode ="962";

     OutlineInputBorder? allTFBorder;

  @override
  void initState() {
    super.initState();
    emailTFController = TextEditingController();
     _numberController = TextEditingController();
    

  }

    _initUI() {
      
    allTFBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: customAppTheme.bgLayer4, width: 1.5));
  }

  @override
  void dispose() {
    super.dispose();
    emailTFController!.dispose();
    _numberController!.dispose();
  }

  // _handleFP() async {
  //   String email = emailTFController!.text;
  //   if (email.isEmpty) {
  //     showMessage(message: Translator.translate("please_fill_email"));
  //   } else if (Validator.isEmail(email)) {
  //     showMessage(message: Translator.translate("please_fill_email_proper"));
  //   } else {
  //     if (mounted) {
  //       setState(() {
  //         isInProgress = true;
  //       });
  //     }

  //     MyResponse myResponse = await AuthController.forgotPassword(email);

  //     if(myResponse.success){
  //       showMessage(message: Translator.translate("password_reset_link_was_sent"));
  //     }else{
  //      // ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
  //       showMessage(message: myResponse.errorText);
  //     }
  //     if(mounted) {
  //       setState(() {
  //         isInProgress = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
               
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        _initUI();
        return MaterialApp(
            scaffoldMessengerKey: _scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
            home: Scaffold(
                key: _scaffoldKey,
                body: Container(
                    color: customAppTheme.bgLayer1,
                    child: ListView(
                      padding: Spacing.top(180),
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            './assets/images/logo.png',
                            color: themeData.colorScheme.primary,
                            width: 54,
                            height: 54,
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: Spacing.top(24),
                            child: Text(
                              Translator.translate("reset_password").toUpperCase(),
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.headline6,
                                  color: themeData.colorScheme.onBackground,
                                  fontWeight: 700,
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ),

                                    Container(
                          margin: Spacing.fromLTRB(24, 24, 24, 0),

                          // padding: Spacing.all(16),
                          child: Column(
                            children: <Widget>[
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
                                            contrycode = country.phoneCode;
                                          });
                                          print(
                                              'Select country: ${contrycode}');
                                        },
                                        // Optional. Sets the theme for the country list picker.
                                        countryListTheme: CountryListThemeData(
                                          // Optional. Sets the border radius for the bottomsheet.
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(40.0),
                                          ),
                                          // Optional. Styles the search field.
                                          inputDecoration: InputDecoration(
                                            labelText: 'Search',
                                            hintText: 'Start typing to search',
                                            prefixIcon:
                                            const Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(0xFF8C98A8)
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                          // Optional. Styles the text in the search field
                                          searchTextStyle: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                          ),
                                        ),
                                      );
                                    },
                                    child:  Text(contrycode),
                                  ),
                                  Spacing.width(8),
                                  Expanded(
                                    child: TextFormField(
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText1,
                                          letterSpacing: 0.1,
                                          color: themeData
                                              .colorScheme.onBackground,
                                          fontWeight: 500),
                                      decoration: InputDecoration(
                                          hintText: Translator.translate(
                                              "mobile_number"),
                                          hintStyle: AppTheme.getTextStyle(
                                              themeData.textTheme.subtitle2,
                                              letterSpacing: 0.1,
                                              color: themeData
                                                  .colorScheme.onBackground,
                                              fontWeight: 500),
                                          border: allTFBorder,
                                          enabledBorder: allTFBorder,
                                          focusedBorder: allTFBorder,
                                          prefixIcon: Icon(
                                            MdiIcons.phone,
                                            size: MySize.size22,
                                          ),
                                          isDense: true,
                                          contentPadding: Spacing.zero),
                                      keyboardType: TextInputType.number,
                                      autofocus: false,
                                      textCapitalization:
                                      TextCapitalization.sentences,
                                      controller: _numberController,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          margin: Spacing.fromLTRB(24, 16, 24, 0),
                          child: TextButton(

                            onPressed: () {


          //                     Navigator.push(
          // context,
          // MaterialPageRoute(
          //   builder: (BuildContext context) => OTPForRestScreen(fullNumber:"${contrycode}${_numberController!.text}" ,),
          // ),
        // );
        //
                            
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    Translator.translate("reset").toUpperCase(),
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.bodyText2,
                                        color: themeData
                                            .colorScheme.onPrimary,
                                        letterSpacing: 0.8,
                                        fontWeight: 700),
                                  ),
                                ),
                             /*   Positioned(
                                  right: 16,
                                  child: isInProgress
                                      ? Container(
                                          width: MySize.size16,
                                          height: MySize.size16,
                                          child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<
                                                          Color>(
                                                      themeData
                                                          .colorScheme
                                                          .onPrimary),
                                              strokeWidth: 1.4),
                                        )
                                      : ClipOval(
                                          child: Container(
                                            color: themeData.colorScheme
                                                .primaryVariant,
                                            child: SizedBox(
                                                width: MySize.size30,
                                                height: MySize.size30,
                                                child: Icon(
                                                  MdiIcons.arrowRight,
                                                  color: themeData
                                                      .colorScheme
                                                      .onPrimary,
                                                  size: MySize.size18,
                                                )),
                                          ),
                                        ),
                                ),*/
                              ],
                            ),
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
                                        builder: (context) => RegisterScreen()));
                              },
                              child: Text(
                                Translator.translate("i_have_not_an_account"),
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    color: themeData.colorScheme.onBackground,
                                    fontWeight: 500,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ))));
      },
    );
  }

  void showMessage({String message = "Something wrong", Duration? duration}) {
    if (duration == null) {
      duration = Duration(seconds: 3);
    }
    _scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        duration: duration,
        content: Text(message,
            style: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
                letterSpacing: 0.4, color: themeData.colorScheme.onPrimary)),
        backgroundColor: themeData.colorScheme.primary,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
