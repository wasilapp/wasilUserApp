import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/x.dart';

import '../../config/custom_package.dart';
import 'main_sub_model.dart';

class wid extends StatelessWidget {
  final MainSubcategoryModel model;
  const wid({super.key, required this.model});

  Widget build(BuildContext context) {
    CartProvider controller = Get.put(CartProvider());
    bool? _isInCart = controller.getCartItems.containsKey(model.id.toString());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Material(
              elevation: 10,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(

                        // border: Border.all(color: AppColors.primaryColor),borderRadius: BorderRadius.circular(10)
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://admin.wasiljo.com/${model.imageUrl}',
                          height: 100,
                        ),
                        Text(model.title!.en!.toString()),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: _isInCart
                                ? () {
                                    controller
                                        .removeOneItem(model.id as String);
                                  }
                                : () {
                                    // if (_isInCart) {
                                    //   return;
                                    // }
                                    controller.addProductsToCart(
                                        orderId: 1,
                                        total: 2,
                                        price: 2,
                                        subCategoriesId: model.id,
                                        id: model.id!.toInt(),
                                        quantity: int.parse('2'));
                                    print(_isInCart);
                                  },
                            child: Text(
                              _isInCart ? 'In cart' : 'Add to cart',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
