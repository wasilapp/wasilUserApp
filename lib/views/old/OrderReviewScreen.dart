// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';
//
// import '../../api/api_util.dart';
// import '../../controllers/DeliveryBoyReviewController.dart';
// import '../../controllers/OrderController.dart';
// import '../../controllers/ShopReviewController.dart';
// import '../../models/Categories.dart';
// import '../../models/DeliveryBoyReview.dart';
// import '../../models/MyResponse.dart';
// import '../../models/OrderReview.dart';
// import '../../models/ProductItem.dart';
// import '../../models/ShopReview.dart';
// import '../../providers/darktheme.dart';
// import '../../services/AppLocalizations.dart';
// import '../../config/ColorUtils.dart';
// import '../../utils/ui/Generator.dart';
// import '../../utils/helper/ProductUtils.dart';
// import '../../utils/ui/RatingWidget.dart';
// import '../../utils/helper/size.dart';
// import '../../utils/helper/text.dart';
// import '../../utils/theme/theme.dart';
// import '../loading/LoadingScreens.dart';
//
// class OrderReviewScreen extends StatefulWidget {
//   final int? orderId;
//
//   const OrderReviewScreen({Key? key, this.orderId}) : super(key: key);
//
//   @override
//   _OrderReviewScreenState createState() => _OrderReviewScreenState();
// }
//
// class _OrderReviewScreenState extends State<OrderReviewScreen> {
//   //ThemeData
//   ThemeData? themeData;
//   CustomAppTheme? customAppTheme;
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
//   OrderReview? orderReview;
//
//   int shopRating = 5;
//   List<int> productRatings = [];
//   int deliveryRating = 5;
//
//   //Text Editor
//   TextEditingController? shopReviewTEController;
//   late List<TextEditingController> productReviewTEControllers;
//   TextEditingController? deliveryReviewTEController;
//   List<bool>? _dataExpansionPanel;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadOrderReviewData();
//     shopReviewTEController = TextEditingController();
//     productReviewTEControllers = [];
//     deliveryReviewTEController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     deliveryReviewTEController!.dispose();
//     shopReviewTEController!.dispose();
//     for (TextEditingController textEditingController
//         in productReviewTEControllers) {
//       textEditingController.dispose();
//     }
//   }
//
//   _loadOrderReviewData() async {
//     log("1");
//     setState(() {
//       isInProgress = true;
//     });
//     log("2");
//     MyResponse<OrderReview> myResponse =
//         await OrderController.getSingleOrderReview(widget.orderId);
//
//     log("3");
//
//     if (myResponse.success) {
//       orderReview = myResponse.data;
//      log("order review: " +orderReview!.shopReview.toString()) ;
//       log("4");
//     } else {
//       ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
//       showMessage(message: myResponse.errorText);
//     }
//
//     // for (int i = 0; i < orderReview!.carts.length; i++) {
//     //   productReviewTEControllers.add(TextEditingController());
//     //   productRatings.add(5);
//     // }
//
//     setState(() {
//       isInProgress = false;
//     });
//   }
//
//   Future<void> _refresh() async {
//     if (!isInProgress) _loadOrderReviewData();
//   }
//
//   _addReviewForShop() async {
//     if (shopRating < 1 || shopRating > 6) {
//       showMessage(
//           message: Translator.translate("please_rating_between_1_to_5"));
//
//       return;
//     }
//
//     String review = shopReviewTEController!.text;
//
//     setState(() {
//       isInProgress = true;
//     });
//
//     MyResponse myResponse = await ShopReviewController.addReview(
//         orderReview!.shopId, shopRating, review);
//     if (myResponse.success) {
//       showMessage(message: Translator.translate("Shop has been reviewed"));
//       orderReview!.shopReview = ShopReview(
//           0, shopRating, orderReview!.shopId, 0, review, DateTime.now());
//     } else {
//       ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
//       showMessage(message: myResponse.errorText);
//     }
//
//     setState(() {
//       isInProgress = false;
//     });
//   }
//
//   _addReviewForDelivery() async {
//     if (deliveryRating < 1 || deliveryRating > 6) {
//       showMessage(
//           message: Translator.translate("please_rating_between_1_to_5"));
//
//       return;
//     }
//
//     String review = deliveryReviewTEController!.text;
//
//     setState(() {
//       isInProgress = true;
//     });
//
//     MyResponse myResponse = await DeliveryBoyReviewController.addReview(
//         orderReview!.id, orderReview!.deliveryBoy!.id, deliveryRating, review);
//     if (myResponse.success) {
//       showMessage(
//           message: Translator.translate("Delivery boy has been reviewed"));
//       orderReview!.deliveryBoyReview = DeliveryBoyReview.forOrder(
//           0, deliveryRating, orderReview!.deliveryBoy!.id, review);
//     } else {
//      // ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
//       showMessage(message: myResponse.errorText);
//     }
//
//     setState(() {
//       isInProgress = false;
//     });
//   }
//
//   // _addReviewForProduct(int index) async {
//   //   if (productRatings[index] < 1 || productRatings[index] > 6) {
//   //     showMessage(
//   //         message: Translator.translate("please_rating_between_1_to_5"));
//   //     return;
//   //   }
//
//   //   String review = productReviewTEControllers[index].text;
//
//   //   setState(() {
//   //     isInProgress = true;
//   //   });
//
//   //   MyResponse myResponse = await ProductReviewController.addReview(
//   //       orderReview!.id,
//   //       orderReview!.carts[index].productItemId,
//   //       productRatings[index],
//   //       review);
//   //   if (myResponse.success) {
//   //     showMessage(message: Translator.translate("Product has been reviewed"));
//   //     orderReview!.productReviews!.add(ProductReview.dummy(
//   //         0,
//   //         productRatings[index],
//   //         orderReview!.id,
//   //         orderReview!.carts[index].productItemId,
//   //         0,
//   //         review));
//   //   } else {
//   //     ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
//   //     showMessage(message: myResponse.errorText);
//   //   }
//
//   //   setState(() {
//   //     isInProgress = false;
//   //   });
//   // }
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
//                 key: _scaffoldKey,
//                 appBar: AppBar(
//                   elevation: 0,
//                   leading: InkWell(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Icon(MdiIcons.chevronLeft),
//                   ),
//                   centerTitle: true,
//                   title: Text(Translator.translate("review"),
//                       // style: AppTheme.getTextStyle(
//                       //     themeData!.appBarTheme.textTheme!.headline6,
//                       //     fontWeight: 600)
//                   ),
//                   actions: [
//                     Container(
//                       margin: Spacing.right(8),
//                       child: IconButton(
//                           icon: Icon(MdiIcons.check,size: MySize.size22,),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           }),
//                     )
//                   ],
//                 ),
//                 body: RefreshIndicator(
//                   onRefresh: _refresh,
//                   backgroundColor: customAppTheme!.bgLayer1,
//                   color: themeData!.colorScheme.primary,
//                   key: _refreshIndicatorKey,
//                   child: Column(
//                     children: [
//                       Container(
//                         height: MySize.size3,
//                         child: isInProgress
//                             ? LinearProgressIndicator(
//                                 minHeight: MySize.size3,
//                               )
//                             : Container(
//                                 height: MySize.size3,
//                               ),
//                       ),
//                       Expanded(
//                           child: ListView(
//                         padding: Spacing.bottom(16),
//                         children: [_buildBody()],
//                       )),
//                     ],
//                   ),
//                 )));
//       },
//     );
//   }
//
//   _buildBody() {
//     if (orderReview != null) {
//       if (_dataExpansionPanel == null) {
//         int totalReviews =
//             (orderReview!.deliveryBoy != null ? 1 : 0) +
//             1;
//         _dataExpansionPanel = List.generate(totalReviews, (int index) => true);
//       }
//
//       return ExpansionPanelList(
//         expandedHeaderPadding: Spacing.zero as EdgeInsets,
//         expansionCallback: (int index, bool isExpanded) {
//           setState(() {
//             _dataExpansionPanel![index] = !isExpanded;
//           });
//         },
//         animationDuration: Duration(milliseconds: 500),
//         children: _buildExpansionPanels(_dataExpansionPanel!),
//       );
//     } else {
//       return LoadingScreens.getReviewLoadingScreen(
//           context, themeData, customAppTheme!);
//     }
//   }
//
//   List<ExpansionPanel> _buildExpansionPanels(List<bool> _dataExpansionPanel) {
//     List<ExpansionPanel> expansionPanels = [];
//
//     if( orderReview!.shop!=null){
//     expansionPanels.add(ExpansionPanel(
//         canTapOnHeader: true,
//         headerBuilder: (BuildContext context, bool isExpanded) {
//           return ListTile(
//             title: Text(Translator.translate("shop_review"),
//                 style: AppTheme.getTextStyle(themeData!.textTheme.bodyText1,
//                     color: isExpanded
//                         ? themeData!.colorScheme.primary
//                         : themeData!.colorScheme.onBackground,
//                     fontWeight: isExpanded ? 700 : 600)),
//           );
//         },
//         body: Container(
//           padding: Spacing.fromLTRB(16, 0, 16, 16),
//           child:  _buildShopReview(),
//         ),
//         isExpanded: _dataExpansionPanel[0]));
//     }
//
//     // for (int i = 0; i < orderReview!.carts.length; i++) {
//     //   expansionPanels.add(ExpansionPanel(
//     //       canTapOnHeader: true,
//     //       headerBuilder: (BuildContext context, bool isExpanded) {
//     //         return ListTile(
//     //           title: Text(
//     //               Translator.translate("product") + " #" + (i + 1).toString(),
//     //               style: AppTheme.getTextStyle(themeData!.textTheme.bodyText1,
//     //                   color: isExpanded
//     //                       ? themeData!.colorScheme.primary
//     //                       : themeData!.colorScheme.onBackground,
//     //                   fontWeight: isExpanded ? 700 : 600)),
//     //         );
//     //       },
//     //       body: Container(
//     //           padding: Spacing.fromLTRB(16, 0, 16, 16),
//     //           child: _buildProductReview(orderReview!.carts[i], i)),
//     //       isExpanded: _dataExpansionPanel[i + 1]));
//     // }
//
//     if (orderReview!.deliveryBoy != null) {
//       expansionPanels.add(ExpansionPanel(
//           canTapOnHeader: true,
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return ListTile(
//               title: Text(
//                   orderReview!.deliveryBoy!.name! +
//                       " (" +
//                       Translator.translate("delivery_review") +
//                       ")",
//                   style: AppTheme.getTextStyle(themeData!.textTheme.bodyText1,
//                       color: isExpanded
//                           ? themeData!.colorScheme.primary
//                           : themeData!.colorScheme.onBackground,
//                       fontWeight: isExpanded ? 700 : 600)),
//             );
//           },
//           body: Container(
//               padding: Spacing.fromLTRB(16, 0, 16, 16),
//               child: _buildDeliveryReview()),
//           isExpanded: _dataExpansionPanel[_dataExpansionPanel.length - 1]));
//     }
//
//     return expansionPanels;
//   }
//
//   _buildShopReview() {
//     bool validForReview = orderReview!.shopReview == null;
//
//     return Column(
//       children: [
//      orderReview!.shop==null ? Container() :   Container(
//           decoration: BoxDecoration(
//             color: themeData!.cardTheme.color,
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//             border: Border.all(color: customAppTheme!.bgLayer4, width: 1),
//           ),
//           padding: Spacing.all(8),
//           child: Row(
//             children: <Widget>[
//               ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
//                 child: orderReview!.shop!=null && orderReview!.shop!.imageUrl != null
//                     ? Image.network(
//                       TextUtils.getImageUrl(orderReview!.shop!.imageUrl)  ,
//                         loadingBuilder: (BuildContext ctx, Widget child,
//                             ImageChunkEvent? loadingProgress) {
//                           if (loadingProgress == null) {
//                             return child;
//                           } else {
//                             return LoadingScreens.getSimpleImageScreen(
//                                 context, themeData, customAppTheme!,
//                                 width: MySize.size90, height: MySize.size90);
//                           }
//                         },
//                         height: MySize.size90,
//                         width: MySize.size90,
//                         fit: BoxFit.cover,
//                       )
//                     : Image.asset(
//                         Shop.getPlaceholderImage(),
//                         height: MySize.size90,
//                         fit: BoxFit.fill,
//                       ),
//               ),
//           orderReview!.shop==null ? Container():    Expanded(
//                 child: Container(
//                   height: 90,
//                   margin: Spacing.left(16),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(orderReview!.shop!.name,
//                           style: AppTheme.getTextStyle(
//                               themeData!.textTheme.bodyText1,
//                               fontWeight: 700,
//                               letterSpacing: 0)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 10,),
//         orderReview!.shop==null ? Container() : Center(
//           child: Container(
//             margin: Spacing.top(8),
//             child: validForReview
//                 ? RatingWidget(
//                     onRatingChange: (newRating) {
//                       setState(() {
//                         shopRating = newRating;
//                       });
//                     },
//                     starSpacing: MySize.size2,
//                     starColor: StarColor(
//                         defaultColor:
//                             themeData!.colorScheme.onBackground.withAlpha(150),
//                         colors: [
//                           customAppTheme!.colorError,
//                           customAppTheme!.colorError.withAlpha(200),
//                           CustomAppTheme.starColor,
//                           customAppTheme!.colorSuccess.withAlpha(200),
//                           customAppTheme!.colorSuccess
//                         ]),
//                     starSize: MySize.size48,
//                   )
//                 : Generator.buildRatingStar(
//                     rating: orderReview!.shopReview!.rating!.toDouble(),
//                     size: MySize.size24,
//                     activeColor: ColorUtils.getColorFromRating(
//                         orderReview!.shopReview!.rating,
//                         customAppTheme,
//                         themeData),
//                     inactiveColor: themeData!.colorScheme.onBackground),
//           ),
//         ),
//       orderReview!.shop==null ? Container() :   Container(
//           margin: Spacing.fromLTRB(16, 16, 16, 0),
//           child: validForReview
//               ? TextFormField(
//                   decoration: InputDecoration(
//                     hintText: Translator.translate("describe_your_experience"),
//                     isDense: true,
//                     filled: true,
//                     fillColor: customAppTheme!.bgLayer3,
//                     border: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                   ),
//                   controller: shopReviewTEController,
//                   textCapitalization: TextCapitalization.sentences,
//                   minLines: 5,
//                   maxLines: 10,
//                 )
//               : Text(
//               orderReview!.shopReview!.review==null ? "" :    orderReview!.shopReview!.review!,
//                   style: AppTheme.getTextStyle(themeData!.textTheme.bodyText2,
//                       color: themeData!.colorScheme.onBackground),
//                 ),
//         ),
//         orderReview!.shop==null ? Container() : Center(
//           child: Container(
//             margin: Spacing.top(16),
//             child:ElevatedButton(
//
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(validForReview
//                        ? Color(0xff15CB95)
//                       : Color.fromARGB(255, 13, 116, 85)),
//                   padding: MaterialStateProperty.all(Spacing.xy(24, 12)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ))),
//               onPressed: () {
//                 if (validForReview) {
//                   _addReviewForShop();
//                 }
//               },
//               child: Text(
//                 validForReview
//                     ? Translator.translate("send_review")
//                     : Translator.translate("already_reviewed"),
//                 style: AppTheme.getTextStyle(themeData!.textTheme.bodyText1,
//                     color: validForReview
//                         ? themeData!.colorScheme.onPrimary
//                         : customAppTheme!.onDisabled),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   _buildDeliveryReview() {
//     bool validForReview = orderReview!.deliveryBoyReview == null;
//
//     return Column(
//       children: [
//         Center(
//           child: Container(
//             margin: Spacing.top(8),
//             child: validForReview
//                 ? RatingWidget(
//                     onRatingChange: (newRating) {
//                       setState(() {
//                         deliveryRating = newRating;
//                       });
//                     },
//                     starSpacing: MySize.size2,
//                     starColor: StarColor(
//                         defaultColor:
//                             themeData!.colorScheme.onBackground.withAlpha(150),
//                         colors: [
//                           customAppTheme!.colorError,
//                           customAppTheme!.colorError.withAlpha(200),
//                           CustomAppTheme.starColor,
//                           customAppTheme!.colorSuccess.withAlpha(200),
//                           customAppTheme!.colorSuccess
//                         ]),
//                     starSize: MySize.size30,
//                   )
//                 : Generator.buildRatingStar(
//                     rating: orderReview!.deliveryBoyReview!.rating!.toDouble(),
//                     size: MySize.size24,
//                     activeColor: ColorUtils.getColorFromRating(
//                         orderReview!.deliveryBoyReview!.rating,
//                         customAppTheme,
//                         themeData),
//                     inactiveColor: themeData!.colorScheme.onBackground),
//           ),
//         ),
//         Container(
//           margin: Spacing.fromLTRB(16, 16, 16, 0),
//           child: validForReview
//               ? TextFormField(
//                   decoration: InputDecoration(
//                     hintText: Translator.translate("describe_your_experience"),
//                     isDense: true,
//                     filled: true,
//                     fillColor: customAppTheme!.bgLayer3,
//                     border: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                   ),
//                   controller: deliveryReviewTEController,
//                   textCapitalization: TextCapitalization.sentences,
//                   minLines: 5,
//                   maxLines: 10,
//                 )
//               : Text(
//               orderReview!.deliveryBoyReview!.review ==null ? "" :    orderReview!.deliveryBoyReview!.review!,
//                   style: AppTheme.getTextStyle(themeData!.textTheme.bodyText2,
//                       color: themeData!.colorScheme.onBackground),
//                 ),
//         ),
//         Center(
//           child: Container(
//             margin: Spacing.top(16),
//             child: ElevatedButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(validForReview
//                       ? Color(0xff15CB95)
//                       : Color.fromARGB(255, 13, 116, 85)),
//                   padding: MaterialStateProperty.all(Spacing.xy(24, 12)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ))),
//               onPressed: () {
//                 if (validForReview) {
//                   _addReviewForDelivery();
//                 }
//               },
//               child: Text(
//                 validForReview
//                     ? Translator.translate("send_review")
//                     : Translator.translate("already_reviewed"),
//                 style: AppTheme.getTextStyle(themeData!.textTheme.bodyText1,
//                     color: validForReview
//                         ? themeData!.colorScheme.onPrimary
//                         : customAppTheme!.onDisabled),
//               ),
//
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // _buildProductReview(Cart cart, int index) {
//   //   ProductReview? productReview =
//   //       orderReview!.getProductItemReviewFromId(cart.productItemId);
//   //   bool validForReview = productReview == null;
//
//   //   return Column(
//   //     children: [
//   //       Container(
//   //         decoration: BoxDecoration(
//   //           color: themeData!.cardTheme.color,
//   //           borderRadius: BorderRadius.all(Radius.circular(8)),
//   //           border: Border.all(color: customAppTheme!.bgLayer4, width: 1),
//   //         ),
//   //         padding: Spacing.all(8),
//   //         child: InkWell(
//   //           onTap: (){
//   //             showDialog(
//   //                 context: context, builder: (BuildContext context) => _CartProductDialog(productItem: cart.productItem,customAppTheme: customAppTheme,));
//   //           },
//   //           child: Row(
//   //             children: <Widget>[
//   //               ClipRRect(
//   //                 borderRadius:
//   //                     BorderRadius.all(Radius.circular(MySize.size8!)),
//   //                 child: cart.product!.imageUrl.length != 0
//   //                     ? Image.network(
//   //                     TextUtils.getImageUrl( cart.product!.imageUrl,),
//   //                         loadingBuilder: (BuildContext ctx, Widget child,
//   //                             ImageChunkEvent? loadingProgress) {
//   //                           if (loadingProgress == null) {
//   //                             return child;
//   //                           } else {
//   //                             return LoadingScreens.getSimpleImageScreen(
//   //                                 context, themeData, customAppTheme!,
//   //                                 width: MySize.size90, height: MySize.size90);
//   //                           }
//   //                         },
//   //                         height: MySize.size90,
//   //                         width: MySize.size90,
//   //                         fit: BoxFit.cover,
//   //                       )
//   //                     : Image.asset(
//   //                         Product.getPlaceholderImage(),
//   //                         height: MySize.size90,
//   //                         fit: BoxFit.fill,
//   //                       ),
//   //               ),
//   //               Expanded(
//   //                 child: Container(
//   //                   height: 90,
//   //                   margin: Spacing.left(16),
//   //                   child: Column(
//   //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: <Widget>[
//   //                       Text(cart.product!.name!,
//   //                           style: AppTheme.getTextStyle(
//   //                               themeData!.textTheme.bodyText1,
//   //                               fontWeight: 700,
//   //                               letterSpacing: 0)),
//   //                       Text(
//   //                         CurrencyApi.getSign(afterSpace: true) +
//   //                             CurrencyApi.doubleToString(
//   //                                 Product.getOfferedPrice(
//   //                                     cart.productItem!.price.toDouble(),
//   //                                     cart.product!.offer)),
//   //                         style: AppTheme.getTextStyle(
//   //                             themeData!.textTheme.subtitle2,
//   //                             fontWeight: 600,
//   //                             letterSpacing: 0),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //       Center(
//   //         child: Container(
//   //           margin: Spacing.top(8),
//   //           child: validForReview
//   //               ? RatingWidget(
//   //                   onRatingChange: (newRating) {
//   //                     setState(() {
//   //                       productRatings[index] = newRating;
//   //                     });
//   //                   },
//   //                   starSpacing: MySize.size2,
//   //                   starColor: StarColor(
//   //                       defaultColor:
//   //                           themeData!.colorScheme.onBackground.withAlpha(150),
//   //                       colors: [
//   //                         customAppTheme!.colorError,
//   //                         customAppTheme!.colorError.withAlpha(200),
//   //                         CustomAppTheme.starColor,
//   //                         customAppTheme!.colorSuccess.withAlpha(200),
//   //                         customAppTheme!.colorSuccess
//   //                       ]),
//   //                   starSize: MySize.size30,
//   //                 )
//   //               : Generator.buildRatingStar(
//   //                   rating: productReview.rating!.toDouble(),
//   //                   size: MySize.size24,
//   //                   activeColor: ColorUtils.getColorFromRating(
//   //                       productReview.rating, customAppTheme, themeData),
//   //                   inactiveColor: themeData!.colorScheme.onBackground),
//   //         ),
//   //       ),
//   //       Container(
//   //         margin: Spacing.fromLTRB(16, 16, 16, 0),
//   //         child: validForReview
//   //             ? TextFormField(
//   //                 decoration: InputDecoration(
//   //                   hintText: Translator.translate("describe_your_experience"),
//   //                   isDense: true,
//   //                   filled: true,
//   //                   fillColor: customAppTheme!.bgLayer3,
//   //                   border: InputBorder.none,
//   //                   enabledBorder: InputBorder.none,
//   //                   focusedBorder: InputBorder.none,
//   //                 ),
//   //                 controller: productReviewTEControllers[index],
//   //                 textCapitalization: TextCapitalization.sentences,
//   //                 minLines: 5,
//   //                 maxLines: 10,
//   //               )
//   //             : Text(
//   //           productReview.review.length == 0
//   //                     ? Translator.translate("no_review")
//   //                     : productReview.review,
//   //                 style: AppTheme.getTextStyle(themeData!.textTheme.bodyText2,
//   //                     color: themeData!.colorScheme.onBackground),
//   //               ),
//   //       ),
//   //       Center(
//   //         child: Container(
//   //           margin: Spacing.top(16),
//   //           child: ElevatedButton(
//   //             style: ButtonStyle(
//   //                 backgroundColor: MaterialStateProperty.all(validForReview
//   //                     ? themeData!.primaryColor
//   //                     : customAppTheme!.disabledColor),
//   //                 padding: MaterialStateProperty.all(Spacing.xy(24, 12)),
//   //                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(4),
//   //                 ))),
//   //             onPressed: () {
//   //               if (validForReview) {
//   //                 _addReviewForProduct(index);
//   //               }
//   //             },
//   //             child: Text(
//   //               validForReview
//   //                   ? Translator.translate("send_review")
//   //                   : Translator.translate("already_reviewed"),
//   //               style: AppTheme.getTextStyle(themeData!.textTheme.bodyText1,
//   //                   color: validForReview
//   //                       ? themeData!.colorScheme.onPrimary
//   //                       : customAppTheme!.onDisabled),
//   //             ),
//
//   //           ),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }
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
//
//
//
// class _CartProductDialog extends StatefulWidget {
//   final ProductItem? productItem;
//   final CustomAppTheme? customAppTheme;
//
//   const _CartProductDialog(
//       {Key? key, required this.productItem, required this.customAppTheme})
//       : super(key: key);
//
//   @override
//   __CartProductDialogState createState() => __CartProductDialogState();
// }
//
// class __CartProductDialogState extends State<_CartProductDialog> {
//   @override
//   Widget build(BuildContext context) {
//     ThemeData themeData = Theme.of(context);
//     return Dialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0))),
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: new BoxDecoration(
//           color: themeData.backgroundColor,
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(4),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10.0,
//               offset: const Offset(0.0, 10.0),
//             ),
//           ],
//         ),
//         child: ProductUtils.singleProductItemOption(
//             widget.productItem!, themeData, widget.customAppTheme),
//       ),
//     );
//   }
// }
//
