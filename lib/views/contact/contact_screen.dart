
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userwasil/views/voucher/voucher_screen.dart';
import 'package:userwasil/views/wallet/wallet_screen.dart';

import '../../config/ColorUtils.dart';
import '../../core/constant/colors.dart';


import '../../services/AppLocalizations.dart';
import '../../services/general_services.dart';

import '../../config/font.dart';
import '../../utils/helper/navigator.dart';
import '../../widget/select_lang.dart';
import '../old/OrderScreen.dart';
import '../auth/signIn/signin_screen.dart';

class Contact extends StatefulWidget {
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
    String? name='';
  String? email='';
  String? avatar='';


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,


          appBar: AppBar(            iconTheme: IconThemeData(color: Colors.black),elevation: 0,
            // title: Text('checkOut'.tr,style: TextStyle(color:Color(0xff373636),fontSize: 18,
            // fontWeight: FontWeight.w400,)),
            backgroundColor: AppColors.backgroundColor,),
          body: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      children: [
                         Column(
                           children: [
                             InkWell(
                              onTap: () {
                                callNumber("+962779233733");
                              },
                               child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                 Icon(  Icons.call ,color: ColorUtils.fromHex('15cb95'),size:35,),
                                 const SizedBox(width: 10),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                   Translator.translate("mobile_number"),            
                                       textAlign: TextAlign.center,
                                         style: TextStyle(
                                             fontSize: 16,
                                         fontWeight: FontWeight.bold,
                                             color: Colors.black),
                                       ),
                                      const SizedBox(height: 10),
                                        Text(
                                    "+962779233733",
                                       textAlign: TextAlign.center,
                                         style: TextStyle(
                                             fontSize: 13,
                                         
                                             color: Colors.black),
                                       ),
                                
                                   ],
                                 ),
                                ],),
                             ),
                              Divider(),
                               InkWell(
                                onTap: ()
      // Function to launch an email
   async {
      _launchEmail('mailto:sally42@gmail.com');
          print('Error launching email');



                                },
                                 child: Row(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                 Icon(  Icons.email ,color: Colors.greenAccent,size:35,),
                                 const SizedBox(width: 10),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                   Translator.translate("email"),            
                                       textAlign: TextAlign.center,
                                         style: TextStyle(
                                             fontSize: 16,
                                         fontWeight: FontWeight.bold,
                                             color: Colors.black),
                                       ),
                                      const SizedBox(height: 10),
                                        Text(
                                    "Info@wasiljo.com",            
                                       textAlign: TextAlign.center,
                                         style: TextStyle(
                                             fontSize: 13,
                                         
                                             color: Colors.black),
                                       ),
                                                             
                                   ],
                                 ),
                                                             ],),
                               ),
                           ],
                         ),
                      ]
                  )
              ),
                        Positioned(
            bottom: 0,
            child: Container(width: MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height*0.08 ,color: Color(0xff15cb95),))
            ],
          )
      ),
    );
  }
    Future<void> _launchEmail(String email) async {
      if (await canLaunch(email)) {
        await launch(email);
      } else {
        // Handle error
        print('Error launching email');
      }
    }
}
