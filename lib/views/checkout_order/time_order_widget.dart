import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/constant/colors.dart';



class HourSelectionList extends StatefulWidget {
  static String startHour ='10:00am'.tr;
  static String endHour = '11:00am'.tr;
  @override
  _HourSelectionListState createState() => _HourSelectionListState();
}

class _HourSelectionListState extends State<HourSelectionList> {



  @override
  Widget build(BuildContext context) {


    return

      Column(

        children: <Widget>[

          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 150,
                child: DropdownButtonFormField<String>(focusColor: Colors.white,dropdownColor: Colors.white,
                  decoration:  InputDecoration(filled: true,fillColor: Colors.white,enabledBorder: OutlineInputBorder(
                      borderRadius:BorderRadius.all(Radius.circular(10)),
                      borderSide:BorderSide(color: AppColors.borderColor,width: 2)
                  ),
                 enabled: true,focusedBorder: OutlineInputBorder( borderRadius:BorderRadius.all(Radius.circular(10)),
                          borderSide:BorderSide(color: AppColors.borderColor,width: 2)),
                 border: OutlineInputBorder(
                     borderRadius:BorderRadius.all(Radius.circular(10)),
                     borderSide:BorderSide(color: AppColors.borderColor,width: 2)),
                    hintText: 'from'.tr,labelText: 'From Hour'.tr
                  ),
                  value: HourSelectionList.startHour,
                  items:   [
                    '10:00am'.tr,
                    '11:00 am'.tr,
                    '12:00 am'.tr,
                    '1:00 pm'.tr,
                    '2:00 pm'.tr,
                    '3:00 pm'.tr,
                    '4:00 pm'.tr,
                    '5:00 pm'.tr,
                    '6:00 pm'.tr,
                    '7:00 pm'.tr,
                    '8:00 pm'.tr,
                   ].map((String from) {
                    return DropdownMenuItem<String>(
                      value: from,
                      child: Text(from.tr),
                    );
                  }).toList(),
                  onChanged: ( value) {
                    // if (value! > currentHour) {
                    setState(() {
                      HourSelectionList.startHour = value!;
                    });


                    },
                    //   } else {
                    //     setState(() {
                    //       errorStartHourMessage = 'Please select a future hour.';
                    //     });
                    //   }
                    // },

              )),
                SizedBox(width: 150,
                child: DropdownButtonFormField<String>(focusColor: Colors.white,dropdownColor: Colors.white,
                  decoration: const InputDecoration(filled: true,fillColor: Colors.white,enabledBorder: OutlineInputBorder(
                      borderRadius:BorderRadius.all(Radius.circular(10)),
                      borderSide:BorderSide(color: AppColors.borderColor,width: 2)
                  ),
                 enabled: true,focusedBorder: OutlineInputBorder( borderRadius:BorderRadius.all(Radius.circular(10)),
                          borderSide:BorderSide(color: AppColors.borderColor,width: 2)),
                 border: OutlineInputBorder(
                     borderRadius:BorderRadius.all(Radius.circular(10)),
                     borderSide:BorderSide(color: AppColors.borderColor,width: 2)),
                    hintText: 'to',labelText: 'to Hour'
                  ),
                  value:  HourSelectionList.endHour,

                  items:   [
                    '10:00 am'.tr,
                    '11:00am'.tr,
                    '12:00 am'.tr,
                    '1:00 pm'.tr,
                    '2:00 pm'.tr,
                    '3:00 pm'.tr,
                    '4:00 pm'.tr,
                    '5:00 pm'.tr,
                    '6:00 pm'.tr,
                    '7:00 pm'.tr,
                    '8:00 pm'.tr,
                  ].map((String payment) {
                    return DropdownMenuItem<String>(
                      value: payment,
                      child: Text(payment.tr),
                    );
                  }).toList(),
                  onChanged: ( value) {
                      setState(() {
                        HourSelectionList.endHour = value!;

                      });

                  },
                ),
              ),
            ],
          ),


        ],
      );

  }
}