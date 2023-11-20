import 'dart:developer';
import 'package:get/get.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/controller/address.dart';
import 'package:userwasil/views/category/category_model.dart';
import 'package:userwasil/views/driver/driver_binding.dart';
import 'package:userwasil/core/locale/locale.controller.dart';
import 'package:userwasil/utils/ui/shimmer_widget.dart';
import 'package:userwasil/views/driver/drivers_screen.dart';
import 'package:userwasil/views/nearby_driver/nearby_driver_controller.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_controller.dart';
import 'category_controller.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    CategoryController controllerCategory = Get.put(CategoryController());
    return FutureBuilder<List<CategoriesModel>>(
      future: controllerCategory.fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("You have not any Category yet ${snapshot.error}");
        }
        if (!snapshot.hasData) {
          return BuildShimmer(context);
        } else {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildCategory(snapshot.data![index]),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
            ),
          );
        }
      },
    );
  }

  buildCategory(CategoriesModel category) {
    LocaleController controller = Get.put(LocaleController());
    AddressController controllerAddress = Get.put(AddressController());
    return InkWell(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('categoryId', category.id!);

        if (controllerAddress.street.isEmpty &&
            controllerAddress.listDefaultAddress.isEmpty) {
          Get.snackbar(
            'Please select address'.tr,
            '',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: AppColors.primaryColor,
            icon: const Icon(Icons.add_alert),
          );
          log('select address');
        } else {
          if (category.id == 1) {
            Get.to(
              ShopsScreen(
                id: category.id,
                lat: controllerAddress.lat,
                long: controllerAddress.long,
              ),
            );
            return;
          }

          Get.lazyPut<NearbyDriverController>(() => NearbyDriverController());
          Get.lazyPut<SubCategoriesController>(() => SubCategoriesController());
          Get.to(
            () => const DriversScreen(),
            binding: DriverBinding(
              id: category.id!,
              latitude: controllerAddress.lat,
              longitude: controllerAddress.long,
            ),
          );
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
                'https://news.wasiljo.com/${category.imageUrl}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                controller.language!.languageCode == 'en'
                    ? '${category.title!.en}'
                    : '${category.title!.ar}',
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          )),
    );
  }
}
