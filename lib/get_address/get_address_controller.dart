// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:userwasil/get_address/address_model.dart';
//
// class AddressController extends GetxController{
//   Future <List<AddressesModel>> getAddress() async {
//     const String apiUrl = 'https://admin.wasiljo.com/public/api/v1/user/addresses';
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var token = prefs.getString('token');
//     List<AddressesModel> addressesList = [];
//     try {
//       final response = await get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//
//         final jsonData = json.decode(response.body);
//
//         List<dynamic> addresses = jsonData['data']['addresses'];
//
//         for (var address in addresses) {
//           AddressesModel subCategoriesModel = AddressesModel(
// id: address['id'],
//             apartmentNum: address['apartment_num'],
//             city: address['city'],
//             buildingNumber: address['building_number'],
//             latitude:address['latitude'],
//             longitude: address['longitude'],
//             street:  address['street'],
//             type:  address['type'],
//             defaultAddress:  address['default'],
//             active:  address['active'],
//             name:   address['name'],
//             userId:    address['user_id'],
//             // quantity: subCategory['quantity']
//           );
//           addressesList.add(subCategoriesModel);
//         }
//
//       }
//       return addressesList;
//     } on Exception catch (e) {
//       return [];
//       // TODO
//     }
//   }
//  // --------------------------
//
// }