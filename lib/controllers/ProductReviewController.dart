import 'dart:convert';



import '../api/api_util.dart';
import '../models/MyResponse.dart';
import '../services/Network.dart';
import '../utils/helper/InternetUtils.dart';
import 'AuthController.dart';

class ProductReviewController {

  //------------------------ Add review for products -----------------------------------------//
  static Future<MyResponse> addReview(
      int? orderId, int rating, String review) async {
    //Get Api Token
    String? token = await AuthController.getApiToken();
    String url = ApiUtil.MAIN_API_URL + ApiUtil.PRODUCT_REVIEWS;
    Map<String, String> headers =
        ApiUtil.getHeader(requestType: RequestType.PostWithAuth, token: token);

    //Body data
    Map data = {
      'order_id': orderId,
  
      'rating': rating,
      'review': review
    };

    //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if(!isConnected){
      return MyResponse.makeInternetConnectionError();
    }

    try {
      NetworkResponse response = await Network.post(
          url, headers: headers, body: body);

      MyResponse myResponse = MyResponse(response.statusCode);
      if (response.statusCode == 200) {
        myResponse.success = true;
        myResponse.data = json.decode(response.body!);
      } else {
        Map<String, dynamic> data = json.decode(response.body!);
        myResponse.success = false;
        myResponse.setError(data);
      }
      return myResponse;
    }catch(e){

      //If any server error...
      return MyResponse.makeServerProblemError();
    }
  }
}
