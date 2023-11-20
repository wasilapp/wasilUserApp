import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:userwasil/controller/address.dart';
import 'package:userwasil/model/driver_order.dart';
import 'package:userwasil/utils/tools/tools.dart';
import 'package:userwasil/views/nearby_driver/nearby_driver_repo.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_controller.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';

class NearbyDriverController extends GetxController {
  SubCategoriesController subCategoriesController =
      Get.find<SubCategoriesController>();
  List<SubCategoriesModel> subcategories = [];
  RxBool isLoaded = false.obs;
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(
      31.9855981,
      35.9578289,
    ),
    zoom: 14.5,
  );
  RxBool showMap = false.obs;
  GoogleMapController? mapController;
  final Set<Marker> markers = {
    Marker(
      markerId: const MarkerId('-1'),
      position: LatLng(
        double.parse(Get.find<AddressController>().lat.value),
        double.parse(Get.find<AddressController>().long.value),
      ),
    ),
  }.obs;
  List<DriverOrder> driverOrder = [];
  List<String> driverId = [];
  @override
  void onInit() async {
    super.onInit();
    nearbyDriverRepo.getSubcategories();
    await FirebaseFirestore.instance
        .collection('deliveryBoys')
        .get()
        .then((value) {
      for (int index = 0; index < value.docs.length; index++) {
        if (markers.length > 6) {
          break;
        }
        bool haveLocation = value.docs[index].data()['latitude'] != null;
        bool isGasDriver = value.docs[index].data()['category_id'] == 2;
        bool isActive = value.docs[index].data()['is_offline'] == 0;
        if (haveLocation && isGasDriver && isActive) {
          LatLng latLng = LatLng(
            double.parse(value.docs[index].data()['latitude'].toString()),
            double.parse(
              value.docs[index].data()['longitude'].toString(),
            ),
          );
          double distance = appTools.calculateDistance(
            LatLng(
              double.parse(Get.find<AddressController>().lat.value),
              double.parse(Get.find<AddressController>().long.value),
            ),
            latLng,
          );
          if (distance < 5000) {
            markers.add(
              Marker(
                markerId: MarkerId(index.toString()),
                position: LatLng(
                  double.parse(value.docs[index].data()['latitude'].toString()),
                  double.parse(
                    value.docs[index].data()['longitude'].toString(),
                  ),
                ),
              ),
            );
            Get.log('1234 ${markers.length}');
            update();
            DriverOrder driverOrderData =
                DriverOrder.fromJson(value.docs[index].data());
            driverOrder.add(driverOrderData);
            driverId.add(value.docs[index].data()['id'].toString());
            Get.log('1234 ${latLng.latitude.toString()}');
            Get.log('1234 ${latLng.longitude.toString()}');
          }

          showMap.value = true;
          update();
        }
      }
    });
  }
}
