// import 'dart:convert';
//
//
//
// import '../api/api_util.dart';
// import '../models/AdBanner.dart';
//
// import '../models/MyResponse.dart';
// import '../models/Shop.dart';
// import '../services/Network.dart';
// import '../utils/helper/InternetUtils.dart';
// import 'AuthController.dart';
//
// class HomeController {
//   static String shops = "shops";
//   static String banners = "banners";
//   static String categories = "categories";
//
//   //------------------------ Get single shop -----------------------------------------//
//   static Future<MyResponse<Map<String, dynamic>>> getHomeData(
//       int? shopId) async {
//     //Getting User Api Token
//     String? token = await AuthController.getApiToken();
//     String url = ApiUtil.MAIN_API_URL + ApiUtil.HOME + shopId.toString();
//     Map<String, String> headers =
//         ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);
//
//     //Check Internet
//     bool isConnected = await InternetUtils.checkConnection();
//     if (!isConnected) {
//       return MyResponse.makeInternetConnectionError<Map<String, dynamic>>();
//     }
//
//     try {
//       NetworkResponse response = await Network.get(url, headers: headers);
//       MyResponse<Map<String, dynamic>> myResponse =
//           MyResponse(response.statusCode);
//       if (ApiUtil.isResponseSuccess(response.statusCode!)) {
//         myResponse.success = true;
//         dynamic decodedData = json.decode(response.body!);
//         Map<String, dynamic> data = {
//          // shops: Shop.getListFromJson(decodedData['shops']),
//           banners: AdBanner.getListFromJson(decodedData['banners']),
//         // categories: Category.getListFromJson(decodedData['categories'])
//         };
//         myResponse.data = data;
//       } else {
//         myResponse.success = false;
//         myResponse.setError(json.decode(response.body!));
//       }
//       return myResponse;
//     } catch (e) {
//       //If any server error...
//       return MyResponse.makeServerProblemError<Map<String, dynamic>>();
//     }
//   }
//
//   //------------------------ Get all shop -----------------------------------------//
//   static Future<MyResponse<List<Shop>>> getAllShop() async {
//     //Getting User Api Token
//     String? token = await AuthController.getApiToken();
//     String url = ApiUtil.MAIN_API_URL + ApiUtil.SHOPS;
//     Map<String, String> headers =
//         ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);
//
//     //Check Internet
//     bool isConnected = await InternetUtils.checkConnection();
//     if (!isConnected) {
//       return MyResponse.makeInternetConnectionError<List<Shop>>();
//     }
//
//     try {
//       NetworkResponse response = await Network.get(url, headers: headers);
//
//       MyResponse<List<Shop>> myResponse = MyResponse(response.statusCode);
//       if (ApiUtil.isResponseSuccess(response.statusCode!)) {
//         myResponse.success = true;
//         myResponse.data = Shop.getListFromJson(json.decode(response.body!));
//       } else {
//         myResponse.success = false;
//         myResponse.setError(json.decode(response.body!));
//       }
//       return myResponse;
//     } catch (e) {
//       //If any server error...
//       return MyResponse.makeServerProblemError<List<Shop>>();
//     }
//   }
//
//   //------------------------ Get all shop -----------------------------------------//
//   static Future<MyResponse<List<Shop>>> getShopsFromUserAddress(
//       int userAddressId) async {
//     //Getting User Api Token
//     String? token = await AuthController.getApiToken();
//     String url = ApiUtil.MAIN_API_URL +
//         ApiUtil.SHOPS +
//         ApiUtil.ADDRESSES +
//         userAddressId.toString();
//
//     Map<String, String> headers = ApiUtil.getHeader(
//       requestType: RequestType.GetWithAuth,
//       token: token,
//     );
//
//     //Check Internet
//     bool isConnected = await InternetUtils.checkConnection();
//     if (!isConnected) {
//       return MyResponse.makeInternetConnectionError<List<Shop>>();
//     }
//
//     try {
//       NetworkResponse response = await Network.get(url, headers: headers);
//       MyResponse<List<Shop>> myResponse = MyResponse(response.statusCode);
//       if (ApiUtil.isResponseSuccess(response.statusCode!)) {
//         myResponse.success = true;
//         myResponse.data = Shop.getListFromJson(json.decode(response.body!));
//       } else {
//         myResponse.success = false;
//         myResponse.setError(json.decode(response.body!));
//       }
//       return myResponse;
//     } catch (e) {
//       //If any server error...
//       return MyResponse.makeServerProblemError<List<Shop>>();
//     }
//   }
// }
