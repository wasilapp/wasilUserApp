import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:userwasil/views/home_screen/home_screen.dart';

import '../review/review.dart';

class DeliverdScreen extends StatefulWidget {
  const DeliverdScreen({super.key});

  @override
  State<DeliverdScreen> createState() => _DeliverdScreenState();
}

class _DeliverdScreenState extends State<DeliverdScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:Center(
       child: Column(

         children: [
           Container(
             margin: EdgeInsets.only(top:100),
             width: 170,
             height: 170,
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(90),
             color: Color(0xff32CD70)),
             child: Icon(Icons.check,size: 90,)
           ),
           SizedBox(height: 30,),
           Text(
               "DELEVIRED",
               style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.w400,
               )
           ),
           SizedBox(height: 20,),
           Align(
     alignment: Alignment.center,
             child: Text(
               textAlign: TextAlign.center,
                 "You have successfully Received \nYour Gas Cylinders",
                 style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.w400,
                 )
             ),
           ),
           SizedBox(height: 80,),
           ElevatedButton(

             style: const ButtonStyle(
                 shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)))),
                 minimumSize:
                 MaterialStatePropertyAll(Size(254, 50))),
             onPressed: () {Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => const Rate()));},
             child: Text(
                 "Continue",
                 style: const TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                 )
             ),
           ),
           SizedBox(height: 10,),
           ElevatedButton(

             style: const ButtonStyle(

                 backgroundColor: MaterialStatePropertyAll(Colors.white),
                 shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                     side: BorderSide(    color: Color(0xff15CB95),),
                     borderRadius: BorderRadius.all(Radius.circular(10)))),
                 minimumSize:
                 MaterialStatePropertyAll(Size(254, 50))),
             onPressed: () {Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => const HomeScreen()));},
             child: Text(
                 "Home",
                 style: const TextStyle(
                   color: Color(0xff15CB95),
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                 )
             ),
           ),
           SizedBox(height: 10,),
         ],
       ),
      ),
    ));
  }
}
