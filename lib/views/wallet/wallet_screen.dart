
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/utils/ui/user_text.dart';

import '../../../providers/darktheme.dart';
import '../../config/font.dart';

import '../../../../../services/AppLocalizations.dart';
import '../../../utils/theme/theme.dart';
import '../../../utils/ui/common_views.dart';
import 'my_wallet_controller.dart';
import 'my_wallet_model.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>{
  //ThemeData
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  //Global Keys
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  new GlobalKey<ScaffoldMessengerState>();
  MyWalletController controller = Get.put(MyWalletController());

  bool isInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child){
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        return Scaffold(
           appBar: AppBar(

                backgroundColor:  Colors.white,
                elevation: 0,
                // shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
                title: const Text('Wallet', style: TextStyle(color: Colors.black,fontSize: 18,
                  fontWeight: FontWeight.w400,)),
                centerTitle: true),

            body:  SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
children: [

                    Obx(() {
                      if (controller.isWaiting) {
                        return ListView.builder(shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.grey.shade300,
                                  child: Container(
                                    height: 160,
                                    width: 100.w,
                                    color: Colors.grey,
                                  )),
                            );
                          },
                          itemCount: 10,
                        );
                      }
                      if (controller.isError) {
                        return Center(
                          child: Text(controller.statusModel.value.errorMsg!.value),);
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return walletWidget(model: controller.myWalletList[index]);
                        },
                        itemCount: controller.myWalletList.length,
                        shrinkWrap: true,
                      );
                    }),
                  ],
                ),
              ),
            )



        );
      },

    );

  }
  showMessage({String message = "Something wrong", Duration? duration}) {
    if (duration == null) {
      duration = Duration(seconds: 3);
    }
    _scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        duration: duration,
        content: Text(message,
            style: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
                letterSpacing: 0.4, color: themeData.colorScheme.onPrimary)),
        backgroundColor: themeData.colorScheme.primary,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

}

Widget walletWidget({required WalletCouponsAccepted model}) {
  return Column(
    children: [
      ListTile(leading: Text(model.wallet!.id!.toString()),
        title: Text(model.wallet!.title!.en.toString()),
        subtitle: Text(model.wallet!.description!.en.toString()),
        trailing: Text(model.wallet!.usage!.toString()),
      ),
      Divider(color: AppColors.borderColor,)
    ],
  );
}
