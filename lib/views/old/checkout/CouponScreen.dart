//
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';
//
// import '../../api/api_util.dart';
// import '../../api/currency_api.dart';
// import '../../controllers/UserCouponController.dart';
// import '../../models/Coupon.dart';
// import '../../models/MyResponse.dart';
// import '../../providers/darktheme.dart';
// import '../../services/AppLocalizations.dart';
// import '../../utils/helper/size.dart';
// import '../../utils/theme/theme.dart';
// import '../loading/LoadingScreens.dart';
//
// class CouponScreen extends StatefulWidget {
//   final double order;
//   final int? shopId;
//
//   const CouponScreen({Key? key, required this.order, required this.shopId})
//       : super(key: key);
//
//   @override
//   _CouponScreenState createState() => _CouponScreenState();
// }
//
// class _CouponScreenState extends State<CouponScreen> {
//   //ThemeData
//   ThemeData? themeData;
//   late CustomAppTheme customAppTheme;
//
//   //Global Keys
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//       new GlobalKey<ScaffoldMessengerState>();
//
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       new GlobalKey<RefreshIndicatorState>();
//
//   //Other Variables
//   bool isInProgress = false;
//   List<Coupon>? coupons = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCouponData();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   _loadCouponData() async {
//     if (mounted) {
//       setState(() {
//         isInProgress = true;
//       });
//     }
//
//     MyResponse<List<Coupon>> myResponse = await UserCouponController.getCouponForShop(widget.shopId);
//     if (myResponse.success) {
//       coupons = myResponse.data;
//     } else {
//       ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
//       showMessage(message: myResponse.errorText);
//     }
//
//     if (mounted) {
//       setState(() {
//         isInProgress = false;
//       });
//     }
//   }
//
//   Future<void> _refresh() async {
//     if (!isInProgress) _loadCouponData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppThemeNotifier>(
//       builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
//         int themeType = value.themeMode();
//         themeData = AppTheme.getThemeFromThemeMode(themeType);
//         customAppTheme = AppTheme.getCustomAppTheme(themeType);
//         return MaterialApp(
//             scaffoldMessengerKey: _scaffoldMessengerKey,
//             debugShowCheckedModeBanner: false,
//             theme: themeData,
//             home: Scaffold(
//                 backgroundColor: customAppTheme.bgLayer1,
//                 key: _scaffoldKey,
//                 appBar: AppBar(
//                   backgroundColor: customAppTheme.bgLayer1,
//                   elevation: 0,
//                   leading: InkWell(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Icon(MdiIcons.chevronLeft),
//                   ),
//                   centerTitle: true,
//                   title: Text(Translator.translate("coupons"),
//                       // style: AppTheme.getTextStyle(
//                       //     themeData!.appBarTheme.textTheme!.headline6,
//                       //     fontWeight: 600)
//                   ),
//                 ),
//                 body: RefreshIndicator(
//                   onRefresh: _refresh,
//                   backgroundColor: customAppTheme.bgLayer1,
//                   color: themeData!.colorScheme.primary,
//                   key: _refreshIndicatorKey,
//                   child: ListView(
//                     padding: Spacing.zero,
//                     children: [
//                       Container(
//                         height: 3,
//                         child: isInProgress
//                             ? LinearProgressIndicator(
//                                 minHeight: 3,
//                               )
//                             : Container(
//                                 height: 3,
//                               ),
//                       ),
//                       _buildBody()
//                     ],
//                   ),
//                 )));
//       },
//     );
//   }
//
//   _buildBody() {
//     if (coupons!.length != 0) {
//       return _buildCouponsView(coupons!);
//     } else if (isInProgress) {
//       return LoadingScreens.getCouponLoadingScreen(
//           context, themeData, customAppTheme);
//     } else {
//       return Center(
//         child: Text(
//             Translator.translate("there_is_no_coupon_available_for_this_shop")),
//       );
//     }
//   }
//
//   _buildCouponsView(List<Coupon> coupons) {
//     List<Widget> list = [];
//     for (Coupon coupon in coupons) {
//       list.add(_singleCoupon(coupon: coupon, order: widget.order));
//     }
//
//     return Column(
//       children: list,
//     );
//   }
//
//   Widget _singleCoupon({required Coupon coupon, required double order}) {
//     bool isValidate = order >= coupon.minOrder;
//
//     return Container(
//       margin: Spacing.fromLTRB(16, 8, 16, 8),
//       padding: Spacing.all(16),
//       decoration: BoxDecoration(
//           color: customAppTheme.bgLayer1,
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           border: Border.all(color: customAppTheme.bgLayer4)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('./assets/images/offer-icon.png'),
//                       fit: BoxFit.fill),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: Spacing.only(left: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("#" + coupon.code,
//                           style: AppTheme.getTextStyle(
//                               themeData!.textTheme.bodyText2,
//                               color: themeData!.colorScheme.onBackground,
//                               fontWeight: 600,
//                               letterSpacing: 0.2)),
//                       Text(coupon.description,
//                           style: AppTheme.getTextStyle(
//                               themeData!.textTheme.bodyText2,
//                               color: themeData!.colorScheme.onBackground,
//                               fontWeight: 500)),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Container(
//             margin: Spacing.only(top: 8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 Expanded(
//                   child: Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           Translator.translate("expired_at"),
//                           style: AppTheme.getTextStyle(
//                               themeData!.textTheme.caption,
//                               muted: true,
//                               fontWeight: 500),
//                         ),
//                         Text(
//                             coupon.expiredAt.day.toString() +
//                                 "-" +
//                                 coupon.expiredAt.month.toString() +
//                                 "-" +
//                                 coupon.expiredAt.year.toString(),
//                             style: AppTheme.getTextStyle(
//                                 themeData!.textTheme.caption,
//                                 fontWeight: 600,
//                                 letterSpacing: 0.25)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(isValidate
//                               ? themeData!.colorScheme.primary
//                               : customAppTheme.disabledColor),
//                           padding:
//                               MaterialStateProperty.all(Spacing.xy(20, 12)),
//                           shape:
//                               MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ))),
//                       onPressed: () {
//                         if (isValidate) Navigator.pop(context, coupon);
//
//                         if(!isValidate) showMessage(message: Translator.translate("order_minimum") + " : " + coupon.minOrder.toString() +        CurrencyApi.getSign(afterSpace: false) );
//                       },
//                       child: Text(Translator.translate("apply").toUpperCase(),
//                           style: AppTheme.getTextStyle(
//                             themeData!.textTheme.caption,
//                             fontSize: 15,
//                             fontWeight: 600,
//                             color: isValidate
//                                 ? themeData!.colorScheme.onPrimary
//                                 : customAppTheme.onDisabled,
//                           ))),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             margin: Spacing.top(8),
//             child: isValidate
//                 ? Container() : Text(
//               Translator.translate("minimum_order_value_is")+ " " + CurrencyApi.getSign(afterSpace: true)+
//                         CurrencyApi.doubleToString(coupon.minOrder),
//               style: AppTheme.getTextStyle(themeData!.textTheme.caption,
//                         color: customAppTheme.colorError),
//                   )
//                 ,
//           )
//         ],
//       ),
//     );
//   }
//
//   void showMessage({String message = "Something wrong", Duration? duration}) {
//     if (duration == null) {
//       duration = Duration(seconds: 3);
//     }
//     _scaffoldMessengerKey.currentState!.showSnackBar(
//       SnackBar(
//         duration: duration,
//         content: Text(message,
//             style: AppTheme.getTextStyle(themeData!.textTheme.subtitle2,
//                 letterSpacing: 0.4, color: themeData!.colorScheme.onPrimary)),
//         backgroundColor: themeData!.colorScheme.primary,
//         behavior: SnackBarBehavior.fixed,
//       ),
//     );
//   }
// }
