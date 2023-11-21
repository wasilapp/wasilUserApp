import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userwasil/core/constant/colors.dart';

class SuccesPage extends StatelessWidget {
  const SuccesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Image.asset('assets/images/success.png'),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Your Order has been accepted',
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Your items has been placcd and is on it’s way to being processed',
              maxLines: 4,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll(
                  Size(MediaQuery.sizeOf(context).width * 0.9, 50)),
              backgroundColor:
                  const MaterialStatePropertyAll(AppColors.primaryColor),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
            },
            child: const Text(
              'Back to Home',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
