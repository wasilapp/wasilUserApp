import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:userwasil/controller/AuthController_new.dart';
import '../../config/custom_package.dart';
import '../../utils/ui/progress_hud.dart';
import '../orders/order_model.dart';

class AddOrderController extends GetxController {
  AuthController controller = Get.put(AuthController());
  Future<void> createOrder({
    int? categoryId,
    int? paymentType,
    int? walletId,
    String? orderType,
    String? orderDate,
    String? orderTimeFrom,
    String? orderTimeTo,
    int? order,
    double? deliveryFee,
    double? expeditedFees,
    double? total,
    String? couponDiscount, //todo what type
    int? couponId,
    int? addressId,
    double? commesion,
    bool? nightOrder,
    int? count,
    String? deliveryIds,
    int? type,
    var cart,
  }) async {
    ProgressHud.shared.startLoading(Get.context);
    var addOrder =   Uri.parse('https://admin.wasiljo.com/public/api/v1/user/orders/driver'); // Replace with your actual URL
    var token=await controller.getApiToken();
    Map<String, dynamic> orderData = {
      "category_id": categoryId,
      "payment_type": paymentType,
      "wallet_id": walletId,
      "order_type": "scheduled",
      "order_date": orderDate,
      "order_time_from": orderTimeFrom,
      "order_time_to": orderTimeTo,
      "expedited_fees": expeditedFees,
      "order": order,
      "delivery_fee": deliveryFee,
      "total": total,
      // "coupon_discount": couponDiscount,
      // "coupon_id": couponId,
      "address_id": addressId,
      "type": 1,
      "deliveryIds": deliveryIds,
      "count": count,
      "night_order": true,
      "commesion": commesion,
      "carts": [
        {
          "sub_categories_id": 1,
          "quantity": 2,
          "price": 300,
          "total": 600,
        },
        {
          "sub_categories_id": 2,
          "quantity": 3,
          "price": 300,
          "total": 900,
        },
      ],
    };
    var body = json.encode(orderData);
    try {
      ProgressHud.shared.stopLoading();
      final response = await http.post(
        addOrder,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token '
        },
        body: body,
      );

      if (response.statusCode == 200) {
        log("Order created successfully.");
        log(response.body);
        Get.snackbar(' added order success ', 'send order by shop',
            backgroundColor: AppColors.primaryColor,
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.done_outline_rounded));
        Get.to(const AllOrder());
      } else {
        log("Failed to create the order. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("An error occurred: $e");
    }
  }
}
