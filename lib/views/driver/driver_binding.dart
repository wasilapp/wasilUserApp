import 'package:get/get.dart';
import 'package:userwasil/views/driver/driver_controller.dart';

class DriverBinding extends Bindings {
  DriverBinding(
      {required this.id, required this.latitude, required this.longitude});
  late int id;
  dynamic latitude, longitude;
  @override
  void dependencies() {
    Get.lazyPut(() =>
        DriverController(id: id, latitude: latitude, longitude: longitude));
  }
}
