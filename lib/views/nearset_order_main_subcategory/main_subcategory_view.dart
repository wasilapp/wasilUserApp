import 'dart:convert';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:userwasil/views/nearset_order_main_subcategory/main_sub_model.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/product_eidget.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/xx.dart';
import '../../config/custom_package.dart';
import '../../controller/address.dart';
import '../../core/locale/locale.controller.dart';
import '../home/category_view/components/address_widget.dart';
import 'checkout_view.dart';
import 'main_sub_controller.dart';

class Nearset extends StatefulWidget {
  const Nearset({super.key});

  @override
  State<Nearset> createState() => _NearsetState();
}

class _NearsetState extends State<Nearset> {
  String? selectedPriceRange;
  String? title;
  int? id;

  final List<String> priceRanges = [
    "Under 1 Jod",
    "1 - 1.5",
    "1.5 - 3",
    "Over 3",
  ];
  final List<String> priceNewRanges = [
    "Under 42 Jod",
    "1 - 1.5",
    "1.5 - 3",
    "Over 3",
  ];

  String? selectedPriceNewRange;

  @override
  void initState() {
    super.initState();
    getData();
  }

  var cityTFController;
  var addressTFController;
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

  @override
  Widget build(BuildContext context) {
    AddressController controllerAddress = Get.put(AddressController());

    MainSubcategoryController controller = Get.put(MainSubcategoryController());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            child: const AddressWidget(),
            // ,decoration: BoxDecoration(
            //     border: Border.all(color: AppColors.primaryColor)
            // )
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
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
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            if (controller.isWaiting) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 160,
                          width: 100.w,
                          color: Colors.grey,
                        )),
                  );
                },
                itemCount: 10,
              );
            }
            if (controller.isError) {
              return Center(
                child: Text(controller.statusModel.value.errorMsg!.value),
              );
            }
            return Center(
              child: Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return wid(
                      model: controller.mainSubcategoryList[index],
                    );
                  },
                  itemCount: controller.mainSubcategoryList.length,
                  shrinkWrap: true,
                ),
              ),
            );
          }),
          id == null
              ? const Text('')
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' price ${title!}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Material(
                          color: Colors.white,
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            underline: Text(''),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(10),
                            elevation: 10,
                            hint: const Text('select price',
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            value: id == 1
                                ? selectedPriceRange
                                : selectedPriceNewRange,
                            onChanged: (newValue) {
                              setState(() {
                                id == 1
                                    ? selectedPriceRange
                                    : selectedPriceNewRange = newValue;
                              });
                            },
                            items: id == 1
                                ? priceRanges.map((String priceItem) {
                                    return DropdownMenuItem<String>(
                                      value: priceItem,
                                      child: Text(priceItem),
                                    );
                                  }).toList()
                                : priceNewRanges.map((String priceItem) {
                                    return DropdownMenuItem<String>(
                                      value: priceItem,
                                      child: Text(priceItem),
                                    );
                                  }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Spacer(),
          CommonViews().createButton(
            title: 'Check out',
            onPressed: () {},
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  main(MainSubcategoryModel model) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                id = model.id;
                title = model.title!.en;
              });
              print(model.id);
            },
            child: Material(
              elevation: 10,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(

                        // border: Border.all(color: AppColors.primaryColor),borderRadius: BorderRadius.circular(10)
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://admin.wasiljo.com/${model.imageUrl}',
                          height: 100,
                        ),
                        Text(model.title!.en!.toString()),
                        Text(
                          'Add Item',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
