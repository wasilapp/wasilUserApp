import 'package:get/get.dart';
import 'package:userwasil/utils/ui/product_widget.dart';
import 'package:userwasil/views/checkout_order/checkout_screen.dart';

import '../../../config/custom_package.dart';
import '../nearset_order_main_subcategory/checkout_view.dart';
import '../nearset_order_main_subcategory/main_sub_controller.dart';

class SubCategoryByDriverScreen extends StatelessWidget {
  const SubCategoryByDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainSubcategoryController controller = Get.put(MainSubcategoryController());

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        controller.getMainSubcategory();
        return;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
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
                  return ProductWidget(
                      model: controller.mainSubcategoryList[index]);
                },
                itemCount: controller.mainSubcategoryList.length,
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

                          controller.gett();
                          // UserNavigator.of(context).push(CheckoutScreenDriver());
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
