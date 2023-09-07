import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserText extends StatelessWidget {
 final String title;
 final Color color;
 final double? fontSize;
 final FontWeight ?fontWeight;




  const UserText({super.key, required this.title,  this.color=Colors.black, this.fontSize,  this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(title,
    style: TextStyle(
     color: color,
     fontSize: fontSize??11.sp,
     fontWeight: fontWeight??FontWeight.normal,
    ),);
  }
}
