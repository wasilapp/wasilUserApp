// import 'dart:collection';
// import 'dart:core';
// import 'dart:core';
// import 'dart:core';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:userwasil/utils/helper/navigator.dart';
//
// import '../../api/api_util.dart';
// import '../../config/colors.dart';
// import '../../controllers/AddressController.dart';
// import '../../models/Categories.dart';
// import '../../models/MyResponse.dart';
// import '../../models/UserAddress.dart';
// import '../../services/AppLocalizations.dart';
//
// import '../../utils/ui/common_views.dart';
//
//
//
// import '../addresses/add_address/add_address_screen.dart';
//
// class DeliveryTo extends StatefulWidget {
//   // final int? id;
//   // final Category category ;
//   // const DeliveryTo({
//   //   Key? key,
//   //   this.id,
//   //   required this.category,
//   // }) : super(key: key);
//
//   @override
//   State<DeliveryTo> createState() => _DeliveryToState();
// }
//
// class _DeliveryToState extends State<DeliveryTo> {
//   //Google Maps
//   GoogleMapController? mapController;
//   BitmapDescriptor? pinLocationIcon;
//   bool loaded = false;
//   final Set<Marker> _markers = HashSet();
//   final LatLng _center = const LatLng(31.936783, 35.874772);
//   late LatLng currentPosition;
//   var place;
//   Marker marker = Marker(
//     markerId: MarkerId('1'),
//     position: LatLng(31.936783, 35.874772),
//   );
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     setState(() {
//       _markers.add(marker);
//     });
//   }
//
//   void _onMapTap(LatLng latLong) {
//     mapController!
//         .getZoomLevel()
//         .then((zoom) => {_changeLocation(zoom, latLong)});
//   }
//
//   void _changeLocation(double zoom, LatLng latLng) {
//     double newZoom = zoom > 15 ? zoom : 15;
//     currentPosition = latLng;
//     setState(() {
//       mapController!.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: latLng, zoom: newZoom)));
//       _markers.clear();
//       _markers.add(Marker(
//         markerId: MarkerId('1'),
//         position: latLng,
//       ));
//     });
//   }
//
//   bool isInProgress = false;
//
//   @override
//   void initState() {
//     super.initState();
//     currentPosition = _center;
//
//     WidgetsBinding.instance!.addPostFrameCallback((_) => {_changeLoaded()});
//     _loadAllAddresses();
//     // gettingLocation();
//   }
//
//   @override
//   dispose() {
//     super.dispose();
//
//     mapController!.dispose();
//   }
//
//   _changeLoaded() {
//     setState(() {
//       loaded = true;
//     });
//   }
//
//   _loadAllAddresses() async {
//     if (mounted) {
//       setState(() {
//         isInProgress = true;
//       });
//     }
//
//     MyResponse<List<UserAddress>> myResponse = await AddressController
//         .getMyAddresses();
//     if (myResponse.success) {
//       userAddress = myResponse.data;
//     } else {
//       ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
//       //showMessage(message: myResponse.errorText);
//     }
//
//     if (mounted) {
//       setState(() {
//         isInProgress = false;
//       });
//     }
//   }
//
//   late ThemeData themeData;
//   List<UserAddress>? userAddress;
//   late List<Category> category;
//   @override
//   Widget build(BuildContext context) {
//     themeData = Theme.of(context);
//     int selectedAddressType = UserAddress.HOME;
//     List<UserAddress>? userAddress;
//     return SafeArea(
//         child: Scaffold(
//
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: 350,
//                   child: Stack(
//                     children: [
//                       loaded
//                           ? GoogleMap(
//                         onMapCreated: _onMapCreated,
//                         markers: _markers,
//                         onTap: _onMapTap,
//                         initialCameraPosition: CameraPosition(
//                           target: _center,
//                           zoom: 11.0,
//                         ),
//                       )
//                           : Container(),
//
//                     ],
//                   ),
//                 ),
//                 Container(
//
//                   decoration: const BoxDecoration(
//
//                     borderRadius:
//                     BorderRadius.all(Radius.circular(16)),
//
//
//                   ),
//                   child:
//                   Padding(
//                     padding: EdgeInsets.only(left: 20,top: 10),
//                     child: Column(mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Align(
//
//                             alignment: Alignment.topLeft,
//
//                             child: Text(
//                                 "Delivering To",
//                                 style: TextStyle(
//                                   color: Colors.black87,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600,
//                                 )
//                             ),
//                           ),
//                           SizedBox(height: 5,),
//
//
//
//
//                           const SizedBox(height: 10,),
//                           //  _buildBody(),
//                           const SizedBox(height: 10,),
//
//                           const SizedBox(height: 10,),
//                         CommonViews().createButton(title:  "Compleate Order", onPressed: (){
//                           UserNavigator.of(context).push(const OrderDetail());
//                         }),
//                         //     () =>
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //       builder: (context) => const ShopsScreen()))),
//
//                           const SizedBox(height: 10,),
//
//                         ]),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//
//     );
//   }
// //   Widget _showAddresses(List<UserAddress> addresses) {
// //     List<Widget> listWidgets = [];
// //
// //     for (UserAddress address in addresses) {
// //       listWidgets.add(Container(
// //           margin: Spacing.bottom(16),
// //           child: _singleAddress(address),));
// //           // InkWell(
// //           // onTap: () async {
// //           //   bool? refresh = await Navigator.push(
// //           //       context,
// //           //       MaterialPageRoute(
// //           //           builder: (context) => EditAddressScreen(
// //           //             userAddress: address,
// //           //           )));
// //           //   if(refresh!=null && refresh){
// //           //     _refresh();
// //           //   }
// //           //
// //           // },
// //           // child: Container(
// //           //   margin: Spacing.bottom(16),
// //           //   child: _singleAddress(address),
// //           // )));
// //     }
// //
// //     return Container(
// //       margin: Spacing.fromLTRB(16, 0, 16, 0),
// //       child: Column(
// //         children: listWidgets,
// //       ),
// //     );
// //   }
// //
// //   Widget _singleAddress(UserAddress userAddress) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: themeData.cardTheme.color,
// //        // border: Border.all(color: customAppTheme.bgLayer4, width: 1),
// //         borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
// //       ),
// //       padding: Spacing.all(16),
// //       child: Row(
// //         children: <Widget>[
// //           Container(
// //             child: Icon(
// //               MdiIcons.mapMarkerOutline,
// //               size: MySize.size28,
// //               color: themeData.colorScheme.onBackground,
// //             ),
// //           ),
// //           Expanded(
// //             child: Container(
// //               margin: Spacing.left(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: <Widget>[
// //                   Text(userAddress.address,
// //                       style: AppTheme.getTextStyle(
// //                           themeData.textTheme.subtitle2,
// //                           fontWeight: 500,
// //                           letterSpacing: 0)),
// //                   userAddress.address2 == null
// //                       ? Container()
// //                       : Container(
// //                     margin: Spacing.top(4),
// //                     child: Text(userAddress.address2!,
// //                         style: AppTheme.getTextStyle(
// //                             themeData.textTheme.subtitle2,
// //                             fontWeight: 500,
// //                             letterSpacing: 0)),
// //                   ),
// //                   Container(
// //                     margin: Spacing.top(8),
// //                     child: Row(
// //                       children: <Widget>[
// //                         Text(userAddress.city,
// //                             style: AppTheme.getTextStyle(
// //                                 themeData.textTheme.bodyText2,
// //                                 fontWeight: 500,
// //                                 letterSpacing: 0)),
// //                         Container(
// //                           margin: Spacing.left(4),
// //                           child: Text(" - " +userAddress.pincode.toString(),
// //                               style: AppTheme.getTextStyle(
// //                                   themeData.textTheme.bodyText2,
// //                                   fontWeight: 500,
// //                                   letterSpacing: 0)),
// //                         )
// //                       ],
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Switch(
// //               value: userAddress.isDefault,
// //               onChanged: (value) {
// //                // _changeDefaultAddress(userAddress, value);
// //               })
// //         ],
// //       ),
// //     );
// //   }
// //   _buildBody(){
// //     if(userAddress!=null){
// //       return _showAddresses(userAddress!);
// //     }else if(isInProgress){
// //     //  return LoadingScreens.getAddressLoadingScreen(context, themeData, customAppTheme);
// //     }else{
// //       return Center(child: Text(Translator.translate("there_is_no_saved_address")),);
// //     }
// //   }
// // }
// }