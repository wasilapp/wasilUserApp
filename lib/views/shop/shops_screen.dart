import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:userwasil/utils/ui/common_views.dart';

import '../../utils/size.dart';
import '../../utils/ui/user_text.dart';
import '../address/address.dart';
import '../servuces/services_screen.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child:
    Scaffold(
      appBar: CommonViews().getAppBar(title: 'Shops',icon: Icons.shopping_bag),

      body: ListView(
        padding:     Spacing.left(16),
        children: [


        const SizedBox(height: 20,),
          const UserText(title: 'Delivering To',

          fontSize: 14,
          color:Color(0xff666666),
          fontWeight: FontWeight.w400,),
        Row(
          children: <Widget>[

             const Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                 Text(
                   "Home (Zaghlool St..",
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.w600,

                   ),),

               ],
             ),
            PopupMenuButton(
              //   key: _addressSelectionKey,
              icon: Icon(
                MdiIcons.chevronDown,
                color:Color(0xff15CB95),


                size: 40,
              ),
              onSelected: (dynamic value) async {
                if (value == -1) {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAddressScreen()));
                } else {
                  setState(() {
                    //        selectedAddress = value;
                  });
                  // _refresh();
                }
              },
              itemBuilder: (BuildContext context) {
                var list = <PopupMenuEntry<Object>>[];
                // for (int i = 0; i < userAddresses!.length; i++) {
                //   list.add(PopupMenuItem(
                //     value: i,
                //     child: Container(
                //       margin: Spacing.vertical(2),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(userAddresses![i].address,
                //               style: AppTheme.getTextStyle(
                //                 themeData.textTheme.bodyText2,
                //                 fontWeight: 600,
                //                 color: themeData.colorScheme.onBackground,
                //               )),
                //           Container(
                //             margin: Spacing.top(2),
                //             child: Text(
                //                 userAddresses![i].city +
                //                     " - " +
                //                     userAddresses![i].pincode.toString(),
                //                 style: AppTheme.getTextStyle(
                //                   themeData.textTheme.caption,
                //                   color: themeData.colorScheme.onBackground,
                //                 )),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ));
                //   list.add(
                //     PopupMenuDivider(
                //       height: 10,
                //     ),
                //   );
                // }
                list.add(PopupMenuItem(
                  value: -1,
                  child: Container(
                    margin: Spacing.vertical(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          MdiIcons.plus,

                          size: 20,
                        ),
                        Container(
                          margin: Spacing.left(4),
                          child: Text(
                              "add_new_address"),

                        ),
                      ],
                    ),
                  ),
                ));
                return list;
              },

            ),
          ],
        ),
          Padding(
            padding: const EdgeInsets.only(top:30.0),
            child: UserText(title: 'Water Services',
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xfff2F2F2))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/Isolation_Mode.svg'),
                      SizedBox(width: 6,),
                      UserText(title: 'filters')

                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xfff2F2F2))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search,color:Colors.black),
                      SizedBox(width: 6,),
                      UserText(title: 'Search')

                    ],
                  ),
                ),
              ),
            ],
          ),

        SizedBox(height: 15,),
          Container(
            height: 10,
            width: double.infinity,
            color: Color(0xffF2F2F2),
          ),
          InkWell(
            onTap: () {

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ServicesScreen()));
            },
            child: ListTile(
              leading: Image.asset('assets/images/Rectangle 1809.png'),
              title: Text(
                  "Qwarercomm",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Al-Rabyeh",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,color: Color(0xff15CB95)),
                      SizedBox(width: 2,),
                      Text('4.2'),
                      SizedBox(width: 2,),
                      Text('(100+ rate)')
                    ],
                  )

                ],
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Image.asset('assets/images/Rectangle 1809.png'),
            title: Text(
                "Qwarercom",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Al-Rabyeh",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xff15CB95)),
                    SizedBox(width: 2,),
                    Text('4.2'),
                    SizedBox(width: 2,),
                    Text('(100+ rate)')
                  ],
                )

              ],
            ),
          ),
   ListTile(
            leading: Image.asset('assets/images/Rectangle 1809.png'),
            title: Text(
                "Qwarercom",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Al-Rabyeh",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xff15CB95)),
                    SizedBox(width: 2,),
                    Text('4.2'),
                    SizedBox(width: 2,),
                    Text('(100+ rate)')
                  ],
                )

              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/Rectangle 1809.png'),
            title: Text(
                "Qwarercom",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Al-Rabyeh",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xff15CB95)),
                    SizedBox(width: 2,),
                    Text('4.2'),
                    SizedBox(width: 2,),
                    Text('(100+ rate)')
                  ],
                )

              ],
            ),
          ),
          Divider(),
   ListTile(
            leading: Image.asset('assets/images/Rectangle 1809.png'),
            title: Text(
                "Qwarercom",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Al-Rabyeh",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xff15CB95)),
                    SizedBox(width: 2,),
                    Text('4.2'),
                    SizedBox(width: 2,),
                    Text('(100+ rate)')
                  ],
                )

              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/Rectangle 1809.png'),
            title: Text(
                "Qwarercom",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Al-Rabyeh",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xff15CB95)),
                    SizedBox(width: 2,),
                    Text('4.2'),
                    SizedBox(width: 2,),
                    Text('(100+ rate)')
                  ],
                )

              ],
            ),
          ),
          Divider(),
   ListTile(
            leading: Image.asset('assets/images/Rectangle 1809.png'),
            title: Text(
                "Qwarercom",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Al-Rabyeh",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xff15CB95)),
                    SizedBox(width: 2,),
                    Text('4.2'),
                    SizedBox(width: 2,),
                    Text('(100+ rate)')
                  ],
                )

              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/Rectangle 1809.png'),
            title: Text(
                "Qwarercom",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Al-Rabyeh",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xff15CB95)),
                    SizedBox(width: 2,),
                    Text('4.2'),
                    SizedBox(width: 2,),
                    Text('(100+ rate)')
                  ],
                )

              ],
            ),
          ),


        ],
      ),
    ));
  }
}
