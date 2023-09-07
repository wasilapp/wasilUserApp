import 'package:flutter/material.dart';

import '../../../utils/size.dart';

class AdvertisementWidget extends StatefulWidget {
  const AdvertisementWidget({super.key});

  @override
  State<AdvertisementWidget> createState() => _AdvertisementWidgetState();
}

class _AdvertisementWidgetState extends State<AdvertisementWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 180,
      child: PageView(
        pageSnapping: true,
        physics: const ClampingScrollPhysics(),
        //   controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            // _currentPage = page;
          });
        },
        children: [ Padding(
          padding: Spacing.all(15.0),
          child: Image.asset(
            'assets/images/img1.jpg'  ,
            fit: BoxFit.cover,
            height: 50,
          ),
        ),],
      ),
    );
  }
}
