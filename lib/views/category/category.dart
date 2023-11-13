import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/controller/address.dart';
import 'package:userwasil/views/category/category_model.dart';
import '../../core/locale/locale.controller.dart';
import '../../utils/helper/navigator.dart';
import '../../utils/ui/shimmer_widget.dart';
import '../driver/drivers_screen.dart';
import '../driver/sub_category_gas.dart';
import '../favourite/favourite_screen.dart';
import '../nearset_order_main_subcategory/main_subcategory_view.dart';
import '../nearset_order_main_subcategory/ss.dart';
import 'category_controller.dart';
import '../home/category_view/components/address_widget.dart';


class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {



  @override
  Widget build(BuildContext context) {

    CategoryController controllerCategory = Get.put(CategoryController());
    return     FutureBuilder<List<CategoriesModel>>(
      future: controllerCategory.fetchCategories(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return  Text("You have not any Category yet ${snapshot.error}");
        }
        if (!snapshot.hasData) {
          return BuildShimmer(context);
        } else {
          return
            SizedBox(height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>  buildCategory(snapshot.data![index]),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,),
            );

        }
      },
    );

  }
  buildCategory(CategoriesModel category){
    LocaleController controller = Get.put(LocaleController());
    AddressController controllerAddress = Get.put(AddressController());
    return InkWell(
      onTap: () async {
print(category.id,);
SharedPreferences prefs=await SharedPreferences.getInstance();
prefs.setInt('categoryId', category.id!);
// print(category.schedulerFees);
// // prefs.setDouble('deliveryFee', category.deliveryFee!);
// prefs.setDouble('schedulerFees',  category.schedulerFees!.toDouble());
// prefs.setDouble('commesion', category.commesion!.toDouble());
// prefs.setDouble('expeditedFees', category.expeditedFees!..toDouble());


if(controllerAddress.street.isEmpty && controllerAddress.listDefaultAddress.isEmpty){
  Get.snackbar(
    'Please select address',
   '',
    snackPosition: SnackPosition.TOP,
    colorText: Colors.white,
    backgroundColor: AppColors.primaryColor,
    icon: const Icon(Icons.add_alert),
  );
  log('select address');
}
else{

  print('**************');
  print(controllerAddress.listDefaultAddress.isNotEmpty);
  print(controllerAddress.id);
  print(controllerAddress.long);
  category.id==1? Get.to( ShopsScreen(id:category.id,lat:controllerAddress.lat

    ,long:controllerAddress.long,)):

Get.to(DDD());

}

      },
      child: Container(
          width: 150,
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 10),
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
          padding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          // color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              Image.network(
                'https://news.wasiljo.com/${category.imageUrl}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10,),
              Text(
                controller.language=='en'? '${category.title!.en}':'${category.title!.ar}',
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          )),
    );
  }
}
