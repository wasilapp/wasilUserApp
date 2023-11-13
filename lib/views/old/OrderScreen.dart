//
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
//
//
//
//
// import '../../config/custom_package.dart';
// import '../../controllers/OrderController.dart';
// import '../../models/MyResponse.dart';
// import '../../models/Order.dart';
// import '../../models/Product.dart';
// import '../../providers/darktheme.dart';
// import '../../services/AppLocalizations.dart';
// import '../../utils/helper/UrlUtils.dart';
// import '../../utils/helper/size.dart';
// import '../../utils/helper/text.dart';
// import '../../utils/theme/theme.dart';
// import '../loading/LoadingScreens.dart';
// import 'OrderReviewScreen.dart';
// import '../SingleOrderScreen.dart';
//
// class OrderScreen extends StatefulWidget {
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }
//
// class _OrderScreenState extends State<OrderScreen> {
//   //ThemeData
//   ThemeData? themeData;
//   late CustomAppTheme customAppTheme;
//
//   //Global Keys
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//       new GlobalKey<ScaffoldMessengerState>();
//
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       new GlobalKey<RefreshIndicatorState>();
//
//   //Other Variables
//   bool isInProgress = false;
//   List<Order>? orders = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _initOrderData();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   _initOrderData() async {
//     if (mounted) {
//       setState(() {
//         isInProgress = true;
//       });
//     }
//
//     MyResponse<List<Order>> myResponse = await OrderController.getAllOrder();
//     if (myResponse.success) {
//       orders = myResponse.data;
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
//     _initOrderData();
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
//             theme: AppTheme.getThemeFromThemeMode(themeType),
//             home: Scaffold(
//                 backgroundColor: customAppTheme.bgLayer2,
//                 appBar: AppBar(
//                   elevation: 0,
//                   backgroundColor: customAppTheme.bgLayer2,
//                   leading: InkWell(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Icon(
//                       MdiIcons.chevronLeft,
//                       color: themeData!.colorScheme.onBackground,
//                     ),
//                   ),
//                   centerTitle: true,
//                   title: Text(Translator.translate("orders"),
//                       style: AppTheme.getTextStyle(
//                           themeData!.textTheme.subtitle1,
//                           fontWeight: 600)),
//                 ),
//                 body: RefreshIndicator(
//                     onRefresh: _refresh,
//                     backgroundColor: customAppTheme.bgLayer1,
//                     color: themeData!.colorScheme.primary,
//                     key: _refreshIndicatorKey,
//                     child: ListView(
//                       children: [
//                         Container(
//                           height: MySize.size3,
//                           child: isInProgress
//                               ? LinearProgressIndicator(
//                                   minHeight: MySize.size3,
//                                 )
//                               : Container(
//                                   height: MySize.size3,
//                                 ),
//                         ),
//                         _buildBody()
//                       ],
//                     ))));
//       },
//     );
//   }
//
//   _buildBody() {
//     if (orders!.length != 0) {
//       return _getOrderView(orders!);
//     } else if (isInProgress) {
//       return LoadingScreens.getOrderLoadingScreen(
//           context, themeData, customAppTheme);
//     } else {
//       return Center(
//         child: Text(Translator.translate("there_is_no_order")),
//       );
//     }
//   }
//
//   _getOrderView(List<Order> orders) {
//     List<Widget> listViews = [];
//     for (int i = 0; i < orders.length; i++) {
//       listViews.add(InkWell(
//         onTap: () async {
//           if (Order.isCancelled(orders[i].status!)) {
//             return;
//           }
//           if (Order.checkStatusDelivered(orders[i].status!)) {
//
//             showModalBottomSheet(context: context, builder:(context) {
//               return OrderReviewScreen(
//                           orderId: orders[i].id,
//                         );
//             },);
//             // await Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (BuildContext context) => OrderReviewScreen(
//             //               orderId: orders[i].id,
//             //             )));
//             _refresh();
//           } else if (Order.checkStatusReviewed(orders[i].status!)) {
//           }
//           else if (orders[i].status ==1 ) {
//
//           }
//           else if (Order.checkWaitForPayment(orders[i].status!)) {
//             // if (Order.isPaymentByRazorpay(
//             //     orders[i].orderPayment!.paymentType)) {
//             //   await Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //           builder: (BuildContext context) => RazorpayPaymentScreen(
//             //                 orderId: orders[i].id,
//             //               )));
//             // } else if (Order.isPaymentByPaystack(
//             //     orders[i].orderPayment!.paymentType)) {
//             //   await Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //           builder: (BuildContext context) => PaystackPaymentScreen(
//             //                 orderId: orders[i].id,
//             //               )));
//             // } else if (Order.isPaymentByStripe(
//             //     orders[i].orderPayment!.paymentType)) {
//             //   await Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //           builder: (BuildContext context) => StripePaymentScreen(
//             //                 orderId: orders[i].id,
//             //               )));
//             // }
//             _refresh();
//           } else {
//             await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (BuildContext context) => SingleOrderScreen(
//                           order: orders[i],
//                         )));
//             _refresh();
//           }
//         },
//         child: _singleOrderItem(orders[i]),
//       ));
//     }
//     return Container(
//       margin: Spacing.horizontal(16),
//       child: Column(
//         children: listViews,
//       ),
//     );
//   }
//
//   _singleOrderItem(Order order) {
//     //Logic for row items
//     double space = MySize.size16!;
//     double width =
//         (MySize.screenWidth - MySize.getScaledSizeHeight(83) - (2 * space)) / 3;
//
//     List<Widget> _itemWidget = [];
//     for (int i = 0; i < order.carts.length; i++) {
//       if (i == 2 && order.carts.length > 3) {
//         _itemWidget.add(
//           ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
//             child: Container(
//               color: customAppTheme.bgLayer3,
//               height: width,
//               width: width,
//               child: Center(
//                   child: Text(
//                 "+" + (order.carts.length - 2).toString(),
//                 style: AppTheme.getTextStyle(themeData!.textTheme.subtitle1,
//                     letterSpacing: 0.5,
//                     color: themeData!.colorScheme.onBackground,
//                     fontWeight: 600),
//               )),
//             ),
//           ),
//         );
//         break;
//       } else {
//         _itemWidget.add(
//           Container(
//               margin: (i == 2) ? Spacing.zero : Spacing.only(right: space),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
//                 child: order.carts[i].product!.imageUrl.length != 0
//                     ? Image.network(
//                        TextUtils.getImageUrl(order.carts[i].product!.imageUrl)  ,
//                         loadingBuilder: (BuildContext ctx, Widget child,
//                             ImageChunkEvent? loadingProgress) {
//                           if (loadingProgress == null) {
//                             return child;
//                           } else {
//                             return LoadingScreens.getSimpleImageScreen(
//                                 context, themeData, customAppTheme,
//                                 width: MySize.size90, height: MySize.size90);
//                           }
//                         },
//                         height: MySize.size90,
//                         width: MySize.size90,
//                         fit: BoxFit.cover,
//                       )
//                     : Image.asset(
//                         Product.getPlaceholderImage(),
//                         height: MySize.size90,
//                         fit: BoxFit.fill,
//                       ),
//               )),
//         );
//       }
//     }
//
//     return Container(
//       padding: Spacing.all(16),
//       margin: Spacing.only(top: 0, bottom: 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
//         color: customAppTheme.bgLayer1,
//         border: Border.all(color: customAppTheme.bgLayer3, width: 1.5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//
//                SizedBox(height: 8,),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//
//
//                     FittedBox(
//                       child: Text(
//                         Translator.translate("order") + " " + order.id.toString(),
//                         style: AppTheme.getTextStyle(
//                             themeData!.textTheme.subtitle1,
//                             fontWeight: 700,
//                             letterSpacing: -0.2),
//                       ),
//                     ),
//                     Container(
//                       margin: Spacing.only(top: 4),
//                       child: Text(
//                         CurrencyApi.getSign(afterSpace: true) +
//                             CurrencyApi.doubleToString(order.total),
//                         style: AppTheme.getTextStyle(
//                             themeData!.textTheme.bodyText2,
//                             fontWeight: 600,
//                             letterSpacing: 0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(width: 10,),
//
//
//           Order.isSuccessfulDelivered(order.status!) ?    Container(
//                 padding: Spacing.fromLTRB(12, 8, 12, 8),
//                 decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.all(Radius.circular(MySize.size4!)),
//                     color: Order.isCancelled(order.status!)
//                         ? customAppTheme.colorError
//                         : (Order.isSuccessfulDelivered(order.status!)
//                             ? customAppTheme.colorSuccess
//                             : customAppTheme.bgLayer3)),
//                 child: Image.asset("assets/images/rate.png",width: MediaQuery.of(context).size.width* 0.1,height:MediaQuery.of(context).size.width* 0.1 ,)
//               ):Container(),
//             ],
//           ),
//               SizedBox(height: 8,),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                  children: [
//                    Container(
//              //   padding: Spacing.fromLTRB(12, 8, 12, 8),
//              padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                         borderRadius:
//                             BorderRadius.all(Radius.circular(MySize.size4!)),
//                         color: Order.isCancelled(order.status!)
//                             ? customAppTheme.colorError
//                             : (Order.isSuccessfulDelivered(order.status!)
//                                 ? customAppTheme.colorSuccess
//                                 : customAppTheme.bgLayer3)),
//                     child: Text(
//                      Order.getTextFromOrderStatus(order.status!, order.orderType)
//                           .toUpperCase(),
//                       style: AppTheme.getTextStyle(themeData!.textTheme.caption,
//
//                           fontWeight: 700,
//                           color: Order.isCancelled(order.status!)
//                               ? customAppTheme.onError
//                               : (Order.isSuccessfulDelivered(order.status!)
//                                   ? customAppTheme.onSuccess
//                                   : themeData!.colorScheme.onBackground),
//                           letterSpacing: 0.25),
//                     ),
//               ),
//                  ],
//                ),
//       SizedBox(height: 8,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text("OTP : " + order.otp.toString(),
//                           style: AppTheme.getTextStyle(themeData!.textTheme.caption,
//                               fontWeight: 600,
//                               color: themeData!.colorScheme.onBackground)),
//               ],
//             ),
//
//           order.orderTime!=null?     Container(
//               margin: Spacing.only(top: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     Translator.translate("orderTime"),
//                       // Generator.convertDateTimeToText( order.createdAt,
//                       //     showSecond: false),
//                       style: AppTheme.getTextStyle(themeData!.textTheme.caption,
//                           fontWeight: 600,
//                           letterSpacing: -0.1,
//                           color: themeData!.colorScheme.onBackground
//                               .withAlpha(160))),
//                   Text( order.orderTime!.orderDate.toString()+ " - " +order.orderTime!.orderTime.toString(),
//                       style: AppTheme.getTextStyle(themeData!.textTheme.caption,
//                           fontWeight: 600,
//                           color: themeData!.colorScheme.onBackground)),
//                 ],
//               )):Container(),
//           Container(
//             margin: Spacing.only(top: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: _itemWidget,
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerRight,
//             child: ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(
//                         themeData!.colorScheme.primary.withAlpha(28)),
//                     shadowColor: MaterialStateProperty.all(
//                         themeData!.colorScheme.primary.withAlpha(28)),
//                     overlayColor: MaterialStateProperty.all(
//                         themeData!.colorScheme.primary.withAlpha(28)),
//                     foregroundColor: MaterialStateProperty.all(
//                         themeData!.colorScheme.primary.withAlpha(28)),
//                     padding: MaterialStateProperty.all(Spacing.xy(24, 12)),
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ))),
//                 onPressed: () {
//                   UrlUtils.goToOrderReceipt(order.id);
//                 },
//                 child: Text(
//                   Translator.translate("receipt").toUpperCase(),
//                   style: AppTheme.getTextStyle(themeData!.textTheme.caption,
//                       fontWeight: 600, color: themeData!.colorScheme.primary),
//                 )),
//           ),
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
