import 'package:flutter/material.dart';
import 'package:userwasil/views/delivery/delivery_to.dart';

import '../../../utils/helper/navigator.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return   Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            UserNavigator.of(context).push( const DeliveryTo());

          },
          child: Container(
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              // color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular((24))),
                      child: Image.asset(
                        'assets/images/Rectangle 1801.png',
                        width: 194.41,
                        height: 140,

                      ),
                    ),
                  ),
                  Text('Water',style: TextStyle(color: Colors.black,fontSize: 15),),
                ],
              )
          ),
        ),
        InkWell(
          onTap: () {
            UserNavigator.of(context).push( const DeliveryTo());

          },
          child: Container(
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              // color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular((24))),
                      child: Image.asset(
                        'assets/images/Rectangle 1801.png',
                        width: 194.41,
                        height: 140,

                      ),
                    ),
                  ),
                  Text('Gass',style: TextStyle(color: Colors.black,fontSize: 15),),
                ],
              )
          ),
        ),
      ],
    );
  }
}
