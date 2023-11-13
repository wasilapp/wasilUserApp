
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:userwasil/providers/darktheme.dart';
import 'package:userwasil/utils/ui/listtile.dart';
import 'package:userwasil/views/addresses/all_address/all_address_screen.dart';
import 'package:userwasil/views/auth/update_profile/update_user.dart';

import '../../../../../../services/AppLocalizations.dart';
import 'package:userwasil/utils/helper/navigator.dart';
import 'package:userwasil/utils/helper/size.dart';
import 'package:userwasil/utils/theme/theme.dart';
import '../../../core/constant/colors.dart';
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}
class _SettingScreenState extends State<SettingScreen> {

  //User
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

                  appBar: AppBar(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(Translator.translate("setting"),
                      // style: AppTheme.getTextStyle(
                      //     themeData!.appBarTheme.textTheme!.headline6,
                      //     fontWeight: 600)
                    )
                    ,
                  ),
                  body: buildBody()),
    );

  }

  buildBody() {
      return ListView(padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[

          const SizedBox(height: 20,),


          ListTile(
            leading: const Icon(Icons.person,color: AppColors.primaryColor),
            onTap: () {
              UserNavigator.of(context).push( const UpdateUser());

            },
            title: Text(
              Translator.translate("Account Info".tr),

            ),
            trailing: const Icon(Icons.chevron_right,
                color: AppColors.primaryColor),
          ),
          const Divider(color: AppColors.borderColor,),
          ListTile(
            leading: const Icon(Icons.credit_card_sharp,color: AppColors.primaryColor),
            onTap: () {
              UserNavigator.of(context).push( const UpdateUser());

            },
            title: Text(
              Translator.translate("Saved Cards"),

            ),
            trailing: const Icon(Icons.chevron_right,
                color: AppColors.primaryColor),
          ),
          const Divider(color: AppColors.borderColor,),
          ListTile(
            leading: const Icon(Icons.home_work_outlined,color: AppColors.primaryColor),
            onTap: () {
              UserNavigator.of(context).push( AllAddressScreen());

            },
            title: Text(
              Translator.translate("Saved Address"),

            ),
            trailing: const Icon(Icons.chevron_right,
                color: AppColors.primaryColor),
          ),








        ],
      );
    }
  }


