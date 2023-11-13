import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/controller/address.dart';
import 'package:userwasil/utils/helper/shared_pref.dart';

import '../../../core/constant/colors.dart';
import '../../../utils/helper/size.dart';






class AllAddressScreen extends StatefulWidget {
  @override
  _AllAddressScreenState createState() => _AllAddressScreenState();
}

class _AllAddressScreenState extends State<AllAddressScreen> {
TextEditingController name=TextEditingController();

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    AddressController controller =Get.put(AddressController());
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
          title: const Text('Saved Address',style: TextStyle(color: Color(0xff373636),fontWeight: FontWeight.w400,fontSize: 18)),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: 1,
          itemBuilder: (context, index) {

            return
              Obx(()=> Column(
                  children:     controller.listAddress.map((address) =>


                  ListTile(
                    trailing:    Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: ()

                          async {
                            print(address.id.toString());
                            showDialog(

                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.backgroundColor,
                                  title: const Text('Delete Address'),
                                  content: Text('Are you sure you want to delete the address: ${address.street}?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        // Perform the delete operation here
                                     controller.deleteAddress(address.id);
                                        setState(() {
                                          controller.listAddress.removeAt(index);
                                        });
                                        Get.back();
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );

                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                        SizedBox(width: 10,)
                        ,               Switch(value: true,
                          focusColor: AppColors.backgroundColor,

          activeColor: AppColors.primaryColor,
                        onChanged: (value) {

                        },),
                      ],
                    ),
                    leading:    const Icon(Icons.location_on_outlined),
                    subtitle:
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(address.type==0?'Home'.tr:address.type==1?'Work'.tr:'Other'.tr,
                                    style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),

                                // Text('(${address.street})'),
                                  Text(address.street.toString(),   style: const TextStyle(color: Color(0xffA6A6A6),fontWeight: FontWeight.w600,fontSize: 14)),



                                                   ],

                                                 ),
                         ),


                ).toList()
              ));
          },
        ),
      )
    ;
  }
 }
