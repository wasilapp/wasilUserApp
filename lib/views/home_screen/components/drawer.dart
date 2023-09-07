import 'package:flutter/material.dart';
import 'package:userwasil/utils/ui/user_text.dart';

import '../../../setting.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';

import '../../../services/AppLocalizations.dart';
import '../../../utils/helper/navigator.dart';
import '../../../widget/select_lang.dart';
import '../../detail/order_detail.dart';
import '../../signin/signin.dart';
import '../../voucher/voucher_screen.dart';
import '../../wallet/wallet_screen.dart';
class Ddrawerwiidget extends StatefulWidget {
  const Ddrawerwiidget({super.key});

  @override
  State<Ddrawerwiidget> createState() => _DdrawerwiidgetState();
}

class _DdrawerwiidgetState extends State<Ddrawerwiidget> {
  @override
  Widget build(BuildContext context) {

    int _selectedRadio = 1;
  return
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            color:Color(0xff15cb95) ,
            child: ListView(

              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 20,),
                Text(
                    "Sara",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                        color: Colors.white
                    )
                ),
                Text(
                    "1000,0 Points",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    )
                ),
                SizedBox(height: 20,),
                Divider(thickness: 1),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.home_filled,color: backgroundColor,),
                      SizedBox(width: 10,),
                      Text(Translator.translate("orders"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  onTap: () {
                    UserNavigator.of(context).push( const OrderDetail());


                  },
                ),
                SizedBox(height: 10,),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.wallet,color: backgroundColor,),
                      SizedBox(width: 10,),
                      Text(Translator.translate("wallet"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  onTap: () {
                    UserNavigator.of(context).push( const WalletScreen());


                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.list_alt_outlined,color: backgroundColor,),
                      SizedBox(width: 10,),
                      Text(Translator.translate("Vouchers"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  onTap: () {
                    UserNavigator.of(context).push( const VoucherScreen());


                  },
                ),
                SizedBox(height: 10,),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.language,color: backgroundColor,),
                      SizedBox(width: 10,),
                      Text(Translator.translate("select_language"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(' Please select_language'),
                          content:  SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                RadioListTile<int>(
                                    value: 1,
                                    title: Text("Arabic"),
                                    groupValue: _selectedRadio,
                                    onChanged: (v) {
                                      setState(() {
                                        _selectedRadio = v!;
                                      });
                                    }),
                                RadioListTile(
                                    value: 2,
                                    title: Text("English"),
                                    groupValue: _selectedRadio,
                                    onChanged: (v) {
                                      setState(() {
                                        _selectedRadio = v!;
                                      });
                                    }),


                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Select'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 10,),

                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.settings,color: backgroundColor,),
                      SizedBox(width: 10,),
                      Text(Translator.translate("Setting"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  onTap: () {
                    UserNavigator.of(context).push(  SettingScreen());

                  },
                ),



                SizedBox(height: 10,),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.email,color: backgroundColor,),
                      SizedBox(width: 10,),
                      Text(Translator.translate("Info@wasiljo.com"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  onTap: () {
                    //Navigator.pop(context);
                  },
                ),
                SizedBox(height: 10,),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.share,color: backgroundColor,),
                      SizedBox(width: 10,),
                      Text(Translator.translate("share"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  onTap: () {
                    //Navigator.pop(context);
                  },
                ),

           

                Divider(height: 23,thickness: 1.2,),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.logout,color: backgroundColor,),
                      SizedBox(width: 10,),
                      Text(Translator.translate("logout"),style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  onTap: () async {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),


      ],
    ) ;
}}