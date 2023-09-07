
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:userwasil/providers/darktheme.dart';
import 'package:userwasil/utils/color.dart';

import '../../../services/AppLocalizations.dart';
import 'package:userwasil/utils/helper/navigator.dart';
import 'package:userwasil/utils/size.dart';
import 'package:userwasil/utils/theme/theme.dart';
import 'package:userwasil/views/account/account_inf.dart';
import 'package:userwasil/views/profile/edit_profile.dart';



class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ThemeData? themeData;
  late CustomAppTheme customAppTheme;

  //User


  @override
  void initState() {
    super.initState();

  }



  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        return Scaffold(
                backgroundColor: customAppTheme.bgLayer1,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(Translator.translate("setting"),
                    // style: AppTheme.getTextStyle(
                    //     themeData!.appBarTheme.textTheme!.headline6,
                    //     fontWeight: 600)
                  )
                  ,
                ),
                body: buildBody());
      },
    );
  }

  buildBody() {

      return ListView(
        children: <Widget>[
          Container(
            margin: Spacing.fromLTRB(24, 0, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                // Container(
                //   margin: Spacing.left(16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text("sally",
                //           style: AppTheme.getTextStyle(
                //               themeData!.textTheme.subtitle1,
                //               fontWeight: 700,
                //               letterSpacing: 0)),
                //       Text("sally@gmail.com",
                //           style: AppTheme.getTextStyle(
                //               themeData!.textTheme.caption,
                //               fontWeight: 600,
                //               letterSpacing: 0.3)),
                //     ],
                //   ),
                // ),

              ],
            ),
          ),
          SizedBox(height: 20,),
          Divider(),
          Container(
            margin: Spacing.fromLTRB(16, 8, 16, 0),
            child: ListTile(
              onTap: () {
                UserNavigator.of(context).push( const AccountInfo());

              },
              title: Text(
                Translator.translate("Account Info"),
                style: AppTheme.getTextStyle(themeData!.textTheme.bodyMedium,
                    fontWeight: 600),
              ),
              trailing: Icon(Icons.chevron_right,
                  color: secondaryColor),
            ),
          ),
          Container(
            margin: Spacing.fromLTRB(16, 8, 16, 0),
            child: ListTile(
              onTap: () {
            //    pushScreen(context, AllAddressScreen());
              },
              title: Text(
                Translator.translate("Saved Address"),
                style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
                    fontWeight: 600),
              ),
              trailing: Icon(Icons.chevron_right,
                  color: themeData!.colorScheme.onBackground),
            ),
          ),
          Container(
            margin: Spacing.fromLTRB(16, 8, 16, 0),
            child: ListTile(
              onTap: () {
            //    pushScreen(context, AllAddressScreen());
              },
              title: Text(
                Translator.translate("Saved Cards"),
                style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
                    fontWeight: 600),
              ),
              trailing: Icon(Icons.chevron_right,
                  color: secondaryColor),
            ),
          ),
          Container(
            margin: Spacing.fromLTRB(16, 8, 16, 0),
            child: ListTile(
              onTap: () {
                UserNavigator.of(context).push(  EditProfileScreen());

              },
              title: Text(
                Translator.translate("change_password"),
                style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
                    fontWeight: 600),
              ),
              trailing: Icon(Icons.chevron_right,
                  color: secondaryColor),
            ),
          ),
          Divider(),
          SizedBox(height: 50,),
          Container(
              margin: Spacing.fromLTRB(30, 8, 16, 10),
              child: Row(
                children: [
                  Icon(Icons.privacy_tip_outlined,color: secondaryColor,),
                  SizedBox(width: 5,),
                  Text(
                    Translator.translate("terms"),
                    style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
                        fontWeight: 600),
                  ),
                ],
              )
          ),

          Container(
              margin: Spacing.fromLTRB(30, 8, 16, 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline,color: secondaryColor,),
                  SizedBox(width: 5,),
                  Text(
                    Translator.translate("about"),
                    style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
                        fontWeight: 600),
                  ),
                ],
              )
          ),



        ],
      );
    }
  }


