import 'dart:convert';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:userwasil/controller/AuthController_new.dart';
import 'package:userwasil/core/constant/app_constent.dart';
import 'package:userwasil/utils/tools/tools.dart';
import 'package:userwasil/utils/ui/progress_hud.dart';
import 'package:userwasil/views/nearby_driver/nearby_driver_controller.dart';
import 'package:userwasil/views/succes_Page/succes_page.dart';
import 'package:userwasil/views/wallet_shop/wallet_by_shop_controller.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/controller/address.dart';
import 'package:userwasil/utils/ui/product_widget.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_controller.dart';
import 'add_order.dart';
import 'time_order_widget.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String trueDate = '';
  DateTime pickedDate = DateTime.now();
  var cityTFController;
  var addressTFController;
  var totalAmount;
  double schedulerFees = 0.0;
  double commesion = 0.0;
  var deliveryFee = 0.0;
  var expeditedFees = 0.0;
  String selectedPayment = 'Cash'.tr; // Default value for payment dropdown
  String selectedTimeOrder = '6:00 Am - 7:00Am';
  String dateInput = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedOption = "scheduled".tr;
  DateTime selectedDate = DateTime.now();

  Future<void> _changeLocation(latitude, longitude) async {
    final List<Placemark> placeMark =
        await placemarkFromCoordinates(latitude, longitude);
    setState(() {
      cityTFController = placeMark[0].locality.toString();
      addressTFController = placeMark[0].street.toString();
    });
  }

  String? mobile;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      mobile = prefs.getString('mobile')!;
      schedulerFees = prefs.getDouble('schedulerFees')!;
      commesion = prefs.getDouble('commesion')!;
      // deliveryFee = prefs.getDouble('deliveryFee')!;
      // expeditedFees = prefs.getDouble('expeditedFees')!;
    });
  }

  GoogleMapController? mapController;
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(31.936783, 35.874772),
    )
  };
  final LatLng _center = const LatLng(31.936783, 35.874772);

  void _onMapTap(LatLng latLong) {
    mapController!
        .getZoomLevel()
        .then((zoom) => {_changeLocation(zoom, latLong)});
  }

  SubCategoriesController controller = Get.put(SubCategoriesController());
  WalletShopController walletcontroller = Get.put(WalletShopController());
// favouriteController controllerCategory = Get.put(favouriteController());
  AddressController controllerAddress = Get.put(AddressController());
  AddOrderController orderController = Get.put(AddOrderController());
  final SubCategoriesController subCategoriesController = Get.find();
  @override
  void initState() {
    super.initState();
    log("**********************************");
    // log(controllerCategory.id.toString());
    // _changeLocation(AddressWidget.lat,AddressWidget.long);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getProducts(controller.shopId);
        if (controller.cartList.isEmpty) {
          Get.back();
        }
        return;
      },
      child: Scaffold(
        //  appBar: CommonViews().getAppBar(title: 'CheckOut'.tr),
        body: Obx(() {
          // if( controller.cartList.isEmpty){
          //   Navigator.pop(context);
          // }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.borderColor, width: 2)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: GoogleMap(
                              onMapCreated: (controller) {
                                mapController = controller;
                              },
                              markers: _markers,
                              onTap: _onMapTap,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 11.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          color: Colors.black),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(controllerAddress.street.value,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  PopupMenuButton<String>(
                                    initialValue: null,
                                    onSelected: (selectedItem) {
                                      setState(() {
                                        log(selectedItem);
                                      });
                                    },
                                    itemBuilder: (BuildContext context) {
                                      final items = controllerAddress
                                          .listAddress
                                          .map((address) {
                                        return PopupMenuItem<String>(
                                          onTap: () {
                                            controllerAddress.lat.value =
                                                address.latitude.toString();
                                            controllerAddress.long.value =
                                                address.longitude.toString();
                                            controllerAddress.street.value =
                                                address.street;
                                            controllerAddress
                                                    .buildingNumber.value =
                                                address.buildingNumber!;
                                            controllerAddress
                                                    .apartmentNum.value =
                                                address.apartmentNum.toString();
                                            controllerAddress.id.value =
                                                address.id.toString();
                                          },
                                          value:
                                              '${address.type == 0 ? 'Home' : address.type == 1 ? 'Work' : 'Other'} ${address.street}',
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  ' ${address.type == 0 ? 'Home' : address.type == 1 ? 'Work' : 'Other'}, ${address.street}',
                                                  style: const TextStyle(
                                                      color: AppColors
                                                          .secondaryColor)),
                                              const Divider(
                                                color:
                                                    AppColors.backgroundColor,
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList();

                                      // Add the "Add New Address" option at the end
                                      items.add(
                                        PopupMenuItem<String>(
                                          value: 'add_new_address',
                                          child: Text('Add New Address'.tr),
                                          onTap: () => UserNavigator.of(context)
                                              .push(const AddAddressScreen()),
                                        ),
                                      );

                                      return items;
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Change'.tr,
                                          style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.primaryColor,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.home_outlined,
                                      color: Colors.black),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      textAlign: TextAlign.start,
                                      '${'building'.tr} :${controllerAddress.buildingNumber.value}${'\n apartment'.tr}:  ${controllerAddress.apartmentNum.value}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                ],
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.phone, color: Colors.black),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("${"mobile".tr} $mobile",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                ],
                              ),
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  if (orderType != '2')
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.borderColor, width: 2)),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.cartList.length == 1
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Select Payment method'.tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    const SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.borderColor,
                                              width: 2)),
                                      child: DropdownButton<String>(
                                        underline: Container(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                        icon: const Icon(Icons.arrow_drop_down,
                                            color: AppColors.primaryColor,
                                            size: 30),
                                        dropdownColor:
                                            AppColors.backgroundColor,
                                        hint: Text('Select Payment'.tr),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        value: selectedPayment,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedPayment = newValue!;
                                          });
                                        },
                                        items: ['Cash'.tr, 'Wallet'.tr]
                                            .map((String payment) {
                                          return DropdownMenuItem<String>(
                                            value: payment,
                                            child: Text(payment.tr),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(''),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Select Date Order'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                              const SizedBox(width: 20),
                              InkWell(
                                  onTap: () async {
                                    log(DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now()));
                                    log('DateTime.now()');
                                    pickedDate = (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100)))!;

                                    log(pickedDate.toString());
                                    print(DateTime.now()
                                        .hour); //pickedDate output format => 2021-03-10 00:00:00.000
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    if (pickedDate.isBefore(DateTime.now())) {
                                      print('i');
                                      trueDate = 'date befor todys';
                                    }
                                    //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.borderColor,
                                            width: 2)),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(dateInput)),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Select Range Time Order'.tr,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          HourSelectionList(),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 2,
                      ),
                    ),
                    width: double.infinity,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {


                        return ProductWidget(
                          model: subCategoriesModel[index],
                        );
                      },
                      itemCount: subCategoriesModel.length,

                      shrinkWrap: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppColors.borderColor, width: 2)),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal  :'.tr,
                                style: (const TextStyle(
                                  color: Colors.black,
                                )),
                              ),
                              InkWell(
                                onTap: () {
                                  log(controller
                                      .getTotalPriceInCart2()
                                      .toString());
                                },
                                child: Text(
                                    controller
                                        .calculateTotal()
                                        .toStringAsFixed(2),
                                    style: (const TextStyle(
                                      color: Colors.black,
                                    ))),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Delivery fee',
                                style: (TextStyle(
                                  color: Colors.black,
                                )),
                              ),
                              Text(
                                deliveryFee.toStringAsFixed(2),
                                style: (const TextStyle(
                                  color: Colors.black,
                                )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Service fee',
                                style: (TextStyle(
                                  color: Colors.black,
                                )),
                              ),
                              Text(
                                schedulerFees.toStringAsFixed(2),
                                style: (const TextStyle(
                                  color: Colors.black,
                                )),
                              ),
                            ],
                          ),
                          const Divider(color: AppColors.borderColor),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total amount  ',
                                style: (TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                (schedulerFees +
                                        deliveryFee +
                                        subCategoriesController
                                            .calculateTotal())
                                    .toStringAsFixed(2),
                                style: (const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(170, 50),
                            backgroundColor: AppColors.backgroundColor,
                            textStyle: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          controller.getProducts(controller.shopId);
                          walletcontroller.getProducts(controller.shopId);

                          UserNavigator.of(context).maybePop();
                        },
                        child: Text("Add Item".tr,
                            style:
                                const TextStyle(color: AppColors.primaryColor)),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(170, 50)),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.primaryColor),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        onPressed: () async {
                          String? token =
                              await Get.find<AuthController>().getApiToken();
                          //TODO
                          print(controller.cartList
                              .map((e) => e.tooJson())
                              .toList());
                          if (orderType == '4') {
                            DateTime dateTime = DateTime.now();
                            String currentTime =
                                '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                            Map<String, dynamic> data = {
                              "category_id": 2,
                              "payment_type": 2,
                              "wallet_id": 1,
                              "order_type": "scheduled",
                              "order_date": currentTime,
                              "order_time_from": "10:30am",
                              "order_time_to": "11:30am",
                              "expedited_fees": expeditedFees,
                              "order": 1,
                              "delivery_fee": deliveryFee,
                              "total": controller.calculateTotal(),
                              "address_id": 1,
                              "type": 1,
                              "shop_id": 3,
                              "delivery_boy_id": int.parse(
                                  Get.find<NearbyDriverController>()
                                      .driverId
                                      .first),
                              "count": subCategoriesModel.length,
                              "night_order": true,
                              "commesion": 0.1,
                              "carts": controller.cartList
                                  .map((e) => e.tooJson())
                                  .toList()
                            };
                            Get.log(data.toString());
                            http.Response response = await http.post(
                              Uri.parse(
                                  'https://admin.wasiljo.com/public/api/v1/user/orders'),
                              body: json.encode(data),
                              headers: {
                                'Authorization': 'Bearer $token',
                                'Content-Type': 'application/json',
                                'Accept': 'application/json'
                              },
                            );
                            Get.log('1234 ${response.statusCode.toString()}');
                            Get.log('1234 ${response.body.toString()}');

                            if (response.statusCode == 200) {
                              Get.to(() => const SuccesPage());
                              orderType = '0';
                            }
                            if (response.statusCode != 200) {
                              Get.snackbar(
                                  'error ', jsonDecode(response.body)['error'],
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.TOP,
                                  colorText: Colors.white,
                                  icon: const Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ));
                            }
                            return;
                          }
                          if (orderType == '2') {
                            DateTime dateTime = DateTime.now();
                            String currentTime =
                                '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                            Map<String, dynamic> driver = {
                              "category_id": 2,
                              "payment_type": 2, //cash=2 or wallet =1
                              // "wallet_id":1,
                              "order_type": "urgent",
                              "order_date": currentTime,
                              "order_time_from": "10:30am",
                              "order_time_to": "11:30am",
                              "expedited_fees": expeditedFees,
                              "order": 1,
                              "delivery_fee": deliveryFee,
                              "total": controller.calculateTotal(),
                              "coupon_discount": null,
                              "coupon_id": null,
                              "address_id": 1,
                              "type": 1,
                              // "shop_id": 1,
                              "deliveryIds": Get.find<NearbyDriverController>()
                                  .driverId
                                  .join(','),
                              "count": subCategoriesModel.length,
                              "night_order": true,
                              "commesion": 0.1,
                              "carts": controller.cartList
                                  .map((e) => e.tooJson())
                                  .toList()
                            };
                            http.Response response = await http.post(
                              Uri.parse(
                                  'https://admin.wasiljo.com/public/api/v1/user/orders/driver'),
                              body: json.encode(driver),
                              headers: {
                                'Authorization': 'Bearer $token',
                                'Content-Type': 'application/json'
                              },
                            );
                            Get.log('1234 ${response.statusCode.toString()}');
                            Get.log('1234 ${response.body.toString()}');

                            if (response.statusCode == 200) {
                              Get.to(() => const SuccesPage());
                              orderType = '0';
                            }
                            if (response.statusCode != 200) {
                              Get.snackbar(
                                  'error ', jsonDecode(response.body)['error'],
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.TOP,
                                  colorText: Colors.white,
                                  icon: const Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ));
                            }
                            return;
                          }

                          if (pickedDate.day < DateTime.now().day) {
                            Get.snackbar(' date time ', 'date before today',
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                                icon: const Icon(Icons.error_outline));
                          } else if (HourSelectionList.startHour ==
                              HourSelectionList.endHour) {
                            Get.snackbar('  order not success ',
                                'start hour equal end hour'.tr,
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                                icon: const Icon(Icons.error_outline));
                          } else if (controller.shop!.open == 0) {
                            Get.snackbar('  order not success ',
                                'shop selected closed'.tr,
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                                icon: const Icon(Icons.error_outline));
                          } else {
                            orderController.createOrder(
                                categoryId: 1,
                                paymentType:
                                    selectedPayment == 'Cash'.tr ? 2 : 1,
                                walletId: 1,
                                orderDate: dateInput.toString(),
                                orderTimeFrom: HourSelectionList.startHour,
                                orderTimeTo: HourSelectionList.endHour,
                                expeditedFees: expeditedFees,
                                order: 1,
                                delivery_boy_id: null,
                                deliveryFee: deliveryFee,
                                total: controller.calculateTotal(),
                                couponId: 0,
                                addressId:
                                    int.parse(controllerAddress.id.value),
                                type: 1,
                                shopId: controller.shopId,
                                count: controller.cartList.length,
                                commesion: commesion,
                                cart: controller.cartList
                                    .map((e) => e.tooJson())
                                    .toList());
                          }
                        },
                        child: Text("Checkout".tr,
                            style: const TextStyle(
                              color: AppColors.backgroundColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
