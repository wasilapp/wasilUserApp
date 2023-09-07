import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:userwasil/utils/ui/common_views.dart';

import '../../utils/size.dart';
import '../../utils/ui/user_text.dart';
import '../address/address.dart';
import '../detail/order_detail.dart';
import '../shop/shops_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    final _quantityTextController = TextEditingController();
    void initState() {
      _quantityTextController.text = '2';
      super.initState();
    }
    return SafeArea(child: Scaffold(
appBar: CommonViews().getAppBar(title: '',icon: Icons.shopping_bag),
      body: ListView(
        padding:    EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 20,),
          UserText(title: 'Delivering To',

            fontSize: 14,
            color:Color(0xff666666),
            fontWeight: FontWeight.w400,),
          Row(
            children: <Widget>[

              Container(
                child: Column(
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
          Container(
            height: 10,
            width: double.infinity,
            color: Color(0xffF2F2F2),
          ),
          const Divider(),
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
                              height: 0.0,
                            ),
                            UserText(
                              title: 'defffffffffffffffff',
                              color: Color(0xffA6A6A6),
                            ),
                            UserText(
                              title: '1.00 JO',
                            ),


                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width* 0.3,
                          child: Row(
                            children: [
                              _quantityController(

                                fct: () {
                                  if (_quantityTextController.text == '1') {
                                    return;
                                  } else {

                                    setState(() {
                                      _quantityTextController.text = (int.parse(
                                          _quantityTextController
                                              .text) -
                                          1)
                                          .toString();
                                    });
                                  }
                                },
                                color: Colors.red,
                                icon:  MdiIcons.minus,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.red,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                fct: () {

                                  setState(() {
                                    print(_quantityTextController.text);
                                    _quantityTextController.text = (int.parse(
                                        _quantityTextController.text) +
                                        1)
                                        .toString();
                                  });
                                },
                                color: Colors.green,
                                icon:
                                  MdiIcons.plus,


                              )
                            ],
                          ),
                        ),

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
          const Divider(),
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
                              title: 'dec',
                            ),

                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width* 0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                fct: (){},
                                // fct: () {
                                //   if (_quantityTextController.text == '1') {
                                //     return;
                                //   } else {
                                //     cartProvider.reduceQuantityByOne(
                                //         cartModel.productId);
                                //     setState(() {
                                //       _quantityTextController.text = (int.parse(
                                //           _quantityTextController
                                //               .text) -
                                //           1)
                                //           .toString();
                                //     });
                                //   }
                                // },
                                color: Colors.red,
                                icon: Icons.minimize,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                // fct: () {
                                //   cartProvider.increaseQuantityByOne(
                                //       cartModel.productId);
                                //   setState(() {
                                //     _quantityTextController.text = (int.parse(
                                //         _quantityTextController.text) +
                                //         1)
                                //         .toString();
                                //   });
                                // },
                                color: Colors.green,
                                icon: Icons.plus_one, fct: (){},
                              )
                            ],
                          ),
                        ),

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
          const Divider(),
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
                              title: 'dec',
                            ),

                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width* 0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                fct: (){},
                                // fct: () {
                                //   if (_quantityTextController.text == '1') {
                                //     return;
                                //   } else {
                                //     cartProvider.reduceQuantityByOne(
                                //         cartModel.productId);
                                //     setState(() {
                                //       _quantityTextController.text = (int.parse(
                                //           _quantityTextController
                                //               .text) -
                                //           1)
                                //           .toString();
                                //     });
                                //   }
                                // },
                                color: Colors.red,
                                icon: Icons.minimize,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                // fct: () {
                                //   cartProvider.increaseQuantityByOne(
                                //       cartModel.productId);
                                //   setState(() {
                                //     _quantityTextController.text = (int.parse(
                                //         _quantityTextController.text) +
                                //         1)
                                //         .toString();
                                //   });
                                // },
                                color: Colors.green,
                                icon: Icons.plus_one, fct: (){},
                              )
                            ],
                          ),
                        ),

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
                              title: 'dec',
                            ),

                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width* 0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                fct: (){},
                                // fct: () {
                                //   if (_quantityTextController.text == '1') {
                                //     return;
                                //   } else {
                                //     cartProvider.reduceQuantityByOne(
                                //         cartModel.productId);
                                //     setState(() {
                                //       _quantityTextController.text = (int.parse(
                                //           _quantityTextController
                                //               .text) -
                                //           1)
                                //           .toString();
                                //     });
                                //   }
                                // },
                                color: Colors.red,
                                icon: Icons.minimize,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                // fct: () {
                                //   cartProvider.increaseQuantityByOne(
                                //       cartModel.productId);
                                //   setState(() {
                                //     _quantityTextController.text = (int.parse(
                                //         _quantityTextController.text) +
                                //         1)
                                //         .toString();
                                //   });
                                // },
                                color: Colors.green,
                                icon: Icons.plus_one, fct: (){},
                              )
                            ],
                          ),
                        ),

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
                              title: 'dec',
                            ),

                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width* 0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                fct: (){},
                                // fct: () {
                                //   if (_quantityTextController.text == '1') {
                                //     return;
                                //   } else {
                                //     cartProvider.reduceQuantityByOne(
                                //         cartModel.productId);
                                //     setState(() {
                                //       _quantityTextController.text = (int.parse(
                                //           _quantityTextController
                                //               .text) -
                                //           1)
                                //           .toString();
                                //     });
                                //   }
                                // },
                                color: Colors.red,
                                icon: Icons.minimize,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                // fct: () {
                                //   cartProvider.increaseQuantityByOne(
                                //       cartModel.productId);
                                //   setState(() {
                                //     _quantityTextController.text = (int.parse(
                                //         _quantityTextController.text) +
                                //         1)
                                //         .toString();
                                //   });
                                // },
                                color: Colors.green,
                                icon: Icons.plus_one, fct: (){},
                              )
                            ],
                          ),
                        ),

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
          Container(
            margin: EdgeInsets.all(20),
            child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total :'),
                Text('1.5 JO')
              ],
            )
          ),
          ElevatedButton(

            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
                minimumSize:
                MaterialStatePropertyAll(Size(341, 50))),
            onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderDetail()));},
            child: Text(
                "Complete Order",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
            ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    ));
  }
  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

