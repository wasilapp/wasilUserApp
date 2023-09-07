import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:userwasil/views/shop/shops_screen.dart';

import '../../utils/size.dart';
import '../../utils/ui/common_views.dart';
import 'package:flutter_svg/flutter_svg.dart';
class DeliveryTo extends StatefulWidget {
  const DeliveryTo({super.key});

  @override
  State<DeliveryTo> createState() => _DeliveryToState();
}

class _DeliveryToState extends State<DeliveryTo> {


  @override
  Widget build(BuildContext context) {
    var place;
    return SafeArea(
      child:Scaffold(
        appBar: CommonViews().getAppBar(title: 'Replace Water Bottle'),
        body: SingleChildScrollView(
          child: Column(
            children: [
            Stack(
              children: [
                Image.asset('assets/images/Map.png',width: double.infinity,
                  height: 500,),
                Positioned(
                    width: 40,
                    height: 40,
                    top: 199,
                    left: 176,
                    child: SvgPicture.asset(
                        'assets/images/pickup-truck-svgrepo-com 5.svg')),
                Positioned(
                    width: 40,
                    height: 40,
                    top: 315,
                    left: 135,
                    child: SvgPicture.asset(
                        'assets/images/pickup-truck-svgrepo-com 5.svg')),
                Positioned(
                    width: 40,
                    height: 90,
                    top: 322,
                    left: 260,
                    child: SvgPicture.asset(
                      'assets/images/pickup-truck-svgrepo-com 5.svg',
                      width: 100,
                    )),
                Positioned(
                    width: 40,
                    height: 90,
                    top: 255,
                    left: 190,
                    child: SvgPicture.asset(
                      'assets/images/Ellipse 161.svg',
                      width: 100,
                    )),
                Positioned(
                    width: 40,
                    height: 40,
                    top: 372,
                    left: 68,
                    child: SvgPicture.asset(
                        'assets/images/pickup-truck-svgrepo-com 5.svg')),
                Positioned(
                    width: 40,
                    height: 40,
                    top: 90,
                    left: 315,
                    child: InkWell(
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShopsScreen()));},
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xff15CB95)


                        ),
                        child:Icon(Icons.shopping_bag)
                      ),
                    )),
              ],
            ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.all(Radius.circular(16)),


                ),
child:
Column(mainAxisSize: MainAxisSize.min,
    children: [
  Align(

    child: Text(
          "Delivering To",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )
    ),
    alignment: Alignment.topLeft,
  ),
      SizedBox(height: 10,),
      SearchMapPlaceWidget(

          bgColor: Colors.white70,

icon: Icons.search,

          iconColor: Colors.black,
           placeholder: 'Enter your location',
          placeType: PlaceType.address,
          hasClearButton: true,
          textColor: Colors.grey,
          apiKey: 'AIzaSyC7OA_kF9duRuHHew__jN_HdYh8yq0BCtE',
          // onSelected: (Place place) async {
          //   _onAddMarkerButtonPressed();
          //   geo = await place.geolocation;
          //   mapcontroller.animateCamera(
          //       CameraUpdate.newLatLng(geo?.coordinates));
          //   mapcontroller.animateCamera(
          //       CameraUpdate.newLatLngBounds(geo?.bounds, 0));
          //   _center = geo?.coordinates;
          //   print(_center);
          //   center(_center);
          //   print("center");
          //
          //   //     donationLocation = place.description;
          // },
      ),
      SizedBox(height: 10,),
    ListTile(
    title:Text("Home") ,
    subtitle:
    Text(
    "Zaghlool St. , Amman , “26” Building , 2nd..",
    style: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color:Colors.grey,
    )
    ),

    leading:   Icon( MdiIcons.mapMarkerOutline,color: Color(0xff15CB95)),
    trailing: Radio(
    value: true,
    groupValue: place,
    onChanged: (value) {

    }

    )
    ),
    ListTile(
    title:Text("Work") ,
    subtitle:
    Text(
    "Zaghlool St. , Amman , “26” Building , 2nd..",
    style: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color:Colors.grey,
    )
    ),

    leading:   Icon( MdiIcons.mapMarkerOutline),
    trailing: Radio(
    value: true,
    groupValue: place,
    onChanged: (value) {

    }

    )
    ),
      SizedBox(height: 10,),
      ElevatedButton(

          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              minimumSize:
              MaterialStatePropertyAll(Size(341, 50))),
          onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShopsScreen()));},
          child: Text(
            "Sign In",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )
          ),
      ),
      SizedBox(height: 10,),

]),
              )
          ],
          ),
        ),
      )
          
    );
  }
}
