import 'dart:developer';
import 'package:userwasil/views/subcategory_shop/subcategories_controller.dart';
import 'package:get/get.dart';
import 'package:userwasil/views/checkout_order/checkout_screen.dart';
import 'package:userwasil/views/wallet_shop/wallet_by_shop_controller.dart';

import '../../../config/custom_package.dart';
import '../../core/locale/locale.controller.dart';
import 'checkout_wallet.dart';


class WalletByShopScreen extends StatelessWidget {
  const WalletByShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletShopController controller = Get.put(WalletShopController());

    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        controller.getProducts(controller.shopId);
        return;
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            if (controller.isWaiting) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                    child: Shimmer.fromColors(
                        baseColor: AppColors.borderColor,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 20.h,
                          width: 20.w,
                          color: Colors.grey,
                        )),
                  );
                },
                itemCount: 5,
              );
            }
            if (controller.isError) {
              return Center(
                child: Text(controller.statusModel.value.errorMsg!.value),
              );
            }
            return Column(children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return ProductWalletWidget(model: controller.productList[index]);
                },
                itemCount: controller.productList.length,
                shrinkWrap: true,
              ),
              const Spacer(),
              Container(
                color: AppColors.primaryColor,
                margin: const EdgeInsets.all(0),
                width: double.infinity,
                child: Row(
                  children: [
                    // Obx(() =>     Text(controller.totalCount.toStringAsFixed(2),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    // ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          elevation: 0),
                      onPressed: () {
                        if (controller.cartList.length == 0) {
                          Get.bottomSheet(Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        " Please Select Products".tr,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ])));
                        } else {
                          print('controller.gett');
                         // controller.gett();

                          UserNavigator.of(context).push(CheckoutWalletScreen());
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            'Complete Order'.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
class ProductWalletWidget extends StatefulWidget {
  final model;

  const ProductWalletWidget({super.key, required this.model});

  @override
  State<ProductWalletWidget> createState() => _ProductWalletWidgetState();
}

class _ProductWalletWidgetState extends State<ProductWalletWidget> {
  @override
  Widget build(BuildContext context) {
    LocaleController localecontroller = Get.put(LocaleController());
    WalletShopController controller = Get.put(WalletShopController());



    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          color: AppColors.backgroundColor,
          child: ListTile(
            leading: Image.network(
                'https://admin.wasiljo.com/${widget.model.imageUrl}'),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          localecontroller.language!.languageCode == 'en'
                              ? widget.model.title!.en as String
                              : widget.model.title!.ar as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      Text(
                          localecontroller.language!.languageCode == 'en'
                              ? widget.model.description!.en as String
                              : widget.model.description!.ar as String,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      Row(
                        children: [
                          Text(
                              widget.model.counter == 0
                                  ? '${widget.model.price}JD'.toString()
                                  : '${(widget.model.price! * widget.model.counter!).toStringAsFixed(3)}JD',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ]),
                // Material(
                //   elevation: 5,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: AppColors.backgroundColor,
                //         borderRadius: BorderRadius.circular(15)),
                //     height: 30,
                //     child: Row(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             setState(() {
                //               widget.model.counter =
                //               (widget.model.counter! + 1);
                //               subCategoriesController.getTotalPriceInCart2();
                //             });
                //           },
                //           child: const Icon(Icons.add,
                //               color: AppColors.primaryColor),
                //         ),
                //         const SizedBox(
                //           width: 9,
                //         ),
                //         Text('${widget.model.counter}'),
                //         const SizedBox(
                //           width: 9,
                //         ),
                //         InkWell(
                //           onTap: () {
                //             subCategoriesController.updateCounter(
                //                 widget.model.id, widget.model.counter);
                //             subCategoriesController.getTotalPriceInCart2();
                //             setState(
                //                   () {
                //                 if (widget.model.counter! - 1 > 0) {
                //                   widget.model.counter =
                //                   (widget.model.counter! - 1);
                //                   log('lll');
                //                   subCategoriesController.updateCounter(
                //                       widget.model.id, widget.model.counter);
                //                   subCategoriesController
                //                       .getTotalPriceInCart2();
                //                   log(subCategoriesController
                //                       .getTotalPriceInCart2()
                //                       .toString());
                //                 } else {
                //                   log('lll');
                //                   widget.model.counter =
                //                   (widget.model.counter! - 1);
                //                   subCategoriesController.updateCounter(
                //                       widget.model.id, widget.model.counter);
                //                   subCategoriesController
                //                       .getTotalPriceInCart2();
                //                   log(subCategoriesController
                //                       .getTotalPriceInCart2()
                //                       .toString());
                //                   if (controller.cartList.isEmpty) {
                //                     Get.to(
                //                             () => const SubCategoryByShopScreen());
                //                   }
                //                 }
                //               },
                //             );
                //           },
                //           child: const Icon(Icons.remove,
                //               color: AppColors.primaryColor),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),

                    onPressed: () {
                      // subCategoriesModel.add(widget.model,);
                      orderType='3';

                      controller.getCart(widget.model);
                      // if (controller.cartList.contains(widget.model.id)) {
                      // setState(() {
                      //   controller.cartList.removeAt(widget.model);
                      // });
                      // log('remove');
                      // } else {
                      // setState(() {
                      //   controller.cartList.add(widget.model);
                      // });
                      // log('add');
                      // log(controller.cartList.length.toString());
                      //
                      // }

                    }, child:
                Obx(() => Text(controller.cartList.where((item) => item.id == widget.model.id).isEmpty?'Add':'Added'))
                )     ],
            ),
          ),
        ),
        const Divider(
          color: AppColors.borderColor,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}