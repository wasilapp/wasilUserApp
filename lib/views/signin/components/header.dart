import 'package:flutter/cupertino.dart';

import '../../../utils/font.dart';

Widget headerWidget() {
  return Column(children: [
    Image.asset(
      'assets/images/logo.png',
      width: 50,
      height: 50,
    ),
    const SizedBox(
      height: 50,
    ),
    Text(
      ("Sign In"),
      style: boldPrimary,
    ),
    const SizedBox(
      height: 20,
    ),
  ]);
}
