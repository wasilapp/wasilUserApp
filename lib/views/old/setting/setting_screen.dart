//
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:userwasil/utils/helper/navigator.dart';
//
//
// import '../../../config/colors.dart';
// import '../../../controllers/AuthController.dart';
// import '../../../models/Account.dart';
// import '../../../providers/darktheme.dart';
// import '../../../services/AppLocalizations.dart';
// import '../../../utils/helper/ImageUtils.dart';
// import '../../../config/color.dart';
// import '../../../utils/helper/size.dart';
// import '../../../utils/theme/theme.dart';
// import '../../old/OrderScreen.dart';
// import '../../old/SelectLanguageDialog.dart';
// import '../../old/SelectThemeDialog.dart';
// import '../../addresses/all_address/all_address_screen.dart';
// import '../edit_profile/edit_profile_screen.dart';
// import '../profile/profile_screen.dart';
//
// class SettingScreen extends StatefulWidget {
//   @override
//   _SettingScreenState createState() => _SettingScreenState();
// }
//
// class _SettingScreenState extends State<SettingScreen> {
//   ThemeData? themeData;
//   late CustomAppTheme customAppTheme;
//
//   //User
//   Account? account;
//
//   @override
//   void initState() {
//     super.initState();
//     _initData();
//   }
//
//   _initData() async {
//     Account cacheAccount = await AuthController.getAccount();
//     setState(() {
//       account = cacheAccount;
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return Consumer<AppThemeNotifier>(
//       builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
//         int themeType = value.themeMode();
//         themeData = AppTheme.getThemeFromThemeMode(themeType);
//         customAppTheme = AppTheme.getCustomAppTheme(themeType);
//         return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: themeData,
//             home: Scaffold(
//                 backgroundColor: customAppTheme.bgLayer1,
//                 appBar: AppBar(
//                   backgroundColor: customAppTheme.bgLayer1,
//                   elevation: 0,
//                   centerTitle: true,
//                   title: Text(Translator.translate("setting"),
//                       // style: AppTheme.getTextStyle(
//                       //     themeData!.appBarTheme.textTheme!.headline6,
//                       //     fontWeight: 600)
//                   ),
//                 ),
//                 body: buildBody()));
//       },
//     );
//   }
//
//   buildBody() {
//     if (account != null) {
//       return ListView(
//         children: <Widget>[
//           Container(
//             margin: Spacing.fromLTRB(24, 0, 24, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 ClipRRect(
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(MySize.getScaledSizeWidth(24))),
//                     child: ImageUtils.getImageFromNetwork(
//                         account!.getAvatarUrl(),
//                         width: 48,
//                         height: 48)),
//                 Container(
//                   margin: Spacing.left(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(account!.name!,
//                           style: AppTheme.getTextStyle(
//                               themeData!.textTheme.subtitle1,
//                               fontWeight: 700,
//                               letterSpacing: 0)),
//                       Text(account!.email!,
//                           style: AppTheme.getTextStyle(
//                               themeData!.textTheme.caption,
//                               fontWeight: 600,
//                               letterSpacing: 0.3)),
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//           SizedBox(height: 20,),
//           Divider(),
//           Container(
//             margin: Spacing.fromLTRB(16, 8, 16, 0),
//             child: ListTile(
//               onTap: () {
//                 UserNavigator.of(context).push(ChangePassword());
//               },
//               title: Text(
//                 Translator.translate("account_info"),
//                 style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
//                     fontWeight: 600),
//               ),
//               trailing: Icon(Icons.chevron_right,
//                   color: themeData!.colorScheme.onBackground),
//             ),
//           ),
//           Container(
//             margin: Spacing.fromLTRB(16, 8, 16, 0),
//             child: ListTile(
//               onTap: () {
//                 UserNavigator.of(context).push( AllAddressScreen());
//               },
//               title: Text(
//                 Translator.translate("save_address"),
//                 style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
//                     fontWeight: 600),
//               ),
//               trailing: Icon(Icons.chevron_right,
//                   color: themeData!.colorScheme.onBackground),
//             ),
//           ),
//           Container(
//             margin: Spacing.fromLTRB(16, 8, 16, 0),
//             child: ListTile(
//               onTap: () {
//                 UserNavigator.of(context).push( ChangePassword());
//               },
//               title: Text(
//                 Translator.translate("change_password"),
//                 style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
//                     fontWeight: 600),
//               ),
//               trailing: Icon(Icons.chevron_right,
//                   color: themeData!.colorScheme.onBackground),
//             ),
//           ),
//           Divider(),
//           SizedBox(height: 50,),
//           Container(
//             margin: Spacing.fromLTRB(30, 8, 16, 10),
//             child: Row(
//               children: [
//                 Icon(Icons.privacy_tip_outlined,color: AppColors.primaryColor,),
//                 SizedBox(width: 5,),
//                 Text(
//                   Translator.translate("terms"),
//                   style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
//                       fontWeight: 600),
//                 ),
//               ],
//             )
//           ),
//
//           Container(
//             margin: Spacing.fromLTRB(30, 8, 16, 10),
//             child: Row(
//               children: [
//                 Icon(Icons.info_outline,color: AppColors.primaryColor,),
//                 SizedBox(width: 5,),
//                 Text(
//                   Translator.translate("about"),
//                   style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
//                       fontWeight: 600),
//                 ),
//               ],
//             )
//           ),
//
//
//
//         ],
//       );
//     } else {
//       return Container();
//     }
//   }
//
// }
