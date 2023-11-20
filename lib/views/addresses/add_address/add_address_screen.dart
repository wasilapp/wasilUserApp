import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:userwasil/utils/ui/text_feild_address.dart';
import '../../../config/custom_package.dart';

import '../../../controller/address.dart';
import '../../../model/address.dart';
import '../../../utils/theme/theme.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';


import '../../home/category_view/home_screen.dart';
import '../../old/api/api_util.dart';
import '../../old/models/MyResponse.dart';
import '../../old/models/UserAddress.dart';
import '../../old/controllers/AddressController.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  AddAddressScreenState createState() => AddAddressScreenState();
}

class AddAddressScreenState extends State<AddAddressScreen> {
  //UI variables
  late ThemeData themeData;
  CustomAppTheme? customAppTheme;
  OutlineInputBorder? allTFBorder;
  TextStyle? allTFStyle;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //Selected Address Type
  int selectedAddressType = UserAddress.HOME;

  //Google Maps
  GoogleMapController? mapController;
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(31.936783, 35.874772),
    )
  };
  LatLng _center = const LatLng(31.936783, 35.874772);

  BitmapDescriptor? pinLocationIcon;
  bool loaded = false;

  late LatLng currentPosition;
  TextEditingController nameTFController = TextEditingController();

  //Text Controller
  TextEditingController? streetTFController,
      buildingNumberTFController,
      cityTFController,
      apartmentTFController;

  //Other
  bool isInProgress = false;

  @override
  void initState() {
    super.initState();
    currentPosition = _center;
    streetTFController = TextEditingController();
    buildingNumberTFController = TextEditingController();
    cityTFController = TextEditingController();
    apartmentTFController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) => _changeLoaded());
    gettingLocation();
  }

  @override
  dispose() {
    super.dispose();

    mapController!.dispose();
  }

  _changeLoaded() {
    setState(() {
      loaded = true;
    });
  }

  _setupLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
    }
    return permission;
  }

  Future<void> gettingLocation() async {
    LocationPermission locationPermission = await _setupLocationPermission();

    if (locationPermission != LocationPermission.always &&
        locationPermission != LocationPermission.whileInUse) {
      return;
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double zoom = await mapController!.getZoomLevel();
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      cityTFController!.text = placemarks[0].locality.toString();
      streetTFController!.text = placemarks[0].street.toString();

      _changeLocation(zoom, LatLng(position.latitude, position.longitude));
    } catch (error) {
      return;
    }
  }

  void _onMapTap(LatLng latLong) {
    mapController!
        .getZoomLevel()
        .then((zoom) => {_changeLocation(zoom, latLong)});
  }

  Future<void> _changeLocation(double zoom, LatLng latLng) async {
    double newZoom = zoom > 15 ? zoom : 15;
    currentPosition = latLng;
    final List<Placemark> placeMark =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    cityTFController!.text = placeMark[0].locality.toString();
    streetTFController!.text = placeMark[0].street.toString();

    setState(() {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: newZoom)));
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId('1'),
        position: latLng,
      ));
    });
  }

  _initUI() {
    allTFBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide.none);
  }

  Geolocation? geo;
  AddressController controller =Get.put(AddressController());
  _saveAddress() async {
    String street = streetTFController!.text;
    String buildingNumber = buildingNumberTFController!.text;
    String city = cityTFController!.text;
    String apartmentNumberText = apartmentTFController!.text;
    String name = nameTFController!.text;
    int? apartmentNumber;
    if (apartmentNumberText.isNotEmpty) {
      apartmentNumber = int.parse(apartmentTFController!.text);
    }

    if (street.isEmpty) {
      showMessage(message: Translator.translate("please_fill_address".tr));
    } else if (city.isEmpty) {
      showMessage(message: Translator.translate("please_fill_city".tr));
    } else if (apartmentNumber == null) {
      showMessage(
          message: Translator.translate("please_fill_apartment_number".tr));
    } else {
      if (mounted) {
        setState(() {
          isInProgress = true;
        });
      }

      double latitude = currentPosition.latitude;
      double longitude = currentPosition.longitude;

  await controller.addAddress(
          latitude: latitude.toString(),
          longitude: longitude.toString(),
          name: nameTFController!.text,
          buildingNumber:  buildingNumberTFController!.text,
          street: streetTFController!.text,
          city: cityTFController!.text,
          apartmentNum: apartmentTFController!.text,
          type: selectedAddressType);

      // if (myResponse.success) {
      //   UserNavigator.of(context).pushReplacement(const HomeScreen());
      // } else {
      //   // ApiUtil.checkRedirectNavigation(context, myResponse.responseCode);
      //   showMessage(message: myResponse.errorText);
      // }

      if (mounted) {
        setState(() {
          isInProgress = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        _initUI();
        return MaterialApp(
            scaffoldMessengerKey: _scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
            home: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: Text(
                    Translator.translate("address".tr),
                    style: const TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    gettingLocation();
                  },
                  child: Icon(
                    // MdiIcons.mapMarkerOutline,map
                    Icons.location_on_sharp,
                    color: themeData.colorScheme.onPrimary,
                  ),
                ),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      child: loaded
                          ? GoogleMap(
                              onMapCreated: (controller) {
                                mapController = controller;
                              },
                              markers: _markers,
                              onTap: _onMapTap,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 11.0,
                              ),
                            )
                          : Container(),
                    ),
                    SingleChildScrollView(
                      child: SearchMapPlaceWidget(
                        bgColor: Colors.transparent,
                        iconColor: Colors.black,
                        placeholder: 'Search Location'.tr,
                        placeType: PlaceType.address,
                        hasClearButton: false,
                        textColor: Colors.black,
                        apiKey: 'AIzaSyBr0p9mdNnj8O8kFMEkQlxk6Mn0GhzHFyM',
                        onSelected: (Place place) async {
                          //   _onAddMarkerButtonPressed();
                          geo = await place.geolocation;

                          mapController!.animateCamera(
                              CameraUpdate.newLatLng(geo?.coordinates));
                          mapController!.animateCamera(
                              CameraUpdate.newLatLngBounds(geo?.bounds, 0));
                          _center = geo!.coordinates;
                          _onMapTap(_center);
                        },
                      ),
                    ),
                    Container(
                        padding: Spacing.fromLTRB(24, 8, 24, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                Radio<int>(
                                    value: UserAddress.HOME,
                                    groupValue: selectedAddressType,
                                    onChanged: (value) {
                                      setState(() {
                                        print(selectedAddressType);
                                        selectedAddressType = value!;
                                      });
                                    }),
                                Text(
                                  Translator.translate("home".tr),
                                  style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    color: themeData.colorScheme.onBackground,
                                  ),
                                ),
                                Spacing.width(8),
                                Radio<int>(
                                    value: UserAddress.WORK,
                                    groupValue: selectedAddressType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAddressType = value!;
                                      });
                                    }),
                                Text(
                                  Translator.translate("work".tr),
                                  style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    color: themeData.colorScheme.onBackground,
                                  ),
                                ),
                                Spacing.width(8),
                                Radio<int>(
                                    value: UserAddress.OTHER,
                                    groupValue: selectedAddressType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAddressType = value!;
                                      });
                                    }),
                                Text(
                                  Translator.translate("other".tr),
                                  style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    color: themeData.colorScheme.onBackground,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: themeData.cardTheme.color,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                boxShadow: [
                                  BoxShadow(
                                    color: themeData.cardTheme.shadowColor!
                                        .withAlpha(28),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormFieldAddress(
                                      hintText: 'Name Address'.tr,
                                      controller: nameTFController!,
                                      prefixIconData: Icons.display_settings),
                                  TextFormFieldAddress(
                                    hintText: 'street_name'.tr,
                                    readOnly: true,
                                    controller: streetTFController!,
                                    prefixIconData: Icons.location_on_sharp,
                                  ),
                                  TextFormFieldAddress(
                                    hintText: 'building_number'.tr,
                                    controller: buildingNumberTFController!,
                                    prefixIconData: Icons.add_location_alt,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: TextFormFieldAddress(
                                          readOnly: true,
                                          controller: cityTFController!,
                                          prefixIconData:
                                              Icons.location_on_sharp, hintText: 'city'.tr,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: Spacing.left(8),
                                          child: TextFormField(
                                            style: allTFStyle,
                                            decoration: InputDecoration(
                                              hintText: Translator.translate(
                                                  "apartment_number".tr),
                                              border: allTFBorder,
                                              enabledBorder: allTFBorder,
                                              focusedBorder: allTFBorder,
                                              prefixIcon: const Icon(
                                                Icons.onetwothree_outlined,
                                                size: 24,
                                              ),
                                            ),
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                            controller: apartmentTFController,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: Spacing.top(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: themeData.colorScheme.onBackground,
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  const MaterialStatePropertyAll(
                                                      AppColors.primaryColor),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      Spacing.xy(24, 12)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ))),
                                          onPressed: () {
                                            _saveAddress();
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Container(
                                              //   margin: Spacing.right(16),
                                              //   child: isInProgress
                                              //       ? SizedBox(
                                              //           width: 16,
                                              //           height: 16,
                                              //           child: CircularProgressIndicator(
                                              //               valueColor: AlwaysStoppedAnimation<
                                              //                       Color>(
                                              //                   themeData
                                              //                       .colorScheme
                                              //                       .onPrimary),
                                              //               strokeWidth: 1.4),
                                              //         )
                                              //       : ClipOval(
                                              //           child: Icon(
                                              //             Icons.check,
                                              //             color: themeData
                                              //                 .colorScheme
                                              //                 .onPrimary,
                                              //             size: 18,
                                              //           ),
                                              //         ),
                                              // ),
                                              Text(
                                                  Translator.translate(
                                                          "save_address".tr)
                                                      .toUpperCase(),
                                                  style: AppTheme.getTextStyle(
                                                      themeData
                                                          .textTheme.caption,
                                                      fontSize: 15,
                                                      fontWeight: 600,
                                                      letterSpacing: 0.5,
                                                      color: themeData
                                                          .colorScheme
                                                          .onPrimary)),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                )));
      },
    );
  }

  void showMessage({String message = "Something wrong", Duration? duration}) {
    duration ??= const Duration(seconds: 3);
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
