import 'package:flutter/material.dart';
import 'package:userwasil/utils/ui/user_text.dart';

import '../../config/colors.dart';

class CommonViews {
  static final CommonViews _shared = CommonViews._private();

  factory CommonViews() => _shared;

  CommonViews._private();

  // singleton Ready

  AppBar getAppBar({ String? title, Color? color,IconData?icon}) {
    return AppBar(
      actions: [

        Padding(padding: EdgeInsets.only(right: 20),
            child: Icon(icon))
      ],
        backgroundColor: color ?? Colors.white,
        elevation: 0,
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
        title: Text(title!, style: TextStyle(color: Colors.black,fontSize: 18,
          fontWeight: FontWeight.w400,)),
        centerTitle: true);
  }

  Widget createButton(
      {required String title, required VoidCallback onPressed}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor,
       minimumSize: Size(50, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),

        child: UserText(
          title: title,
          color: Colors.white,
        ));
  }
}