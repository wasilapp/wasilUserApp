// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';
//
// import '../../api/api_util.dart';
// import '../../api/currency_api.dart';
// import '../../controllers/OrderController.dart';
// import '../../models/DeliveryBoy.dart';
// import '../../models/MyResponse.dart';
// import '../../models/Order.dart';
// import '../../providers/darktheme.dart';
// import '../../services/AppLocalizations.dart';
// import '../../services/FirestoreServices.dart';
// import '../../config/ColorUtils.dart';
// import '../../utils/helper/GoogleMapUtils.dart';
// import '../../utils/helper/UrlUtils.dart';
// import '../../utils/helper/size.dart';
// import '../../utils/theme/theme.dart';
// import 'OrderReviewScreen.dart';
//
// class SingleOrderScreen extends StatefulWidget {
//   final order;
//
//   const SingleOrderScreen({Key? key, this.order}) : super(key: key);
//
//   @override
//   _SingleOrderScreenState createState() => _SingleOrderScreenState();
// }
//
// class _SingleOrderScreenState extends State<SingleOrderScreen> {
//   //ThemeData
//   late ThemeData themeData;
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
//   //Google Maps
//   late BitmapDescriptor shopPinIcon, deliveryPinIcon, deliveryBoyPinIcon;
//   GoogleMapController? mapController;
//   bool loaded = false;
//   final Set<Marker> _markers = Set();
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//   LatLng? currentPosition;
//   String? mapDarkStyle;
//
//   //Locations
//   LatLng? deliveryLocation;
//   LatLng? deliveryBoyLocation;
//   late LatLng? shopLocation;
//
//   //Other variables
//   bool isInProgress = false;
//   Order? order;
//
//   Timer? _timer;
//
//   DeliveryBoy? deliveryBoy;
//
//   int _index = 0;
//
//     getDeliveryBoy()async{
//
//
//
//       if(widget.order.deliveryBoyId!=null  ){
//
//
//             deliveryBoy= await FirestoreServices().getDeliveryBoy(widget.order.deliveryBoyId);
//             deliveryBoyLocation = LatLng(deliveryBoy!.latitude!, deliveryBoy!.longitude!);
//             await _setCustomPin();
//             await _changeDeliveryPin();
//
//           Marker? deliveryBoyMarker;
//           if (deliveryBoyLocation != null) {
//               deliveryBoyMarker = Marker(
//                   markerId: MarkerId('delivery_boy_location'),
//                   position: deliveryBoyLocation!,
//                   icon: deliveryBoyPinIcon,
//                   onTap: () {
//                     _onMarkerTapped(deliveryBoyLocation!);
//                   });
//               if (deliveryBoyLocation != null) {
//                 _markers.add(deliveryBoyMarker);
//                  mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: deliveryBoyLocation!)));
//               }
//             }
//             setState(() {
//
//             });
//       }
//
//
//     }
//   @override
//   void initState() {
//
//
//     super.initState();
//
//
//       currentPosition = _center;
//           order=widget.order;
//         if(widget.order!.shop  !=null){
//              shopLocation = LatLng(widget.order!.shop!.latitude, widget.order!.shop!.longitude);
//         }
//
//      deliveryLocation =
//           LatLng(widget.order!.latitude, widget.order!.longitude);
//
//
//
//      _setCustomPin();
//      getDeliveryBoy();
//
//
//
//
//
//    // _getOrderData();
//
//
//     _setTimer();
//    // _setTimer();
//   }
//
//   // _getOrderData() async {
//   //   if (mounted) {
//   //     setState(() {
//   //       isInProgress = true;
//   //     });
//   //   } else {
//   //     return;
//   //   }
//
//   //   MyResponse<Order> myResponse =
//   //       await OrderController.getSingleOrder(widget.orderId);
//   //   if (myResponse.success) {
//   //     order = myResponse.data;
//   //     shopLocation = LatLng(order!.shop!.latitude, order!.shop!.longitude);
//   //     if (!Order.isPickUpOrder(order!.orderType)) {
//   //       deliveryLocation =
//   //           LatLng(double.parse(order!.address!.latitude.toString())  , double.parse(order!.address!.longitude.toString()));
//   //     }
//
//   //     if (order!.deliveryBoy != null) {
//   //       if (order!.deliveryBoy!.latitude != null &&
//   //           order!.deliveryBoy!.longitude != null) {
//   //         deliveryBoyLocation = LatLng(
//   //             order!.deliveryBoy!.latitude!, order!.deliveryBoy!.longitude!);
//   //         _changeDeliveryPin();
//   //       }
//   //     }
//   //   } else {
//   //     ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
//   //     showMessage(message: myResponse.errorText);
//   //   }
//
//   //   if (mounted) {
//   //     setState(() {
//   //       isInProgress = false;
//   //     });
//   //   }
//   // }
//
//   _setCustomPin() async {
//     shopPinIcon = BitmapDescriptor.fromBytes(
//         await GoogleMapUtils.getBytesFromAsset('assets/map/shop-pin.png',
//             MySize.getScaledSizeHeight(128).floor()));
//
//     deliveryPinIcon = BitmapDescriptor.fromBytes(
//         await GoogleMapUtils.getBytesFromAsset('assets/map/delivery-pin.png',
//             MySize.getScaledSizeHeight(100).floor()));
//
//     deliveryBoyPinIcon = BitmapDescriptor.fromBytes(
//         await GoogleMapUtils.getBytesFromAsset(
//             'assets/map/delivery-boy-pin.png',
//             MySize.getScaledSizeHeight(60).floor()));
//
//                       if (deliveryLocation != null) {
//       log("in delivery Location");
//      Marker locationMarker = Marker(
//           markerId: MarkerId('delivery_location'),
//           position: deliveryLocation!,
//           icon: deliveryPinIcon,
//           onTap: () {
//             _onMarkerTapped(deliveryLocation!);
//           });
//       if (deliveryBoyLocation != null) {
//         _markers.add(locationMarker);
//       }
//     }
//     if(widget.order!.shop !=null){
//               Marker shopMarker = Marker(
//         markerId: MarkerId('shop_location'),
//         position: shopLocation!,
//         icon: shopPinIcon,
//         onTap: () {
//           _onMarkerTapped(shopLocation!);
//         });
//       _markers.add(shopMarker);
//     }
//
//
//     String mapStyle =
//         await rootBundle.loadString('assets/map/map-dark-style.txt');
//
//     if (mounted) {
//       setState(() {
//         mapDarkStyle = mapStyle;
//       });
//     }
//   }
//
//   _changeDeliveryPin() {
//     Marker deliveryBoyMarker;
//     if (deliveryBoyLocation != null) {
//       deliveryBoyMarker = Marker(
//           markerId: MarkerId('delivery_boy_location'),
//           position: deliveryBoyLocation!,
//           icon: deliveryBoyPinIcon);
//       if (mounted) {
//         setState(() {
//           _markers.add(deliveryBoyMarker);
//         });
//       }
//     }
//   }
//
//   _onMarkerTapped(LatLng latLng) async {
//     double zoom = await (mapController!.getZoomLevel());
//     zoom = zoom > 17 ? zoom : 17;
//     mapController!.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target: latLng, zoom: zoom)));
//   }
//
//   _setMapStyle(int themeMode) {
//     if (themeMode == 2 && mapDarkStyle != null && mapController != null) {
//       mapController!.setMapStyle(mapDarkStyle);
//     } else if (mapController != null) {
//       mapController!.setMapStyle("[]");
//     }
//   }
//
//   _onMapCreated(GoogleMapController controller) async {
//     mapController = controller;
//
//     mapController!.setMapStyle(mapDarkStyle);
//    Marker? shopMarker;
//     if(widget.order!.shop!=null){
//          shopMarker = Marker(
//         markerId: MarkerId('shop_location'),
//         position: shopLocation!,
//         icon: shopPinIcon,
//         onTap: () {
//           _onMarkerTapped(shopLocation!);
//         });
//     }
//
//
//     Marker? locationMarker;
//     if (deliveryLocation != null) {
//       log("in delivery Location");
//       locationMarker = Marker(
//           markerId: MarkerId('delivery_location'),
//           position: deliveryLocation!,
//           icon: deliveryPinIcon,
//           onTap: () {
//             _onMarkerTapped(deliveryLocation!);
//           });
//       if (deliveryBoyLocation != null) {
//         _markers.add(locationMarker);
//       }
//     }
//
//     Marker? deliveryBoyMarker;
//     if (deliveryBoyLocation != null) {
//       deliveryBoyMarker = Marker(
//           markerId: MarkerId('delivery_boy_location'),
//           position: deliveryBoyLocation!,
//           icon: deliveryBoyPinIcon,
//           onTap: () {
//             _onMarkerTapped(deliveryBoyLocation!);
//           });
//       if (deliveryBoyLocation != null) {
//         _markers.add(deliveryBoyMarker);
//
//
//         // mapController!.moveCamera(CameraUpdate.newLatLng(deliveryBoyLocation!));
//       }
//
//     }
//
//     if (mounted) {
//       setState(() {
//         if(widget.order!.shop !=null){
//              _markers.add(shopMarker!);
//         }
//
//       });
//     }
//   }
//
//   _changeStatus(int status) async {
//     if (mounted) {
//       setState(() {
//         isInProgress = true;
//       });
//     }
//
//     MyResponse myResponse =
//         await OrderController.updateOrder(order!.id, status);
//     if (myResponse.success) {
//       if (Order.isCancelled(status)) {
//         Navigator.pop(context);
//         return;
//       }
//
//       _refresh();
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
//   @override
//   void dispose() {
//     super.dispose();
//     mapController!.dispose();
//     if (_timer != null) _timer!.cancel();
//   }
//
//   Future<void> _refresh() async {
//    // _getOrderData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppThemeNotifier>(
//       builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
//         int themeType = value.themeMode();
//         _setMapStyle(themeType);
//         themeData = AppTheme.getThemeFromThemeMode(themeType);
//         customAppTheme = AppTheme.getCustomAppTheme(themeType);
//         return MaterialApp(
//             scaffoldMessengerKey: _scaffoldMessengerKey,
//             debugShowCheckedModeBanner: false,
//             theme: AppTheme.getThemeFromThemeMode(themeType),
//             home: Scaffold(
//                 key: _scaffoldKey,
//                 backgroundColor: customAppTheme.bgLayer1,
//                 appBar: AppBar(
//                   toolbarHeight: 90,
//                   backgroundColor: Color(0xff15CB95),
//                   centerTitle: true,
//                   title: Text(Translator.translate("order"),style: TextStyle(color: Colors.white,fontSize: 24),),),
//                 body: RefreshIndicator(
//                     onRefresh: _refresh,
//                     backgroundColor: customAppTheme.bgLayer1,
//                     color: themeData.colorScheme.primary,
//                     key: _refreshIndicatorKey,
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: order != null
//                               ? SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//
//                                       Container(
//                                              width: MediaQuery.of(context).size.width ,
//                                             height: MediaQuery.of(context).size.height*0.12,
//                                         child: Theme(
//                                           data: ThemeData(canvasColor: Colors.white,     colorScheme: Theme.of(context).colorScheme.copyWith(
//                                                             primary: Color(0xff15CB95),
//
//                                                             secondary: Color(0xff15CB95),
//
//                                                           ),),
//                                           child: Stepper(
//
//                                             currentStep: _index,
//                                             type: StepperType.horizontal,
//
//                                             steps: [
//                                                 Step(
//                                                    state: order!.status==2 || order!.status==4  ? StepState.complete : StepState.disabled,
//                                                   isActive: order!.status==2 || order!.status==4  ? true : false,
//                                                   title:  Text(""),
//                                                   content: Container(
//
//                                                       child:  Text("")),
//                                                       label: Text(Translator.translate("accepted"),style: TextStyle(color: Colors.black),)
//                                                 ),
//                                                     Step(
//                                                        state: order!.status==5 || order!.status==4  ? StepState.complete : StepState.disabled,
//                                                         isActive: order!.status==5 || order!.status==4 ? true : false,
//                                                   title:  Text("",),
//                                                   content: Container(
//
//                                                       child:  Text("",)),
//                                                       label: Text(Translator.translate("on_the_way"),style: TextStyle(color: Colors.black),)
//                                                 ),
//
//                                                   Step(
//                                                     state: order!.status==5  ? StepState.complete : StepState.disabled,
//                                                       isActive: order!.status==5 ? true : false,
//                                                   title:  Text("",),
//                                                   content: Container(
//
//                                                       child:  Text("",)),
//                                                       label: Text(Translator.translate("delivered"),style: TextStyle(color: Colors.black),)
//                                                 ),
//                                           ]),
//                                         ),
//                                       ),
//                                            Container(
//                                             width: MediaQuery.of(context).size.width ,
//                                             height: MediaQuery.of(context).size.height*0.4 ,
//                                              child: GoogleMap(
//
//                                                                        onMapCreated: _onMapCreated,
//                                                                                  markers: _markers,
//                                                                                  initialCameraPosition: CameraPosition(
//                                                                                    target: _center,
//                                                                                    zoom: 11.0,
//                                                                                  ),
//                                                                                ),
//                                            ),
//
//                                                Container(
//                               margin: Spacing.bottom(16),
//                               height: 3,
//                               child: isInProgress
//                                   ? LinearProgressIndicator(
//                                       minHeight: 3,
//                                     )
//                                   : Container(
//                                       height: 3,
//                                     ),
//                             ),
//                             _buildBody()
//                                   ],
//                                 ),
//                               )
//                               : Container(),
//                         ),
//                         // Column(
//                         //   crossAxisAlignment: CrossAxisAlignment.start,
//                         //   children: [
//                         //     Container(
//                         //       margin: Spacing.bottom(16),
//                         //       height: 3,
//                         //       child: isInProgress
//                         //           ? LinearProgressIndicator(
//                         //               minHeight: 3,
//                         //             )
//                         //           : Container(
//                         //               height: 3,
//                         //             ),
//                         //     ),
//                         //     _buildBody()
//                         //   ],
//                         // )
//                       ],
//                     ))));
//       },
//     );
//   }
//
//   _buildBody() {
//     if (order != null) {
//       return Column(
//         children: [
//           Container(
//
//             margin: Spacing.fromLTRB(16, 0, 16, 0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Icon(
//                           MdiIcons.chevronLeft,
//                           size: 20,
//                           color: themeData.colorScheme.onBackground,
//                         )),
//                   ),
//                 ),
//                 Container(
//                   width: 16,
//                   height: 16,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                       border: Border.all(
//                           color:
//                               ColorUtils.getColorFromOrderStatus(order!.status!)
//                                   .withAlpha(40),
//                           width: 4)),
//                   child: Container(
//                       width: 8,
//                       height: 8,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(4)),
//                           color: ColorUtils.getColorFromOrderStatus(
//                               order!.status!))),
//                 ),
//                 Container(
//                   margin: Spacing.left(8),
//                   child: Text(Order.getTextFromOrderStatus(
//                       order!.status!, order!.orderType)),
//                 ),
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(
//                         onTap: () {
//                           _refresh();
//                         },
//                         child: Icon(
//                           MdiIcons.refresh,
//                           size: 20,
//                           color: themeData.colorScheme.onBackground,
//                         )),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           _billWidget(),
//           _buttonForStatus()
//         ],
//       );
//     } else {
//       return Center(
//         child: Text(
//           "Wait...",
//           style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//               color: themeData.colorScheme.onBackground),
//         ),
//       );
//     }
//   }
//
//   _buttonForStatus() {
//     if (Order.isPickUpOrder(order!.orderType)) {
//       if (order!.status == 1) {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Center(
//               child: ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all(customAppTheme.colorError),
//                 padding: MaterialStateProperty.all(Spacing.xy(24, 12)),
//                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ))),
//             onPressed: () {
//               _changeStatus(Order.ORDER_CANCELLED_BY_USER);
//             },
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   MdiIcons.close,
//                   color: customAppTheme.onError,
//                   size: 18,
//                 ),
//                 Container(
//                   margin: Spacing.left(8),
//                   child: Text(
//                     Translator.translate("cancel_order"),
//                     style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                         color: customAppTheme.onError),
//                   ),
//                 )
//               ],
//             ),
//           )),
//         );
//       } else if (order!.status == 2) {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               OutlinedButton(
//                 onPressed: () {
//                   UrlUtils.openMap(
//                       order!.shop!.latitude, order!.shop!.longitude);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       MdiIcons.mapMarkerOutline,
//                       color: themeData.colorScheme.onBackground,
//                       size: 18,
//                     ),
//                     Container(
//                       margin: Spacing.left(8),
//                       child: Text(
//                         Translator.translate("go_to_shop"),
//                         style: AppTheme.getTextStyle(
//                             themeData.textTheme.bodyText2,
//                             color: themeData.colorScheme.onBackground),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 style: ButtonStyle(
//                     padding: MaterialStateProperty.all(Spacing.xy(24,12)),
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ))
//                 ),
//                 onPressed: () {
//                   UrlUtils.callFromNumber(order!.shop!.mobile);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       MdiIcons.phoneOutline,
//                       color: themeData.colorScheme.onPrimary,
//                       size: 18,
//                     ),
//                     Container(
//                       margin: Spacing.left(8),
//                       child: Text(
//                         Translator.translate("call_at_shop"),
//                         style: AppTheme.getTextStyle(
//                             themeData.textTheme.bodyText2,
//                             color: themeData.colorScheme.onPrimary),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else if (order!.status == 3) {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               OutlinedButton(
//                 onPressed: () {
//                   UrlUtils.openMap(
//                       order!.shop!.latitude, order!.shop!.longitude);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       MdiIcons.mapMarkerOutline,
//                       color: themeData.colorScheme.onBackground,
//                       size: 18,
//                     ),
//                     Container(
//                       margin: Spacing.left(8),
//                       child: Text(
//                         Translator.translate("go_to_shop"),
//                         style: AppTheme.getTextStyle(
//                             themeData.textTheme.bodyText2,
//                             color: themeData.colorScheme.onBackground),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 style: ButtonStyle(
//                     padding: MaterialStateProperty.all(Spacing.xy(24,12)),
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ))
//                 ),
//                 onPressed: () {
//                   _changeStatus(5);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       MdiIcons.shoppingOutline,
//                       color: themeData.colorScheme.onPrimary,
//                       size: 18,
//                     ),
//                     Container(
//                       margin: Spacing.left(8),
//                       child: Text(
//                         Translator.translate("pickup_order"),
//                         style: AppTheme.getTextStyle(
//                             themeData.textTheme.bodyText2,
//                             color: themeData.colorScheme.onPrimary),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else if (order!.status == 5) {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 style: ButtonStyle(
//                     padding: MaterialStateProperty.all(Spacing.xy(24, 12)),
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ))
//                 ),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) => OrderReviewScreen(
//                         orderId: order!.id,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       MdiIcons.starOutline,
//                       color: themeData.colorScheme.onPrimary,
//                       size: 18,
//                     ),
//                     Container(
//                       margin: Spacing.left(8),
//                       child: Text(
//                         Translator.translate("Review order"),
//                         style: AppTheme.getTextStyle(
//                             themeData.textTheme.bodyText2,
//                             color: themeData.colorScheme.onPrimary),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else if (order!.status == -1) {
//         return SizedBox(
//           height: 8,
//         );
//       } else if (order!.status == -2) {
//         return SizedBox(
//           height: 8,
//         );
//       } else {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Center(child: Text("Something wrong")),
//         );
//       }
//     }
//     else {
//       if (order!.status == 1) {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Center(
//               child: ElevatedButton(
//             style: ButtonStyle(
//                 padding: MaterialStateProperty.all(Spacing.xy(24, 12)),
//                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ))),
//             onPressed: () {
//                   _changeStatus(Order.ORDER_CANCELLED_BY_USER);
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       MdiIcons.close,
//                   color: customAppTheme.onError,
//                   size: 18,
//                 ),
//                     Container(
//                       margin: Spacing.left(8),
//                   child: Text(
//                     Translator.translate("cancel_order"),
//                     style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                         color: customAppTheme.onError),
//                   ),
//                 )
//               ],
//             ),
//           )),
//         );
//       } else if (order!.status == 2) {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               OutlinedButton(
//                 onPressed: () {
//                   UrlUtils.openMap(
//                       order!.shop!.latitude, order!.shop!.longitude);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       MdiIcons.mapMarkerOutline,
//                       color: themeData.colorScheme.onBackground,
//                       size: 18,
//                     ),
//                     Container(
//                       margin: Spacing.left(8),
//                       child: Text(
//                         Translator.translate("go_to_shop"),
//                         style: AppTheme.getTextStyle(
//                             themeData.textTheme.bodyText2,
//                             color: themeData.colorScheme.onBackground),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 style: ButtonStyle(
//                     padding: MaterialStateProperty.all(Spacing.xy(24,12)),
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ))
//                 ),
//                 onPressed: () {
//                   UrlUtils.callFromNumber(order!.shop!.mobile);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       MdiIcons.phoneOutline,
//                       color: themeData.colorScheme.onPrimary,
//                       size: 18,
//                     ),
//                     Container(
//                       margin: Spacing.left(8),
//                       child: Text(
//                         Translator.translate("call_at_shop"),
//                         style: AppTheme.getTextStyle(
//                             themeData.textTheme.bodyText2,
//                             color: themeData.colorScheme.onPrimary),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else if (order!.status == 3 || order!.status == 4) {
//         return Container(
//           // margin: Spacing.fromLTRB(16, 8, 16, 8),
//           // child: Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//           //   children: [
//           //     OutlinedButton(
//           //       onPressed: () {
//           //         if (deliveryBoyLocation != null) {
//           //           UrlUtils.openMap(deliveryBoy!.latitude,
//           //               deliveryBoy!.longitude);
//           //         } else {
//           //           showMessage(
//           //               message: Translator.translate(
//           //                   "perhaps_delivery_boy_is_on_another_order"));
//           //         }
//           //       },
//           //       child: Row(
//           //         children: [
//           //           Icon(
//           //             MdiIcons.mapMarkerOutline,
//           //             color: themeData.colorScheme.onBackground,
//           //             size: 18,
//           //           ),
//           //           Container(
//           //             margin: Spacing.left(8),
//           //             child: Text(
//           //               Translator.translate("delivery_boy"),
//           //               style: AppTheme.getTextStyle(
//           //                   themeData.textTheme.bodyText2,
//           //                   color: themeData.colorScheme.onBackground),
//           //             ),
//           //           )
//           //         ],
//           //       ),
//           //     ),
//           //     ElevatedButton(
//           //       style: ButtonStyle(
//           //           padding: MaterialStateProperty.all(Spacing.xy(24,12)),
//           //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
//           //             borderRadius: BorderRadius.circular(4),
//           //           ))
//           //       ),
//           //       onPressed: () {
//           //         UrlUtils.callFromNumber( deliveryBoy!.mobile==null ? "" : deliveryBoy!.mobile!);
//           //       },
//           //       child: Row(
//           //         children: [
//           //           Icon(
//           //             MdiIcons.phoneOutline,
//           //             color: themeData.colorScheme.onPrimary,
//           //             size: 18,
//           //           ),
//           //           Container(
//           //             margin: Spacing.left(8),
//           //             child: Text(
//           //               Translator.translate("call_delivery_boy"),
//           //               style: AppTheme.getTextStyle(
//           //                   themeData.textTheme.bodyText2,
//           //                   color: themeData.colorScheme.onPrimary),
//           //             ),
//           //           )
//           //         ],
//           //       ),
//           //     ),
//           //   ],
//           // ),
//         );
//       } else if (order!.status == 5) {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 style: ButtonStyle(
//                     padding: MaterialStateProperty.all(Spacing.xy(24, 12)),
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ))
//                 ),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) => OrderReviewScreen(
//                         orderId: order!.id,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       MdiIcons.starOutline,
//                       color: themeData.colorScheme.onPrimary,
//                       size: 18,
//                     ),
//                     Container(
//                       margin: Spacing.left(8),
//                       child: Text(
//                         Translator.translate("Review order"),
//                         style: AppTheme.getTextStyle(
//                             themeData.textTheme.bodyText2,
//                             color: themeData.colorScheme.onPrimary),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else if (order!.status == -1) {
//         return SizedBox(
//           height: 8,
//         );
//       } else if (order!.status == -2) {
//         return SizedBox(
//           height: 8,
//         );
//       } else if (order!.status == 0) {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Center(
//               child: Text(
//                   Translator.translate("your_payment_is_not_confirmed_yet"))),
//         );
//       } else {
//         return Container(
//           margin: Spacing.fromLTRB(16, 8, 16, 8),
//           child: Center(child: Text("Something wrong")),
//         );
//       }
//     }
//   }
//
//   _billWidget() {
//     return Container(
//       margin: Spacing.fromLTRB(16, 12, 16, 0),
//       decoration: BoxDecoration(
//           color: customAppTheme.bgLayer1,
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           border: Border.all(color: customAppTheme.bgLayer4, width: 1)),
//       padding: Spacing.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 20,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 Translator.translate("billing_information"),
//                 style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                     color: themeData.colorScheme.onBackground,
//                     fontWeight: 600,
//                     muted: true),
//               ),
//               InkWell(
//                 onTap: () {
//                   UrlUtils.goToOrderReceipt(order!.id);
//                 },
//                 child: Text(
//                   Translator.translate("view_order"),
//                   style: AppTheme.getTextStyle(
//                     themeData.textTheme.bodyText2,
//                     color: themeData.colorScheme.primary,
//                     fontWeight: 600,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Container(
//             margin: Spacing.fromLTRB(16, 8, 16, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   Translator.translate("order"),
//                   style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                       color: themeData.colorScheme.onBackground),
//                 ),
//                 Text(
//                   CurrencyApi.getSign(afterSpace: true) +
//                       order!.order.toString(),
//                   style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                       color: themeData.colorScheme.onBackground,
//                       fontWeight: 600),
//                 ),
//               ],
//             ),
//           ),
//           // Container(
//           //   margin: Spacing.fromLTRB(16, 4, 16, 0),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Text(
//           //         Translator.translate("tax"),
//           //         style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//           //             color: themeData.colorScheme.onBackground),
//           //       ),
//           //       Text(
//           //         CurrencyApi.getSign(afterSpace: true) + order!.tax.toString(),
//           //         style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//           //             color: themeData.colorScheme.onBackground,
//           //             fontWeight: 600),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           Container(
//             margin: Spacing.fromLTRB(16, 4, 16, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   Translator.translate("delivery_fee"),
//                   style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                       color: themeData.colorScheme.onBackground),
//                 ),
//                 Text(
//                   CurrencyApi.getSign(afterSpace: true) +
//                       CurrencyApi.doubleToString(order!.deliveryFee),
//                   style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                       color: themeData.colorScheme.onBackground,
//                       fontWeight: 600),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: Spacing.fromLTRB(16, 4, 16, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(),
//                 ),
//                 Expanded(
//                   child: Divider(),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             margin: Spacing.fromLTRB(16, 4, 16, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   Translator.translate("total"),
//                   style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                       color: themeData.colorScheme.onBackground,
//                       fontWeight: 600),
//                 ),
//                 Text(
//                   CurrencyApi.getSign(afterSpace: true) +
//                       CurrencyApi.doubleToString(order!.total),
//                   style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
//                       color: themeData.colorScheme.onBackground,
//                       fontWeight: 600),
//                 ),
//               ],
//             ),
//           ),
//
//           Divider(),
//
//           SizedBox(height: 20,),
//
//          deliveryBoy !=null ? Container(
//
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//         ( deliveryBoy!.avatarUrl ==null  ||  deliveryBoy!.avatarUrl! == "avatar_url") || deliveryBoy!.avatarUrl!.isEmpty  ? ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Image.asset("assets/images/R.jpg",width: 30,height: 30,)) :  ClipRRect(
//
//                   borderRadius: BorderRadius.circular(20),
//                 child: Image.network(deliveryBoy!.avatarUrl!,width: 30,height: 30,)),
//               SizedBox(width: 10,),
//                   Text( deliveryBoy!.name!,style: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
//                         letterSpacing: 0.4, color: Colors.black),),
//                 ],
//               ),
//
//               Row(
//                 children: [
//                   IconButton(onPressed: (){
//                      UrlUtils.callFromNumber( deliveryBoy!.mobile==null ? "" : deliveryBoy!.mobile!);
//                   }, icon: Icon(Icons.call,color: Colors.black,)),
//
//                      IconButton(onPressed: (){
//                         if (deliveryBoyLocation != null) {
//                     UrlUtils.openMap(deliveryBoy!.latitude,
//                         deliveryBoy!.longitude);
//                   } else {
//                     showMessage(
//                         message: Translator.translate(
//                             "perhaps_delivery_boy_is_on_another_order"));
//                   }
//                      }, icon: Icon( MdiIcons.mapMarkerOutline,color: Colors.black,))
//                 ],
//               )
//             ],
//           )):Container()
//
//
//         ],
//       ),
//     );
//   }
//
//   _setTimer() {
//     //Every 20 sec delivery boy and order location updated
//     _timer = new Timer.periodic(
//         Duration(seconds: 20), (Timer timer) => getDeliveryBoy());
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
//             style: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
//                 letterSpacing: 0.4, color: themeData.colorScheme.onPrimary)),
//         backgroundColor: themeData.colorScheme.primary,
//         behavior: SnackBarBehavior.fixed,
//       ),
//     );
//   }
// }
