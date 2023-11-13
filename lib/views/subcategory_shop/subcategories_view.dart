import 'package:get/get.dart';
import 'package:userwasil/utils/ui/product_widget.dart';
import 'package:userwasil/views/checkout_order/checkout_screen.dart';

import '../../../config/custom_package.dart';
import '../wallet_shop/wallet_by_shop_controller.dart';
import 'subcategories_controller.dart';
import 'subcategories_model.dart';

class SubCategoryByShopScreen extends StatelessWidget {
  const SubCategoryByShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SubCategoriesController controller = Get.put(SubCategoriesController());
    WalletShopController controllerWallet = Get.put(WalletShopController());    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
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
          appBar:  AppBar(            iconTheme: IconThemeData(color: Colors.black),elevation: 0,
            // title: Text("Update Profile".tr,style: TextStyle(color:Color(0xff373636),fontSize: 18,
            //   fontWeight: FontWeight.w400,)),
            backgroundColor: AppColors.backgroundColor,),
          body:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() {
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
                      return ProductWidget(model: controller.productList[index]);
                    },
                    itemCount: controller.productList.length,
                    shrinkWrap: true,
                  ),

                ]);
              }),
              Obx(() {
                if (controllerWallet.isWaiting) {
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
                if (controllerWallet.isError) {
                  return Center(
                    child: Text(controllerWallet.statusModel.value.errorMsg!.value),
                  );
                }
                return Column(children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return ProductWidget(model: controllerWallet.productList[index]);
                    },
                    itemCount: controllerWallet.productList.length,
                    shrinkWrap: true,
                  ),

                ]);
              }),
              const Spacer(),
              CommonViews().createButton(title: 'checkOut', onPressed: () {

               Get.to(CheckoutScreen());
              },),
SizedBox(height: 1.h,)
            ],
          ),
        ),
      ),
    );
  }
}
