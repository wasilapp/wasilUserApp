import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/main_sub_model.dart';


class CartProvider extends GetxController {
  Map<String, Carts> _cartItems = {};

  Map<String, Carts> get getCartItems {
    return _cartItems;
  }

  void addProductsToCart({

    required int quantity,
    required int orderId,
    required int id,
    required  price,
    required  subCategoriesId,
    required  total,
  }) {
    _cartItems.putIfAbsent(
      id.toString(),
          () => Carts(
    orderId:orderId ,price: price,subCategoriesId: subCategoriesId,total:total ,
        id: id,
        quantity: quantity,
      ),
    );
print(_cartItems);
  }

  void reduceQuantityByOne(int id) {
    _cartItems.update(
      id.toString(),
          (value) => Carts(
        id: value.id,

        quantity: value.quantity! - 1,
      ),
    );


  }

  void increaseQuantityByOne(String id) {
    _cartItems.update(
      id,
          (value) => Carts(
        id: value.id,

        quantity: value.quantity! + 1,
      ),
    );

  }

  void removeOneItem(String id) {
    _cartItems.remove(id);

  }

  void clearCart() {
    _cartItems.clear();

  }
}
