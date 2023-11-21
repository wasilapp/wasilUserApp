import 'package:get/get.dart';
import 'package:userwasil/views/checkout_order/checkout_screen.dart';
import 'package:userwasil/views/driver/driver_controller.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/views/nearby_driver/nearby_driver_controller.dart';
import 'package:userwasil/views/nearby_driver/nearby_driver_screen.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/driver_store_details.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_controller.dart';
import 'driver_model.dart';

class DriversScreen extends GetView<DriverController> {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: InkWell(
            onTap: () {
              bool data = Get.find<NearbyDriverController>()
                  .subcategories
                  .any((element) => element.counter! > 0);
              if (!data) {
                Get.snackbar(
                  'warning'.tr,
                  'please_add_item'.tr,
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  icon: const Icon(
                    Icons.warning,
                    color: Colors.white,
                  ),
                );
                return;
              }
              orderType = '2';
              Get.to(() => const CheckoutScreen());
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xff15cb95),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'checkout'.tr,
                  style: greybasic.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          bottom: TabBar(
            labelColor: AppColors.primaryColor,
            indicatorColor: AppColors.primaryColor,
            tabs: <Widget>[
              Tab(
                icon: Text('nearby'.tr),
              ),
              Tab(
                icon: Text('choose_driver'.tr),
              ),
            ],
          ),
        ),
        body: Obx(
          () {
            if (controller.isWaiting) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 160,
                          width: 100.w,
                          color: Colors.grey,
                        )),
                  );
                },
                itemCount: 10,
              );
            }
            if (controller.isError) {
              return Center(
                child: Text(controller.statusModel.value.errorMsg!.value),
              );
            }
            return const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                NearbyDriverScreen(),
                ChooseDriver(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ChooseDriver extends GetView<DriverController> {
  const ChooseDriver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isWaiting) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    height: 160,
                    width: 100.w,
                    color: Colors.grey,
                  ),
                ),
              );
            },
            itemCount: 10,
          );
        }
        if (controller.isError) {
          return Center(
            child: Text(controller.statusModel.value.errorMsg!.value),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) =>
              buildDriver(controller.driverList[index]),
          itemCount: controller.driverList.length,
          shrinkWrap: true,
        );
      },
    );
  }

  buildDriver(DeliveryBoy driver) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Image.network(
              'https://admin.wasiljo.com/${driver.avatarUrl}',
              width: 70,
              height: 80,
            ),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.name!.en.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.primaryColor,
                        size: 15,
                      ),
                      Text(
                        driver.rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("(${driver.totalRating.toString()}${"Ratings".tr})",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  )
                ]),
            onTap: () {
              Get.lazyPut(() => NearbyDriverController());
              bool index =
                  Get.find<NearbyDriverController>().driverId.isNotEmpty;
              if (index) {
                Get.find<NearbyDriverController>().driverId.clear();
              }
              Get.find<NearbyDriverController>()
                  .driverId
                  .add(driver.id!.toString());
              Get.to(() => const DriverStoreDetails());
            },
          ),
        ),
        const Divider(
          color: AppColors.borderColor,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
