import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:userwasil/views/driver/driver_controller.dart';
import 'package:userwasil/views/driver/sub_category_gas.dart';


import '../../config/custom_package.dart';
import 'package:http/http.dart' as http;

import '../../controller/address.dart';
import '../home/category_view/components/address_widget.dart';
import '../nearset_order_main_subcategory/main_subcategory_view.dart';
import '../nearset_order_main_subcategory/ss.dart';
import '../subcategory_shop/subcategories_view.dart';
import 'driver_model.dart';
class DriversScreen extends StatefulWidget {
  final lat;
  final long;
  final id;

  const DriversScreen({super.key, required this.lat,required this.long,required this.id});


  @override
  State<DriversScreen> createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {



  @override
  Widget build(BuildContext context) {
    DriverController controller = Get.put(DriverController(id:widget.id,latitude:widget.lat,longitude:widget.long));
    AddressController controllerAddress=Get.put(AddressController());
    print(widget.id);
    print('hhhhhhhhhhhhhh');
    print(widget.lat);
    print(widget.long);
    return SafeArea(
      child: Scaffold(
          appBar:  AppBar(            iconTheme: IconThemeData(color: Colors.black),elevation: 0,
            // title: Text("Update Profile".tr,style: TextStyle(color:Color(0xff373636),fontSize: 18,
            //   fontWeight: FontWeight.w400,)),
            backgroundColor: AppColors.backgroundColor,),
      body:

        Obx(() {
          if (controller.isWaiting) {
            return ListView.builder(shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            return Center(child: Text(controller.statusModel.value.errorMsg!.value),);
          }
          return Column(children: [
            AddressWidget(),
            Container(
                width: 390,
                height: 6,
                decoration: BoxDecoration(
                    color: Color(0xfff2f2f2))
            ),
            SizedBox(height: 15,),
            ListView.builder(
            itemBuilder: (context, index) {
              return buildDriver(controller.driverList[index]);
            },
            itemCount: controller.driverList.length,
            shrinkWrap: true,
          ),
            const Spacer(),
            InkWell(
              onTap: () {
                FirestoreServices().test();
              },
              child: Container(
                  width: 390,
                  height: 74,
                  decoration: const BoxDecoration(
                      color: Color(0xff15cb95))
              ),
            )
          ]);
        })),
    );
  }


buildDriver(DeliveryBoy driver){
    return       Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),


          child: ListTile(
            leading:
            Image.network('https://news.wasiljo.com/${driver.avatarUrl}',width: 70,
              height: 80,),

            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      driver.name!.en.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )
                  ),

                  Row(children: [
                    const Icon(
                        Icons.star, color: AppColors.primaryColor,
                        size: 15),
                    Text(
                        driver.rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                    const SizedBox(width: 10,),
                    Text(
                        "(${ driver.totalRating
                            .toString()} Ratings)",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )
                    )
                  ],)
                ]),
            onTap: () {
              print(driver.id);
              Get.to(DDD());
            },
          ),
        ),
        const Divider(color: AppColors.borderColor,),
        const SizedBox(height: 10,)
      ],
    );
}
}
