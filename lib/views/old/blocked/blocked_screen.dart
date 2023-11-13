// export 'package:userwasil/config/custom_package.dart';
//
//
// import '../../config/custom_package.dart';
// import '../../providers/darktheme.dart';
// import '../../utils/theme/theme.dart';
// import '../home/home_view/home_screen.dart';
//
//
// //----------------------------- Maintenance Screen -------------------------------//
//
// class BlockedScreen extends StatefulWidget {
//   const BlockedScreen({Key? key}) : super(key: key);
//
//   @override
//   BlockedScreenState createState() => BlockedScreenState();
// }
//
// class BlockedScreenState extends State<BlockedScreen> {
//   //ThemeData
//   late ThemeData themeData;
//   bool isInProgress = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   //Global Keys
//   final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//        GlobalKey<ScaffoldMessengerState>();
//
//   _checkBlockStatus() async {
//     setState(() {
//       isInProgress = true;
//     });
//
//     MyResponse myResponse = await AppDataController.getAppData();
//
//     if (myResponse.success) {
//       if (myResponse.data!.user != null) {
//         await AuthController.saveUserFromUser(myResponse.data!.user!);
//       }
//       AuthType authType = await AuthController.userAuthType();
//
//       if (authType == AuthType.VERIFIED) {
//
//         UserNavigator.of(context).pushReplacement(HomeScreen());
//       } else if (authType == AuthType.LOGIN) {
//         UserNavigator.of(context).pushAndRemoveUntil(OtpVerificationScreen());
//
//       } else if (authType == AuthType.BLOCKED) {
//         showMessage(message: "You are still blocked");
//       } else {
//         UserNavigator.of(context).pushReplacement( SignInScreen());
//
//       }
//     } else {
//       showMessage(message: "Please wait for some time");
//     }
//
//     setState(() {
//       isInProgress = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     themeData = Theme.of(context);
//     return Consumer<AppThemeNotifier>(
//       builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
//         return MaterialApp(
//             scaffoldMessengerKey: _scaffoldMessengerKey,
//             debugShowCheckedModeBanner: false,
//             theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
//             home: Scaffold(
//                 key: _scaffoldKey,
//
//                 body: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 3,
//                       child: isInProgress
//                           ? const LinearProgressIndicator(
//                               minHeight: 3,
//                             )
//                           : Container(
//                               height: 3,
//                             ),
//                     ),
//                     const Image(
//                       image: AssetImage('./assets/images/maintenance.png'),
//                     ),
//                     Container(
//                       margin: Spacing.top(24),
//                       child: UserText(
//                         title: Translator.translate("your_account_was_suspended"),
//
//                             textColor: themeData.colorScheme.onBackground,
//                             fontWeight:FontWeight.w600 ,
//                             letterSpacing: 0.2),
//
//                     ),
//                     Container(
//                       margin: Spacing.fromLTRB(24, 24, 24, 0),
//                       child: UserText(
//                         title: Translator.translate("Please_contact_admin_or_refresh"),
//
//                             textColor:  themeData.colorScheme.onBackground,
//                             fontWeight: FontWeight.w500),
//
//                       ),
//
//                     Spacing.height(16),
//                     Center(
//                       child: TextButton(
//                         onPressed: () {
//                           UrlUtils.sendMailToAdmin();
//                         },
//                         child: Text(Translator.translate("contact_admin")),
//                       ),
//                     ),
//                     Container(
//                         margin: Spacing.only(left: 56, right: 56, top: 24),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextButton(
//                               onPressed: () {
//                                 _checkBlockStatus();
//                               },
//                               child: UserText(
//                               title:   Translator.translate("refresh"),
//
//                                     textColor: themeData.colorScheme.onPrimary),
//
//                             ),
//                             TextButton(
//                               onPressed: () async {
//                                 UserNavigator.of(context).pushReplacement(SignInScreen());
//                               },
//                               child: UserText(
//                                 title: Translator.translate("logout"),
//
//                                    fontSize: 16.sp,
//                                     textColor: themeData.colorScheme.onPrimary),
//                               ),
//
//                           ],
//                         ))
//                   ],
//                 )));
//       },
//     );
//   }
//
//   void showMessage({String message = "Something wrong", Duration? duration}) {
//     duration ??= const Duration(seconds: 3);
//     _scaffoldMessengerKey.currentState!.showSnackBar(
//       SnackBar(
//         duration: duration,
//         content:
//         UserText(title:message ,
//             letterSpacing: 0.4,
//
//         ),
//         backgroundColor: themeData.colorScheme.primary,
//         behavior: SnackBarBehavior.fixed,
//       ),
//     );
//   }
// }
