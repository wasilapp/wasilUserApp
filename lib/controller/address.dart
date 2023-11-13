import 'dart:convert';
import 'dart:developer';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:userwasil/views/home/category_view/home_screen.dart';

import '../../../services/Network.dart';
import '../../../utils/helper/InternetUtils.dart';
import 'package:http/http.dart'as http;
import '../config/custom_package.dart';
import '../model/address.dart';
import '../views/old/api/api_util.dart';
import '../views/old/models/MyResponse.dart';
import 'AuthController.dart';
import 'AuthController_new.dart';


class AddressController extends GetxController {
  AuthController authControllerUser = Get.put(AuthController());

  var listAddress=RxList<UserAddress>();
  var selectedAddress=''.obs;
  var street=''.obs;
  var buildingNumber=''.obs;
  var apartmentNum=''.obs;
  var id=''.obs;
  var lat=''.obs;
  var long=''.obs;


 var _listDefaultAddress = <UserAddress>[].obs;

  get listDefaultAddress => listAddress.value.where((element) => element.isDefault).toSet().toList();

  set listDefaultAddress(value) {
    _listDefaultAddress = value;
  }

  @override
 void onInit(){
   getMyAddresses();
 }
  //-------------------- Add user address --------------------------------//
 Future  addAddress (
     {String? latitude,
       String? longitude,
       String? street,
       String? name,
       String? buildingNumber,
       String? city,
       String? apartmentNum,
       int? type}) async{
    // get token user
   AuthController authControllerUser = Get.put(AuthController());

   String? token = await authControllerUser.getApiToken();
   // url add new address
   String url = 'https://news.wasiljo.com/public/api/v1/user/addresses';
   Map<String, String> headers =
   ApiUtil.getHeader(requestType: RequestType.PostWithAuth, token: token);
   final Map<String, dynamic> data = {
     'longitude': longitude,
     'latitude': latitude,
     'street': street,
     'city': city,
     'apartment_num': apartmentNum,
     'type': type,
     'default': 0,
     'name': name,
     'building_number':buildingNumber

   };
   //encode body
   var body=json.encode(data);
   try  {
     var response= await http.post(Uri.parse(url),headers: headers,body:body );
     if(response.statusCode==200){

    var jsonData=jsonDecode(response.body.toString());
       var address = jsonData['data']['Address'];
       // print(address);
       listAddress.add(UserAddress.fromJson(address));
       Get.snackbar(
         'Added successfully',
         '',
         snackPosition: SnackPosition.TOP,
         colorText: Colors.white,
         backgroundColor: AppColors.primaryColor,
         icon: const Icon(Icons.add_alert),
       );
       print('ik');
     Get.to(const HomeScreen());
     }

   }
   catch(e){
     log (e.toString());
   }
 }
 //-------------------- get user addresses --------------------------------//
   Future<RxList<UserAddress>> getMyAddresses() async {

    //Getting User Api Token
    String? token = await authControllerUser.getApiToken();
    String url ='https://news.wasiljo.com/public/api/v1/user/addresses';
    Map<String, String> headers =
    ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);

    try {
      final response=await http.get(Uri.parse(url),headers:headers );
      var jsonData =jsonDecode(response.body.toString());
      var address = jsonData['data']['addresses'];
      if(response.statusCode==200){
        for(Map<String,dynamic> index in address){
          listAddress.add(UserAddress.fromJson(index));
        }
        return listAddress;
      }
      else{
        log(response.statusCode.toString());
        return listAddress;
      }

    }catch(e){
      //If any server error...
      log(e.toString());
      return listAddress;
    }
  }


  //-------------------- update user address --------------------------------//
   Future<MyResponse> updateAddress(int addressId,
      {bool? isDefault,
        double? latitude,
        double? longitude,
        String? address,
        String? address2,
        String? city,
        int? pincode,
        int? type}) async {
    //Getting User Api Token
    String? token = await authControllerUser.getApiToken();
    String url =
        'https://news.wasiljo.com/public/api/v1/user/addresses'+ addressId.toString();

    //Body Data
    Map data = {};
    if (isDefault != null) {
      data['default'] = isDefault;
    }
    if (latitude != null) {
      data['latitude'] = latitude;
    }
    if (longitude != null) {
      data['longitude'] = longitude;
    }

    if (address != null) {
      data['address'] = address;
    }
    if (address2 != null) {
      data['address2'] = address2 + "";
    }
    if (city != null) {
      data['city'] = city;
    }
    if (pincode != null) {
      data['pincode'] = pincode;
    }
    if (type != null) {
      data['type'] = type;
    }

    //Encode
    String body = json.encode(data);

    Map<String, String> headers =
    ApiUtil.getHeader(requestType: RequestType.PostWithAuth, token: token);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    log(body);

    try {
      NetworkResponse response =
      await Network.post(url, headers: headers, body: body);

      log(response.body.toString());

      log(response.statusCode.toString());

      MyResponse myResponse = MyResponse(response.statusCode);
      if (ApiUtil.isResponseSuccess(response.statusCode!)) {
        myResponse.success = true;
      } else {
        Map<String, dynamic> data = json.decode(response.body!);
        myResponse.success = false;
        myResponse.setError(data);
      }
      return myResponse;
    } catch (e) {
      //If any server error...
      log(e.toString());
      return MyResponse.makeServerProblemError();
    }
  }

  //-------------------- Delete user address --------------------------------//
 Future<void> deleteAddress(int addressId) async {
   String? token = await authControllerUser.getApiToken();
   String url = 'https://news.wasiljo.com/public/api/v1/user/addresses/$addressId';
   Map<String, String> headers = ApiUtil.getHeader(requestType: RequestType.PostWithAuth, token: token);
   var response =await http.delete( Uri.parse(url),headers: headers);



   if (response.statusCode == 200) {
     print('done');
   }
   else {
     print(response.reasonPhrase);
   }
 }

}
