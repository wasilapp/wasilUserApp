//
//
// import 'dart:developer';
//
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
//
// import '../../config/custom_package.dart';
// import '../../controller/address.dart';
//
// import '../../utils/ui/product_widget.dart';
// import '../checkout_order/add_order.dart';
// import '../checkout_order/time_order_widget.dart';
// import '../favourite/favourite_controller.dart';
//
// import 'main_sub_controller.dart';
//
//
// class CheckoutScreenDriver extends StatefulWidget {
//
//
//   @override
//   State<CheckoutScreenDriver> createState() => _CheckoutScreenDriverState();
// }
//
// class _CheckoutScreenDriverState extends State<CheckoutScreenDriver> {
//   String trueDate='';
//   DateTime pickedDate=DateTime.now();
//   var cityTFController;
//   var addressTFController;
//   var totalAmount;
//   double schedulerFees = 0.0;
//   double commesion = 0.0;
//   var deliveryFee = 0.0;
//   var expeditedFees = 0.0;
//   String selectedPayment = 'Cash'.tr; // Default value for payment dropdown
//   String selectedTimeOrder = '6:00 Am - 7:00Am';
//   String dateInput = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   String selectedOption = "scheduled".tr;
//   DateTime selectedDate = DateTime.now();
//
//   Future<void> _changeLocation(latitude, longitude) async {
//     final List<Placemark> placeMark =
//     await placemarkFromCoordinates(latitude, longitude);
//     setState(() {
//       cityTFController = placeMark[0].locality.toString();
//       addressTFController = placeMark[0].street.toString();
//     });
//   }
//
//   String? mobile;
//
//   getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       mobile = prefs.getString('mobile')!;
//       schedulerFees = prefs.getDouble('schedulerFees')!;
//       commesion = prefs.getDouble('commesion')!;
//       // deliveryFee = prefs.getDouble('deliveryFee')!;
//       // expeditedFees = prefs.getDouble('expeditedFees')!;
//     });
//   }
//
//   GoogleMapController? mapController;
//   final Set<Marker> _markers = {
//     const Marker(
//       markerId: MarkerId('1'),
//       position: LatLng(31.936783, 35.874772),
//     )
//   };
//   final LatLng _center = const LatLng(31.936783, 35.874772);
//
//   void _onMapTap(LatLng latLong) {
//     mapController!
//         .getZoomLevel()
//         .then((zoom) => {_changeLocation(zoom, latLong)});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // _changeLocation(AddressWidget.lat,AddressWidget.long);
//     getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     MainSubcategoryController controller=Get.put(MainSubcategoryController());
//
//     favouriteController controllerCategory = Get.put(favouriteController());
//     AddressController controllerAddress = Get.put(AddressController());
//     AddOrderController orderController = Get.put(AddOrderController());
//     return RefreshIndicator(
//       onRefresh:() async{
//
//
//         controller.getMainSubcategory();
//         if(controller.cartList.length==0){
//           Get.back();
//         }
//         return ;
//       },
//       child: SafeArea(
//           child: Scaffold(
//             appBar: CommonViews().getAppBar(title: 'CheckOut'.tr),
//             body: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border:
//                             Border.all(color: AppColors.borderColor, width: 2)),
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         width: double.infinity,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 150,
//                               width: double.infinity,
//                               child: GoogleMap(
//                                 onMapCreated: (controller) {
//                                   mapController = controller;
//                                 },
//                                 markers: _markers,
//                                 onTap: _onMapTap,
//                                 initialCameraPosition: CameraPosition(
//                                   target: _center,
//                                   zoom: 11.0,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 9,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Icon(Icons.location_on_outlined,
//                                             color: Colors.black),
//                                         const SizedBox(
//                                           width: 5,
//                                         ),
//                                         Text(
//                                             controllerAddress.street.value,
//                                             style: const TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black)),
//                                       ],
//                                     ),
//                                     PopupMenuButton<String>(
//                                       initialValue: null,
//                                       onSelected: (selectedItem) {
//                                         setState(() {
//                                           log(selectedItem);
//                                         });
//                                       },
//
//                                       itemBuilder: (BuildContext context) {
//                                         final items = controllerAddress.listAddress
//                                             .map((address) {
//                                           return PopupMenuItem<String>(
//                                             onTap: () {
//                                               controllerAddress.lat.value =
//                                                   address.latitude.toString();
//                                               controllerAddress.long.value =
//                                                   address.longitude.toString();
//                                               controllerAddress.street.value =
//                                                   address.street;
//                                               controllerAddress.buildingNumber.value =
//                                               address.buildingNumber!;
//                                               controllerAddress.apartmentNum.value =
//                                                   address.apartmentNum.toString();
//                                               controllerAddress.id.value =
//                                                   address.id.toString();
//                                             },
//                                             value:
//                                             '${address.type == 0 ? 'Home' : address.type == 1 ? 'Work' : 'Other'} ${address.street}',
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                     ' ${address.type == 0 ? 'Home' : address.type == 1 ? 'Work' : 'Other'}, ${address.street}',
//                                                     style: const TextStyle(
//                                                         color: AppColors
//                                                             .secondaryColor)),
//                                                 const Divider(
//                                                   color: AppColors.backgroundColor,
//                                                 )
//                                               ],
//                                             ),
//                                           );
//                                         }).toList();
//
//                                         // Add the "Add New Address" option at the end
//                                         items.add(
//                                           PopupMenuItem<String>(
//                                             value: 'add_new_address',
//                                             child: Text('Add New Address'.tr),
//                                             onTap: () => UserNavigator.of(context)
//                                                 .push(const AddAddressScreen()),
//                                           ),
//                                         );
//
//                                         return items;
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             'Change'.tr,
//                                             style: const TextStyle(
//                                                 color: AppColors.primaryColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           const Icon(
//                                             Icons.keyboard_arrow_down,
//                                             color: AppColors.primaryColor,
//                                             size: 30,
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.home_outlined,
//                                         color: Colors.black),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text(
//                                         textAlign: TextAlign.start,
//                                         '${'building'.tr} :${ controllerAddress.buildingNumber.value}${'\n apartment'.tr}:  ${controllerAddress.apartmentNum.value}',
//                                         style: const TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black)),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 9,
//                                 ),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.phone, color: Colors.black),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text("${"mobile".tr} $mobile",
//                                         style: const TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black)),
//                                   ],
//                                 ),
//                               ],
//                             )
//                           ],
//                         )),
//                     const SizedBox(
//                       height: 10,
//                     ),
//
//                     Container(
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: AppColors.borderColor, width: 2)),
//                       width: double.infinity,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Select Date Order'.tr,
//                                   style: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.black)),
//                               const SizedBox(width: 20),
//                               InkWell(
//                                   onTap: () async {
//                                     log(DateFormat('yyyy-MM-dd')
//                                         .format(DateTime.now()));
//                                     log('DateTime.now()');
//                                     pickedDate = (await showDatePicker(
//                                         context: context,
//                                         initialDate: DateTime.now(),
//                                         firstDate: DateTime(1950),
//                                         //DateTime.now() - not to allow to choose before today.
//                                         lastDate: DateTime(2100)))!;
//
//                                     if (pickedDate != null) {
//                                       log(
//                                           pickedDate.toString());
//                                       print(DateTime.now().hour);//pickedDate output format => 2021-03-10 00:00:00.000
//                                       print(pickedDate);//pickedDate output format => 2021-03-10 00:00:00.000
//                                       String formattedDate =
//                                       DateFormat('yyyy-MM-dd').format(pickedDate!);
//                                       if(  pickedDate!.isBefore(DateTime.now())){
//                                         print('i');
//                                         trueDate='date befor todys';
//                                       }
//                                       //formatted date output using intl package =>  2021-03-16
//                                       setState(() {
//                                         dateInput =
//                                             formattedDate; //set output date to TextField value.
//                                       });
//                                     } else {}
//                                   },
//                                   child: Container(
//                                     padding: const EdgeInsets.all(5),
//                                     width: 200,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(
//                                             color: AppColors.borderColor, width: 2)),
//                                     child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(dateInput)),
//                                   )),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text('Select Range Time Order'.tr,
//                               style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black)),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           HourSelectionList(),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Obx(() {
//                       return Container(
//                         padding: const EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border:
//                             Border.all(color: AppColors.borderColor, width: 2)),
//                         width: double.infinity,
//                         child: ListView.builder(physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//
//
//                               return ProductWidget(model: controller.cartList[index]);
//                             },
//                             itemCount: controller.cartList.length,
//                             shrinkWrap: true),
//                       );
//                     }),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: AppColors.borderColor, width: 2)),
//                       width: double.infinity,
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Subtotal  :'.tr,
//                                   style: (const TextStyle(
//                                     color: Colors.black,
//                                   )),
//                                 ),
//                                 Obx(
//                                       () => Text(
//                                       controller.calculateTotal().toStringAsFixed(2),
//                                       style: (const TextStyle(
//                                         color: Colors.black,
//                                       ))),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Delivery fee',
//                                   style: (TextStyle(
//                                     color: Colors.black,
//                                   )),
//                                 ),
//                                 Text(
//                                   deliveryFee.toStringAsFixed(2),
//                                   style: (const TextStyle(
//                                     color: Colors.black,
//                                   )),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Service fee',
//                                   style: (TextStyle(
//                                     color: Colors.black,
//                                   )),
//                                 ),
//                                 Text(
//                                   schedulerFees.toStringAsFixed(2),
//                                   style: (const TextStyle(
//                                     color: Colors.black,
//                                   )),
//                                 ),
//                               ],
//                             ),
//                             const Divider(color: AppColors.borderColor),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Total amount  ',
//                                   style: (TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold)),
//                                 ),
//                                 Text(
//                                   '${schedulerFees + deliveryFee + controller.calculateTotal()}',
//                                   style: (const TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold)),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               minimumSize: const Size(170, 50),
//                               backgroundColor: AppColors.backgroundColor,
//                               textStyle: const TextStyle(
//                                 color: AppColors.primaryColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                   side: const BorderSide(color: AppColors.primaryColor),
//                                   borderRadius: BorderRadius.circular(10))),
//                           onPressed: () {
//                             UserNavigator.of(context).maybePop();
//                           },
//                           child: Text("Add Item".tr, style: const TextStyle(color: AppColors.primaryColor)),
//                         ),
//                         ElevatedButton(
//                           style: const ButtonStyle(
//                             minimumSize: MaterialStatePropertyAll(Size(170, 50)),
//                             backgroundColor:
//                             MaterialStatePropertyAll(AppColors.primaryColor),
//                             shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(10)))),
//                           ),
//                           onPressed: () async {
//                             log('lll');
//                             log('555555');
//
//
//                             //   print(DateTime.now().hour);
//                             log(DateTime.now().toString());
//
//                             if( pickedDate.day<DateTime.now().day){
//                               Get.snackbar(' date time ', 'date before today',
//                                   backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM,
//                                   icon: const Icon(Icons.error_outline));
//
//                             }
//                             // else if(HourSelectionList.startHour>=DateTime.now().hour){
//                             //   Get.snackbar('  order not success ', 'start hour equal end hour'.tr,
//                             //       backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM,
//                             //       icon: const Icon(Icons.error_outline));}
//                             else if(HourSelectionList.startHour==HourSelectionList.endHour){
//                               Get.snackbar('  order not success ', 'start hour equal end hour'.tr,
//                                   backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM,
//                                   icon: const Icon(Icons.error_outline));}
//
//
//
//                             else {
//                               print( controller.cartList.map((e) => e.tooJson())
//                                   .toList());
//                               print(controller.driverId);
//                               orderController.createOrder(
//
//                                   categoryId: controllerCategory.id,
//                                   paymentType: 2,
//
//                                walletId: 1,
//                                   //todo get wallet id
//                                   //    "order_type": "scheduled",
//                                   orderDate: dateInput.toString(),
//                                   orderTimeFrom:HourSelectionList.startHour,
//                                   //<12?'${HourSelectionList.startHour}:00am':'${HourSelectionList.startHour}:00pm'
//                                   //  .toString(),
//                                   orderTimeTo:HourSelectionList.endHour,
//                                   // <12?'${HourSelectionList.endHour}:00am':'${HourSelectionList.endHour}:00pm'
//                                   //           .toString(),
//                                   delivery_boy_id:controller.driverId,
//                                   expeditedFees: expeditedFees,
//                                   //todo get expeditedFees
//                                   order: 1,
//                                   //todo what mean order
//                                   deliveryFee: deliveryFee,
//                                   total: controller.calculateTotal(),
//                                   // couponDiscount: 0,//todo how to get coupon discount
//                                   couponId: 0,
//                                   //todo how to get coupon discount
//                                   addressId: int.parse(controllerAddress.id.value),
//                                   type: 1,
//                                   //todo what mean type
//                               shopId: 0,
//                                   count: controller.cartList.length,
//                                   commesion: commesion,
//                                   //todo add list of cart
//                                   cart: controller.cartList.map((e) => e.tooJson())
//                                       .toList()
//                               );
//                             } },
//                           child: Text("Checkout".tr,
//                               style: const TextStyle(
//                                 color: AppColors.backgroundColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                               )),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(
//                       height: 10,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
