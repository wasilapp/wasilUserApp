
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userwasil/utils/ui/user_text.dart';

import '../../providers/darktheme.dart';
import '../../utils/font.dart';

import '../../../../services/AppLocalizations.dart';
import '../../utils/theme/theme.dart';
import '../../utils/ui/common_views.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>{
  //ThemeData
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  //Global Keys
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  new GlobalKey<ScaffoldMessengerState>();

  bool isInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child){
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        return Scaffold(
          appBar: CommonViews().getAppBar(
            title: "Wallet",

          ),

          body:  SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
               
                children: [
                  const UserText(title: 'Your Balance is',
                  color: Colors.grey,
                  ),
                  const UserText(title: '55 Jd',
               fontWeight: FontWeight.bold,
                    fontSize:44 ,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Movements ",

                        style: TextStyle(
                          decoration: TextDecoration.combine([

                          ]),
                          fontSize: 14,
                          color: Color(0xff15CB95),
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title:Text("Gas Cylinder") ,
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Qawareercom",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        Text(
                            "07 Apr 2023 9:30 am",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )
                        )
                      ],
                    ),
trailing: Text(
    "7.5 JD",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    )
),
                  ),
                  Divider(),  Divider(),
                  ListTile(
                    title:Text("Gas Cylinder") ,
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Qawareercom",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        Text(
                            "07 Apr 2023 9:30 am",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )
                        )
                      ],
                    ),
trailing: Text(
    "7.5 JD",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    )
),
                  ),
                  Divider(),  Divider(),
                  ListTile(
                    title:Text("Gas Cylinder") ,
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Qawareercom",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        Text(
                            "07 Apr 2023 9:30 am",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )
                        )
                      ],
                    ),
trailing: Text(
    "7.5 JD",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    )
),
                  ),
                  Divider(),  Divider(),
                  ListTile(
                    title:Text("Gas Cylinder") ,
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Qawareercom",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        Text(
                            "07 Apr 2023 9:30 am",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )
                        )
                      ],
                    ),
trailing: Text(
    "7.5 JD",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    )
),
                  ),
                  Divider(),  Divider(),
                  ListTile(
                    title:Text("Gas Cylinder") ,
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Qawareercom",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        Text(
                            "07 Apr 2023 9:30 am",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )
                        )
                      ],
                    ),
trailing: Text(
    "7.5 JD",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    )
),
                  ),
                  Divider(),
                ],
              ),
            ),
          )



        );
      },

    );

  }
  showMessage({String message = "Something wrong", Duration? duration}) {
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
