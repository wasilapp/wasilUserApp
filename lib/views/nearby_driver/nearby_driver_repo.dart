import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:userwasil/core/constant/app_constent.dart';
import 'package:userwasil/views/nearby_driver/nearby_driver_controller.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';

NearbyDriverRepo nearbyDriverRepo = NearbyDriverRepo();

class NearbyDriverRepo {
  String subcategories = '/api/v1/user/categories/2/subcategories';
  Future<void> getSubcategories() async {
    http.Response? response =
        await http.get(Uri.parse('$baseUrl$subcategories'));
    if (response.statusCode == 200) {
      Get.find<NearbyDriverController>().subcategories =
          (json.decode(response.body)['data']['subcategories'] as List)
              .map((e) => SubCategoriesModel.fromJson(e))
              .toList();
      Get.find<NearbyDriverController>().isLoaded.value = true;
    }
  }
}
