import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:userwasil/views/detail/order_detail.dart';

import '../../utils/helper/navigator.dart';
import '../../utils/theme/theme.dart';
import 'components/address.dart';
import 'components/advertisement_widget.dart';
import 'components/category.dart';
import 'components/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {


    //Global Keys
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();


    Future<void> _refresh() async {}

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(
        backgroundColor: Colors.white,
        width: 250,
        child: Ddrawerwiidget(),
      ),
      appBar: AppBar(elevation: 0, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, bottom: 10),
          child: InkWell(
              onTap: () {
                UserNavigator.of(context).push( const OrderDetail());
              },
              child: const Icon(Icons.shopping_bag)),
        ),
      ]),
      body: RefreshIndicator(
        onRefresh: _refresh,
        key: _refreshIndicatorKey,
        child:  Column(
          children: [
            AddressWidget(),
            AdvertisementWidget(),
            SizedBox(height: 50,),
            CategoryWidget(),
            Spacer(),
            Container(
                width: 390,
                height: 74,
                decoration: BoxDecoration(
                    color: Color(0xff15cb95))
            )
          ],
        ),
      ),
    ));
  }
}
