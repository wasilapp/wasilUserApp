import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:userwasil/views/auth/delet_account/delet_user.dart';

import '../../../../config/custom_package.dart';
import '../../../../controller/AuthController_new.dart';
import '../../../../core/locale/locale.controller.dart';
import '../../../../utils/helper/navigator.dart';
import '../../../../utils/theme/theme.dart';
import '../../../addresses/all_address/all_address_screen.dart';
import '../../../../controller/AuthController.dart';
import '../../../auth/update_profile/update_user.dart';
import '../../../setting/setting.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name = '';
  String email = '';
  // String code='';

  _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
      email = prefs.getString('email')!;
      // code= prefs.getString('code')!;
      print(name);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  String language = 'en';
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    AuthController authController = Get.put(AuthController());

    return Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
      int themeType = value.themeMode();
      themeData = AppTheme.getThemeFromThemeMode(themeType);
      customAppTheme = AppTheme.getCustomAppTheme(themeType);
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SettingScreen(),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: whitebasic,
                        ),
                        // Text(
                        //   email,
                        //   style: whitebasic,
                        // ),
                      ],
                    ),
                  ),

                  Divider(
                    height: 1.h,
                    thickness: 1.2,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.home_filled,
                          color: AppColors.backgroundColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Translator.translate("orders".tr),
                          style: whitebasic,
                        ),
                      ],
                    ),
                    onTap: () {
                      UserNavigator.of(context).push(const AllOrder());
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.person_2_outlined,
                          color: AppColors.backgroundColor,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          Translator.translate("edit profile".tr),
                          style: whitebasic,
                        ),
                      ],
                    ),
                    onTap: () {
                      UserNavigator.of(context).push(const UpdateUser());
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.wallet,
                          color: AppColors.backgroundColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Translator.translate("coupon book".tr),
                          style: whitebasic,
                        ),
                      ],
                    ),
                    onTap: () {
                      UserNavigator.of(context).push(const WalletScreen());
                    },
                  ),

                  // ListTile(
                  //    title: Row(
                  //      children: [
                  //        Icon(Icons.list_alt_outlined,color: AppColors.backgroundColor,),
                  //        SizedBox(width: 10,),
                  //        Text(Translator.translate("Vouchers".tr),style: whitebasic,),
                  //      ],
                  //    ),
                  //    onTap: () {
                  //      UserNavigator.of(context).push( VoucherScreen());
                  //
                  //    },
                  //  ),
                  SizedBox(
                    height: 1.h,
                  ),
//                   ListTile(
//                     title: Row(
//                       children: [
//                         const Icon(
//                           Icons.language,
//                           color: AppColors.backgroundColor,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           Translator.translate("select_language".tr),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                     onTap: () {
//                       showDialog<void>(
//                           context: context,
//                           builder: (BuildContext context) {
//                             int selectedRadio = 0;
//                             return AlertDialog(
//                               actions: [
//                                 TextButton(
//                                     onPressed: () {
//                                       Get.back();
//                                     },
//                                     child: const Text(
//                                       'cancel',
//                                       style: TextStyle(color: Colors.red),
//                                     )),
//                                 TextButton(
//                                     onPressed: () {
//                                       controller.changeLang(language);
//                                       Get.back();
//                                     },
//                                     child: const Text(
//                                       'save',
//                                       style: TextStyle(
//                                           color: AppColors.primaryColor),
//                                     )),
//                               ],
//                               content: StatefulBuilder(
//                                 builder: (BuildContext context,
//                                     StateSetter setState) {
//                                   return Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children:
//                                           //List<Widget>.generate(4, (int index) {
//                                           [
//                                         Row(
//                                           children: [
//                                             Radio<String>(
//                                               activeColor:
//                                                   AppColors.primaryColor,
//                                               value: 'en',
//                                               groupValue: language,
//                                               onChanged: (value) {
//                                                 setState(
//                                                     () => language = value!);
//                                               },
//                                             ),
//                                             const Text('English Language')
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Radio<String>(
//                                               activeColor:
//                                                   AppColors.primaryColor,
//                                               value: 'ar',
//                                               groupValue: language,
//                                               onChanged: (value) {
//                                                 setState(
//                                                     () => language = value!);
//                                               },
//                                             ),
//                                             const Text('Arabic Language')
//                                           ],
//                                         ),
//                                       ]
//                                       // }
//
//                                       );
//                                 },
//                               ),
//                             );
//                           });
//
//                       // showRadioDialog();
// // Get.defaultDialog(
// //   title: "Select Language".tr,
// //   content: Column(mainAxisSize:MainAxisSize.min ,
// //            children: [
// //              RadioListTile(title:const Text('Arabic Language') ,
// //                value: 'ar', groupValue: language, onChanged: (value) {
// //
// //
// //                  language=value!;
// //                  print(language);
// //
// //
// //              },)
// //           ,    ,Radio(
// //                value: 'ar', groupValue: language, onChanged: (value) {
// //                language=value!;
// //              },)
// //            ],
// //          ),
// //   textConfirm: "save".tr,
// //   textCancel: "Cansel".tr,
// //   buttonColor: AppColors.primaryColor,
// //   onConfirm: () {
// //     controller.changeLang(language);
// //     Get.back();
// //   },
// //
// // );
//                     },
//                   ),
                  SizedBox(
                    height: 1.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.call,
                          color: AppColors.backgroundColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Translator.translate("contact_us".tr),
                          style: whitebasic,
                        ),
                      ],
                    ),
                    onTap: () {
                      UserNavigator.of(context).push(Contact());
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.share,
                          color: AppColors.backgroundColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Translator.translate("share".tr),
                          style: whitebasic,
                        ),
                      ],
                    ),
                    onTap: () async {
                      print('kk');
                      SharedPreferences prfs =
                          await SharedPreferences.getInstance();
                      var ref = prfs.getString('referrer');
                      Share.share(
                        ref!,
                      );
                      //Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     UserNavigator.of(context).push(  SettingScreen());
                  //
                  //   },
                  //
                  //   title: Row(
                  //     children: [
                  //       const Icon(Icons.settings,color: AppColors.backgroundColor,),
                  //       const SizedBox(width: 10,),
                  //       Text(Translator.translate("Setting".tr),style: whitebasic,),
                  //     ],
                  //   ),
                  //
                  // ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  Translator.translate("delete_account".tr),
                  style: whitebasic,
                ),
              ],
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DeleteUserDialog();
                  });
            },
          ),
          const Divider(
            height: 23,
            thickness: 1.2,
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: AppColors.backgroundColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  Translator.translate("logout".tr),
                  style: whitebasic,
                ),
              ],
            ),
            onTap: () async {
              authController.logoutUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SignInScreen(),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
