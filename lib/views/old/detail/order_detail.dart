import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:userwasil/utils/ui/common_views.dart';





class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: CommonViews().getAppBar(title: 'Buy Coupons Book'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 20,),
          Container(
            width: 342,
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffD6D6D6)),
              borderRadius: BorderRadius.circular(10),

            ),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children: [
              Image.asset('assets/images/Rectangle 1809.png'),
              const Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:MainAxisAlignment.center ,
                children: [


                  Text(
                      "Qwarercomm",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  Text(
                      "Al-Rabyeh",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color:Color(0xffA6A6A6)
                      )
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,color: Color(0xff15CB95)),
                      SizedBox(width: 2,),
                      Text('4.2'),
                      SizedBox(width: 2,),
                      Text('(100+ rate)',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color:Color(0xffA6A6A6)
                          ))
                    ],
                  )

                ],
              ),
            ],

            ),
          ),
          const SizedBox(height: 50,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Cost ',style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        )),
                        Icon(size: 14,Icons.monetization_on_outlined,color:Color(0xffA6A6A6),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text('25 JOd',
                      style: TextStyle(
                        color:Color(0xffA6A6A6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline
                      ),
                    ),
                 SizedBox(height: 10,),

                 Divider(height: 20, color:Color(0xffA6A6A6),),

                  ],
                ),
              ),
              const SizedBox(width: 50,),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Cost ',style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        )),
                        Icon(size: 14,Icons.monetization_on_outlined,color:Color(0xffA6A6A6),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text('25 JOd',
                      style: TextStyle(
                        color:Color(0xffA6A6A6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline
                      ),
                    ),
                 SizedBox(height: 10,),

                 Divider(height: 20, color:Color(0xffA6A6A6),),

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date ',style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        )),
                        Icon(size: 14,Icons.date_range,color:Color(0xffA6A6A6),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Text('29 Apr 2023',
                          style: TextStyle(
                              color:Color(0xffA6A6A6),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,

                          ),
                        ),
                        Icon(
                          MdiIcons.chevronDown,
                          color:const Color(0xff15CB95),


                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    Divider(height: 20, color:Color(0xffA6A6A6),),

                  ],
                ),
              ),
              const SizedBox(width: 50,),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Time ',style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        )),
                        Icon(size: 14,Icons.timelapse_rounded,color:Color(0xffA6A6A6),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Text('9.00 am-11 .00 am',
                          style: TextStyle(
                            color:Color(0xffA6A6A6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,

                          ),
                        ),
                        Icon(
                          MdiIcons.chevronDown,
                          color:const Color(0xff15CB95),


                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Divider(height: 20, color:Color(0xffA6A6A6),),

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
           Expanded(
             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Location ',style: TextStyle(
                       fontSize: 12,
                       fontWeight: FontWeight.w700,
                     )),
                     Icon(size: 14,MdiIcons.mapMarkerOutline,color:Color(0xffA6A6A6),)
                   ],
                 ),
                 const SizedBox(height: 10,),
                 Row(
                   children: [
                     Text('Home (Zaghlool St. , Amman , “26” Building , 2nd..',
                       style: TextStyle(
                           color:Color(0xffA6A6A6),
                           fontSize: 14,
                           fontWeight: FontWeight.w400,

                       ),
                     ),
                     Icon(
                       MdiIcons.chevronDown,
                       color:const Color(0xff15CB95),


                       size: 20,
                     ),

                   ],
                 ),
                 SizedBox(height: 10,),

                 Divider(height: 20, color:Color(0xffA6A6A6),),

               ],
             ),
           ),
          const SizedBox(height: 20,),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment ',style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )),
                    Icon(size: 14,MdiIcons.cardAccountDetails,color:Color(0xffA6A6A6),)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Select Payment Method',
                      style: TextStyle(
                        color:Color(0xffA6A6A6),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                    Icon(
                      MdiIcons.chevronDown,
                      color:const Color(0xff15CB95),


                      size: 20,
                    ),

                  ],
                ),
                SizedBox(height: 10,),

                Divider(height: 20, color:Color(0xffA6A6A6),),

              ],
            ),
          ),
          ElevatedButton(

            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
                minimumSize:
                MaterialStatePropertyAll(Size(341, 50))),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const CheckoutSctrrn()));
              },
            child: const Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(

            style: const ButtonStyle(

              backgroundColor: MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  side: BorderSide(    color: Color(0xff15CB95),),
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
                minimumSize:
                MaterialStatePropertyAll(Size(341, 50))),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const ServicesScreen()));
              },
            child: const Text(
                "Add Item",
                style: TextStyle(
                  color: Color(0xff15CB95),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    ));
  }
}
