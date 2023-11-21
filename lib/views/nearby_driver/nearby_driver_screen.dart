import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/core/constant/app_constent.dart';
import 'package:userwasil/views/nearby_driver/nearby_driver_controller.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_controller.dart';

class NearbyDriverScreen extends GetView<NearbyDriverController> {
  const NearbyDriverScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          GetBuilder<NearbyDriverController>(
              init: NearbyDriverController(),
              builder: (nearbyDriverController) {
                return Obx(
                  () => Visibility(
                    visible: nearbyDriverController.showMap.value,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).width * 0.8,
                      child: GoogleMap(
                        initialCameraPosition:
                            nearbyDriverController.initialCameraPosition,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        markers: nearbyDriverController.markers,
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoaded.value,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.subcategories.length,
                  itemBuilder: (context, index) {
                    if (controller.isLoaded.value) {
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                          left: 16,
                          right: 16,
                        ),
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.backgroundColor,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    imageBaseUrl +
                                        controller
                                            .subcategories[index].imageUrl!,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Get.locale!.languageCode == 'ar'
                                        ? controller
                                            .subcategories[index].title!.ar!
                                        : controller
                                            .subcategories[index].title!.en!,
                                    style: proSecondry,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${'price'.tr}:',
                                        style: proSecondry,
                                      ),
                                      Text(
                                        controller.subcategories[index].price
                                            .toString(),
                                        style: proSecondry,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    controller.subcategories[index].description!
                                                    .en !=
                                                null &&
                                            controller.subcategories[index]
                                                    .description!.ar !=
                                                null
                                        ? Get.locale!.languageCode == 'ar'
                                            ? controller.subcategories[index]
                                                .description!.ar!
                                            : controller.subcategories[index]
                                                .description!.en!
                                        : '',
                                    style: proSecondry,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            GetBuilder<NearbyDriverController>(
                                builder: (nearbyDriverController) {
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (nearbyDriverController
                                              .subcategories[index].counter! <=
                                          0) {
                                        nearbyDriverController
                                            .subcategories[index].counter = 0;
                                        return;
                                      }
                                      subCategoriesModel.remove(
                                          nearbyDriverController
                                              .subcategories[index]);
                                      nearbyDriverController
                                          .subcategories[index]
                                          .counter = nearbyDriverController
                                              .subcategories[index].counter! -
                                          1;

                                      nearbyDriverController.update();
                                      orderType = '2';
                                    },
                                    icon: Container(
                                      height: 30,
                                      width: 30,
                                      padding:
                                          const EdgeInsets.only(bottom: 30),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.minimize,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    nearbyDriverController
                                        .subcategories[index].counter!
                                        .toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      subCategoriesModel.add(
                                          nearbyDriverController
                                              .subcategories[index]);
                                      nearbyDriverController
                                          .subcategories[index]
                                          .counter = nearbyDriverController
                                              .subcategories[index].counter! +
                                          1;
                                      nearbyDriverController.update();
                                      orderType = '2';
                                    },
                                    icon: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                          child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
