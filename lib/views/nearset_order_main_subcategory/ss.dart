import 'dart:developer';

import 'package:get/get.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/gas_con.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/main_sub_model.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/product_eidget.dart';

import '../../config/custom_package.dart';
import '../../controller/address.dart';
import '../../core/locale/locale.controller.dart';
import '../../utils/ui/product_widget.dart';
import '../checkout_order/checkout_screen.dart';
import '../home/category_view/components/address_widget.dart';
import 'checkout_view.dart';

class DDD extends StatelessWidget {
  const DDD({super.key});

  @override
  Widget build(BuildContext context) {
    MainCategoriesController controller = Get.put(MainCategoriesController());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black), elevation: 0,
        // title: Text("Update Profile".tr,style: TextStyle(color:Color(0xff373636),fontSize: 18,
        //   fontWeight: FontWeight.w400,)),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Obx(() {
        if (controller.isWaiting) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
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
        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AddressWidget(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Product(
                  model: controller.productList[index],
                  index: index,
                ),
                itemCount: controller.productList.length,
                shrinkWrap: true,
              ),
              const Spacer(),
              CommonViews().createButton(
                title: 'checkOut',
                onPressed: () {
                  Get.to(const CheckoutScreenDriver());
                },
              ),
            ]);
      }),
    ));
  }

  buildMainCategory(MainSubcategoryModel category) {
    LocaleController controller = Get.put(LocaleController());
    AddressController controllerAddress = Get.put(AddressController());
    return InkWell(
      onTap: () async {
        print(
          category.id,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('categoryId', category.id!);
// print(category.schedulerFees);
// // prefs.setDouble('deliveryFee', category.deliveryFee!);
// prefs.setDouble('schedulerFees',  category.schedulerFees!.toDouble());
// prefs.setDouble('commesion', category.commesion!.toDouble());
// prefs.setDouble('expeditedFees', category.expeditedFees!..toDouble());

        if (controllerAddress.street.isEmpty &&
            controllerAddress.listDefaultAddress.isEmpty) {
          Get.snackbar(
            'Please select address',
            '',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: AppColors.primaryColor,
            icon: const Icon(Icons.add_alert),
          );
          log('select address');
        } else {
          category.id == 1
              ? Get.to(ShopsScreen(
                  id: category.id,
                  lat: controllerAddress.lat,
                  long: controllerAddress.long,
                ))
              : Get.to(const DDD());
        }
      },
      child: Container(
          width: 150,
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          // color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.network(
                'https://admin.wasiljo.com/${category.imageUrl}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                controller.language == 'en'
                    ? '${category.title!.en}'
                    : '${category.title!.ar}',
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          )),
    );
  }
}
