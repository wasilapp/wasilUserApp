import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:userwasil/utils/ui/common_views.dart';
import 'package:userwasil/views/deliverd/deliverd_screen.dart';

import '../../utils/ui/user_text.dart';

class CheckoutSctrrn extends StatefulWidget {
  const CheckoutSctrrn({super.key});

  @override
  State<CheckoutSctrrn> createState() => _CheckoutSctrrnState();
}

class _CheckoutSctrrnState extends State<CheckoutSctrrn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: CommonViews().getAppBar(title: 'CheckOut'),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/Rectangle 303.png'),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(size: 20,MdiIcons.mapMarkerOutline,color:Color(0xffA6A6A6),),
                    Text(
                        "Home (Al- Rabyeh)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  textAlign: TextAlign.start,
                    "Zaghlool St., Al-Rabyeh, “26” Building, 2, 1",
                    style: TextStyle(

                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:Color(0xffA6A6A6)
                    )
                ),
                SizedBox(height: 10,),
                Text(
                    "Mobile: +962 797648792",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                        color:Color(0xffA6A6A6)
                    )
                ),
                Divider( color:Color(0xffA6A6A6),thickness: 2,),

              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height:  MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Image.asset('assets/images/bottel.png'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserText(
                              title: 'bottel',
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            UserText(
                              title: ' Price : 1.00Jo',
                            ),
                            UserText(
                              title: ' Amount : 1',
                            ),
                          ],
                        ),
                        const Spacer(),


                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height:  MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Image.asset('assets/images/bottel.png'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserText(
                              title: 'bottel',
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            UserText(
                              title: ' Price : 1.00Jo',
                            ),
                            UserText(
                              title: ' Amount : 2',
                            ),
                          ],
                        ),
                        const Spacer(),


                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price :',style: (
                    TextStyle(
                      color: Colors.red,fontWeight: FontWeight.bold
                    )
                    ),),
                    Text('3.00 jod ',style: (
                        TextStyle(
                            color: Colors.red,fontWeight: FontWeight.bold
                        )
                    ),),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment Method:',style: (
                        TextStyle(
                            color: Colors.red,fontWeight: FontWeight.bold
                        )
                    ),),
                    Text('Cash ',style: (
                        TextStyle(
                            color: Colors.red,fontWeight: FontWeight.bold
                        )
                    ),),
                  ],
                ),
                SizedBox(height: 20,),
                ElevatedButton(

                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      minimumSize:
                      MaterialStatePropertyAll(Size(341, 50))),
                  onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeliverdScreen()));},
                  child: Text(
                      "Complete Order",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10,)
        ],
      ),
    ));
  }
}
