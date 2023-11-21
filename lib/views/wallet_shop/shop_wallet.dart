import 'package:get/get.dart';
import 'package:userwasil/views/all_subcategory_shop/all_subcategory.dart';

import 'package:userwasil/views/shops/shops_controller.dart';

import 'package:userwasil/utils/ui/shimmer_widget.dart';
import 'package:userwasil/views/shops/shop_model.dart';

import '../../config/custom_package.dart';
import '../../controller/address.dart';
import '../../core/locale/locale.controller.dart';
import '../home/category_view/components/address_widget.dart';
import '../subcategory_shop/subcategories_view.dart';

class ShopsWalletScreen extends StatefulWidget {
  final lat;
  final long;
  final id;

  const ShopsWalletScreen(
      {super.key, required this.lat, required this.long, required this.id});

  @override
  State<ShopsWalletScreen> createState() => _ShopsWalletScreenState();
}

class _ShopsWalletScreenState extends State<ShopsWalletScreen> {
  ShopsController controller = Get.put(ShopsController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      backgroundColor: AppColors.backgroundColor,
      color: AppColors.primaryColor,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        controller.fetchShops();
        print(controller.shops.length);

        return;
      },
      child: SafeArea(
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
              buildAddress(),
              Container(
                  width: 390,
                  height: 6,
                  decoration: const BoxDecoration(color: Color(0xfff2f2f2))),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                itemBuilder: (context, index) =>
                    buildShop(controller.shops[index]),
                itemCount: controller.shops.length,
                shrinkWrap: true,
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Container(
                    width: 390,
                    height: 74,
                    decoration: const BoxDecoration(color: Color(0xff15cb95))),
              )
            ]);
          }),
        ),
      ),
    );
  }


  AddressController addressController = Get.put(AddressController());
  Widget buildShop(ShopsModel shop) {
    LocaleController controller = Get.put(LocaleController());
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          color: AppColors.backgroundColor,
          child: ListTile(
            leading: SizedBox(
              width: 70,
              height: 80,
              child: Stack(children: [
                Image.network(
                  'https://admin.wasiljo.com/${shop.avatarUrl}',
                  width: 70,
                  height: 80,
                ),
                Container(
                  width: 70, // نفس حجم الصورة
                  height: 80,
                  color: shop.open == 0
                      ? Colors.black.withOpacity(0.3)
                      : Colors.transparent, // لون الغطاء مع الشفافية
                ),
                shop.open == 0
                    ? Center(
                  child: Text("closed".tr,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                )
                    : const Text('')
              ]),
            ),

            title: Text(
                controller.language!.languageCode == 'en'
                    ? shop.shopNameEn!.toString()
                    : shop.shopNameAr.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.address.toString(),
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffA6A6A6)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: AppColors.primaryColor, size: 15),
                          Text(shop.rating.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              "(${shop.totalRating.toString()}${"Ratings".tr})",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ))
                        ],
                      )
                    ]),
                shop.open == 0
                    ? Text(
                  "closed".tr,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                )
                    : const Text("")
              ],
            ),
            onTap: () {
              print(shop.id);
              print(shop.open);
              print(shop.avatarUrl);
              Get.to(
                    () => const SubCategoryByShopScreen(),
                arguments: {
                  'shopId': shop.id,
                  'logo': shop.avatarUrl,
                  'shop': shop
                },
              );
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

  Widget buildAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Delivering To".tr,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
          Row(
            children: [
              Obx(() => addressController.selectedAddress.value.isEmpty &&
                  addressController.listDefaultAddress.isEmpty
                  ? Text(' select Address'.tr)
                  : addressController.selectedAddress.value.isEmpty
                  ? Text(
                  ' ${addressController.listDefaultAddress[0].type == 0 ? 'Home'.tr : addressController.listDefaultAddress[0].type == 1 ? 'Work'.tr : 'Other'.tr}, ${addressController.listDefaultAddress[0].street}',
                  style:
                  const TextStyle(color: AppColors.secondaryColor))

              // Display selected address in the body

                  : Text(addressController.selectedAddress.value)),
              RefreshIndicator(
                onRefresh: () async {
                  print('object');
                  addressController.getMyAddresses();
                },
                child: Column(children: [
                  PopupMenuButton<String>(
                    // color: AppColors.primaryColor,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                    initialValue: null,
                    onSelected: (selectedItem) {
                      print('object');

                      addressController.selectedAddress.value = selectedItem;
                    },

                    itemBuilder: (BuildContext context) {
                      print('object');
                      addressController.getMyAddresses();
                      final items =
                      addressController.listAddress.map((address) {
                        return PopupMenuItem<String>(
                          onTap: () {
                            print(address.latitude.toString());
                            print(address.longitude.toString());

                            addressController.lat.value =
                                address.latitude.toString();
                            addressController.long.value =
                                address.longitude.toString();
                            addressController.street.value = address.street;
                            addressController.buildingNumber.value =
                            address.buildingNumber!;
                            addressController.apartmentNum.value =
                                address.apartmentNum.toString();
                            addressController.id.value = address.id.toString();

                            controller.fetchShops();
                          },
                          value:
                          '${address.type == 0 ? 'Home' : address.type == 1 ? 'Work' : 'Other'} ${address.street}',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  ' ${address.type == 0 ? 'Home' : address.type == 1 ? 'Work' : 'Other'}, ${address.street}',
                                  style: const TextStyle(
                                      color: AppColors.secondaryColor)),
                              const Divider(
                                color: AppColors.backgroundColor,
                              )
                            ],
                          ),
                        );
                      }).toList();

                      // Add the "Add New Address" option at the end
                      items.add(
                        PopupMenuItem<String>(
                          value: 'add_new_address',
                          child: Text('Add New Address'.tr),
                          onTap: () => UserNavigator.of(context)
                              .push(const AddAddressScreen()),
                        ),
                      );

                      return items;
                    },
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
