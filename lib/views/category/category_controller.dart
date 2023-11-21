import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:userwasil/views/category/category_model.dart';

class CategoryController extends GetxController {
  LatLng currentLatLng = const LatLng(0, 0);
  @override
  void onInit() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLatLng = LatLng(position.latitude, position.longitude);
    Get.log('position.latitude ${position.latitude}');
  }

  Future<List<CategoriesModel>> fetchCategories() async {
    try {
      final response = await http.get(
          Uri.parse('https://admin.wasiljo.com/public/api/v1/user/categories'));
      var jsonData = jsonDecode(response.body);
      List<dynamic> categories = jsonData['data']['categories'];
      List<CategoriesModel> listCategories = [];
      if (response.statusCode == 200) {
        print("*************");
        for (var category in categories) {
          print("*************");
          CategoriesModel categoryModel = CategoriesModel(
            id: category['id'],
            title:
                Title(en: category['title']['en'], ar: category['title']['ar']),
            commesion: category['commesion'],
            type: category['type'],
            active: category['active'],
            deliveryFee: category['deliveryFee'],
            description: Title(
                en: category['description']['en'],
                ar: category['description']['ar']),
            startWorkTime: category['startWorkTime'],
            endWorkTime: category['endWorkTime'],
            imageUrl: category['image_url'],
          );
          print("*************");
          listCategories.add(categoryModel);
          print("*************");
          print("$listCategories");
        }
      }

      return listCategories;
    } on Exception catch (e) {
      // TODO
      throw Exception('Failed to load Categories $e');
    }
  }
}
