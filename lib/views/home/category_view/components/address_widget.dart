import 'package:get/get.dart';
import 'package:userwasil/controller/address.dart';
import 'package:userwasil/config/custom_package.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({Key? key}) : super(key: key);

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  AddressController controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Delivering To".tr,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )),
              Row(
                children: [
                  Obx(
                    () => controller.selectedAddress.value.isEmpty &&
                            controller.listDefaultAddress.isEmpty
                        ? Text('select Address'.tr)
                        : controller.selectedAddress.value.isEmpty
                            ? Text(
                                ' ${controller.listDefaultAddress[0].type == 0 ? 'Home'.tr : controller.listDefaultAddress[0].type == 1 ? 'Work'.tr : 'Other'.tr}, ${controller.listDefaultAddress[0].buildingNumber}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Text(
                                controller.selectedAddress.value,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    initialValue: null,
                    onSelected: (selectedItem) {
                      controller.selectedAddress.value = selectedItem;
                    },
                    itemBuilder: (BuildContext context) {
                      final items = controller.listAddress.map(
                        (address) {
                          return PopupMenuItem<String>(
                            onTap: () {
                              controller.lat.value =
                                  address.latitude.toString();
                              controller.long.value =
                                  address.longitude.toString();
                              controller.street.value = address.street;
                              controller.buildingNumber.value =
                                  address.buildingNumber!;
                              controller.apartmentNum.value =
                                  address.apartmentNum.toString();
                              controller.id.value = address.id.toString();
                            },
                            value:
                                '${address.type == 0 ? 'Home'.tr : address.type == 1 ? 'Work'.tr : 'Other'.tr} ${address.buildingNumber}',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    ' ${address.type == 0 ? 'Home'.tr : address.type == 1 ? 'Work'.tr : 'Other'.tr}, ${address.buildingNumber}',
                                    style: const TextStyle(
                                        color: AppColors.secondaryColor)),
                                const Divider(
                                  color: AppColors.backgroundColor,
                                )
                              ],
                            ),
                          );
                        },
                      ).toList();

                      // Add the "Add New Address" option at the end
                      items.add(
                        PopupMenuItem<String>(
                          value: 'add_new_address'.tr,
                          child: Text('Add New Address'.tr),
                          onTap: () => UserNavigator.of(context)
                              .push(const AddAddressScreen()),
                        ),
                      );

                      return items;
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
