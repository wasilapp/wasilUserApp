import 'package:get/get.dart';
import 'package:userwasil/views/nearby_driver/nearby_driver_controller.dart';

class NearbyDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NearbyDriverController());
  }
}
