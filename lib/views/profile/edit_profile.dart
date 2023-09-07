
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/darktheme.dart';

import '../../../../services/AppLocalizations.dart';
import '../../utils/size.dart';
import '../../utils/theme/theme.dart';
import '../../utils/ui/common_views.dart';


class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //Text Field Editing Controller
  TextEditingController? _numberController;
  TextEditingController? nameTFController;
  TextEditingController? emailTFController;
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  new GlobalKey<ScaffoldMessengerState>();
  String contrycode ="+962";
  //Other Variables
  bool isInProgress = false;

  //UI Variables
  OutlineInputBorder? allTFBorder;
  @override
  void initState() {
    super.initState();


    nameTFController = TextEditingController();
    emailTFController = TextEditingController();
    _numberController = TextEditingController();


  }



  @override
  void dispose() {
    nameTFController!.dispose();
    emailTFController!.dispose();

    _numberController = TextEditingController();
    super.dispose();
  }


  _initUI() {
    allTFBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: customAppTheme.bgLayer4, width: 1.5));
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child){
          int themeType = value.themeMode();
          themeData = AppTheme.getThemeFromThemeMode(themeType);
          customAppTheme = AppTheme.getCustomAppTheme(themeType);
          return Scaffold(
            appBar: CommonViews().getAppBar(
              title: "Account Info",

            ),
            body: Container(
                color: customAppTheme.bgLayer1,
                child: ListView(
                  padding: Spacing.top(45),
                  children: <Widget>[


                    Container(
                      margin: Spacing.fromLTRB(24, 5, 24, 0),
                      child: TextFormField(
                        style: AppTheme.getTextStyle(
                            themeData!.textTheme.bodyText1,
                            letterSpacing: 0.1,
                            color: themeData!.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                            hintText: Translator.translate("Password"),
                            hintStyle: AppTheme.getTextStyle(
                                themeData!.textTheme.subtitle2,
                                letterSpacing: 0.1,
                                color: themeData!.colorScheme.onBackground,
                                fontWeight: 500),
                            border: allTFBorder,
                            enabledBorder: allTFBorder,
                            focusedBorder: allTFBorder,
                            prefixIcon: Icon(
                              MdiIcons.accountOutline,
                              size: MySize.size22,
                            ),
                            isDense: true,
                            contentPadding: Spacing.zero),
                        keyboardType: TextInputType.text,
                        controller: nameTFController,
                        textCapitalization: TextCapitalization.sentences,

                      ),
                    ),




                    // Container(
                    //   margin: Spacing.fromLTRB(24, 16, 24, 0),
                    //   child: FlutButton.medium(
                    //     borderRadiusAll: 8,
                    //     onPressed: () async {
                    //
                    //       final prefs =
                    //       await SharedPreferences.getInstance();
                    //       await prefs.setString('mobile',
                    //           "${emailTFController!.text}");
                    //       await prefs.setString('email',
                    //           "${emailTFController!.text}");
                    //
                    //       await prefs.setString('name',
                    //           "${nameTFController!.text}");
                    //
                    //
                    //
                    //       if (!isInProgress) {
                    //
                    //       }
                    //     },
                    //     child: Stack(
                    //       clipBehavior: Clip.none,
                    //       alignment: Alignment.center,
                    //       children: <Widget>[
                    //         Align(
                    //           alignment: Alignment.center,
                    //           child: Text(
                    //             Translator.translate("save")
                    //                 .toUpperCase(),
                    //             style: AppTheme.getTextStyle(
                    //                 themeData.textTheme.bodyText2,
                    //                 color: themeData.colorScheme.onPrimary,
                    //                 letterSpacing: 0.8,
                    //                 fontWeight: 700),
                    //           ),
                    //         ),
                    //         Positioned(
                    //           right: 16,
                    //           child: isInProgress
                    //               ? Container(
                    //             width: MySize.size16,
                    //             height: MySize.size16,
                    //             child: CircularProgressIndicator(
                    //                 valueColor:
                    //                 AlwaysStoppedAnimation<Color>(
                    //                     themeData.colorScheme
                    //                         .onPrimary),
                    //                 strokeWidth: 1.4),
                    //           )
                    //               : ClipOval(
                    //             child: Container(
                    //               // color: themeData
                    //               //     .colorScheme.primaryVariant,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                  ],
                )),
          );
        }



    );
  }
}
