import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userwasil/controller/general_status_model.dart';
import 'package:userwasil/views/orders/my_order_model.dart';


import '../../core/constant/colors.dart';
import 'order_model.dart';
class OrderController extends GetxController{
  var orders=[].obs;
  MyOrder ? myOrders;
  late var statusModel = GeneralStatusModel().obs;
  @override
  void onInit() {
    log('k');
    getOrders();
  }
  void getOrders() async {

    statusModel.value.updateStatus(GeneralStatus.waiting);
    SharedPreferences prefs= await SharedPreferences.getInstance();
    var token=prefs.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };
    var url = Uri.parse('https://news.wasiljo.com/public/api/v1/user/orders');
    var response = await http.get(
      url,headers: headers
    );
// log(response.body);
log(response.statusCode.toString());
    if (response.statusCode == 200) {


      log('response.statusCode  id${response.statusCode}');
      log('response.body  id${json.decode(response.body)}');

      if (json.decode(response.body).isEmpty) {
        log('response.isEmpty  id${json.decode(response.body)}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      List result = json.decode(response.body);
      log('start for');
      log(result.length.toString());

      for (int index = 0; index < result.length; index++) {

        OrderModel product = OrderModel.fromJson(result[index]);
log(product.id.toString());
        orders.add(product);
        log(orders.length.toString());
        log('lllllllllllllll');
        statusModel.value.updateStatus(GeneralStatus.success);
      }
      log('lllllllllllllll');

      log(response.body);
      return;
    }
    else{
      log(response.body);
    }
    statusModel.value.updateStatus(GeneralStatus.error);
    statusModel.value.updateError("Something went wrong");
  }
  void getDetailOrders(orderId) async {
    // statusModel.value.updateStatus(GeneralStatus.waiting);
   SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };
    var url = Uri.parse(
        'https://news.wasiljo.com/public/api/v1/user/order/$orderId');
    var response = await http.get(
        url, headers: headers
    );
 log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('response.statusCode  id${response.statusCode}');
      log('response.body  id${json.decode(response.body)}');

      if (json
          .decode(response.body)
          .isEmpty) {
        log('response.isEmpty  id${json.decode(response.body)}');

        statusModel.value.updateStatus(GeneralStatus.error);
        statusModel.value.updateError("No Result Found");
        return;
      }
      var result = json.decode(response.body);
      log('start for');
      log(result.length.toString());
      MyOrder product = MyOrder.fromJson(result);

myOrders=product;

      log(product.id.toString());


      //statusModel.value.updateStatus(GeneralStatus.success);



    log(response.body);
    return;
  }
    else{


      log(response.body);
    }
    // statusModel.value.updateStatus(GeneralStatus.error);
    // statusModel.value.updateError("Something went wrong");
  }
//   Future<List<OrdersModel>> fetchAllOrder() async {
//     SharedPreferences prefs= await SharedPreferences.getInstance();
//     var token=prefs.getString('token');
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token '
//     };
//
//     try {
// print("start");
//       final response = await http.get(Uri.parse('https://news.wasiljo.com/public/api/v1/user/orders'),
//       headers: headers);
// print("*******************************");
// print(response.body);
//       var jsonData=jsonDecode(response.body);
//       List <dynamic> orders=jsonData;
//       // List <dynamic> carts=jsonData['data']['carts'];
//       List<OrdersModel> listOrders=[];
//       if(response.statusCode==200){
//
//         for( var order in orders){
//           OrdersModel shopModel=OrdersModel(
//          id: order['id'],
//
//             // address: AddressByOrder(
//             //     id: order['address']['id'],
//             //     latitude: order['address']['latitude'],
//             //     longitude: order['address']['longitude'],
//             //   distance: order['address']['distance'],
//             //   name: order['address']['name'],
//             //   street: order['address']['street'],
//             //   buildingNumber: order['address']['building_number'],
//             //   city: order['address']['city'],
//             //   apartmentNum: order['address']['apartment_num'],
//             //   active: order['address']['active'],
//             //   userId: order['address']['user_id'],
//             //   type: order['address']['type'],
//             // ),
//             // carts:[Carts(
//             //  id: order['carts'] ['id'],
//             //   orderId: order['carts'] ['order_id'],
//             //   subCategoriesId: order['carts'] ['sub_categories_id'],
//             //   quantity: order['carts'] ['quantity'],
//             //   price: order['carts'] ['price'],
//             //   total: order['carts'] ['total'],
//             //
//             // ),Carts(
//             //   id: order['carts'] ['id'],
//             //   orderId: order['carts'] ['order_id'],
//             //   subCategoriesId: order['carts'] ['sub_categories_id'],
//             //   quantity: order['carts'] ['quantity'],
//             //   price: order['carts'] ['price'],
//             //   total: order['carts'] ['total'],
//             //
//             // ),
//             // ],
//             shop: ShopOrder(
//               id: order['shop'] ['id'],
//               name:NameByOrder(
//                 ar:order['shop']['name']['ar'],
//                 en:order['shop']['name']['en'],
//               ),
//
//             ),
//             user: UserByOrder(
//               id: order['user'] ['id'],
//               name: order['user'] ['name'],
//               email: order['user'] ['email'],
//               mobile: order['user'] ['mobile']
//
//             ),
//             userId: order['user_id'],
//             type: order['type'],
//             addressId: order['address_id'],
//            order: order['order'],
//             count: order['count'],
//             statu:Status(id: order['statu']['id'],
//             title:
//                 Title(
//                   ar:order['statu']['title']['ar'],
//                   en:order['statu']['title']['en'],
//                 )
//             ),
//             createdAt: order['created_at'],
//
//
//           );
//
//           listOrders.add(shopModel);
//
//         }}
//
//       return listOrders;
//     } on Exception catch (e) {
//       // TODO
//       throw Exception('Failed to load shops');
//     }
//   }
cancelOrder(int idOrder) async {

  SharedPreferences prefs= await SharedPreferences.getInstance();
  var token=prefs.getString('token');
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token '
  };
  var request = http.Request('POST', Uri.parse('https://news.wasiljo.com/public/api/v1/user/order/$idOrder/cancel'));
  request.body = '''''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    getOrders();
    Get.snackbar('cancel order success', '',
        backgroundColor: AppColors.primaryColor, snackPosition: SnackPosition.BOTTOM,
       );
    print(await response.stream.bytesToString());


  }
  else {
  print(response.reasonPhrase);
  }

}
  get isWaiting => statusModel.value.status.value == GeneralStatus.waiting;

  get isError => statusModel.value.status.value == GeneralStatus.error;

  get isSuccess => statusModel.value.status.value == GeneralStatus.success;
}