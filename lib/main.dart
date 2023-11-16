
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:userwasil/services/PushNotificationsManager.dart';
import 'package:userwasil/services/f.dart';

import 'package:userwasil/services/services.dart';
import 'package:userwasil/utils/theme/theme.dart';
import 'package:userwasil/views/home/category_view/home_screen.dart';
import 'package:userwasil/views/old/MaintenanceScreen.dart';
import 'package:userwasil/views/old/api/api_util.dart';
import 'package:userwasil/views/old/controllers/AppDataController.dart';
import 'package:userwasil/views/old/models/AppData.dart';
import 'package:userwasil/views/old/models/MyResponse.dart';
import 'package:userwasil/views/splash/splash_screen.dart';


import 'config/custom_package.dart';
import 'controller/AuthController.dart';
import 'controller/AuthController_new.dart';
import 'core/locale/locale.controller.dart';
import 'core/locale/translation.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
//     'android_channel', // id
//     'High Importance Notifications', // title
//     // 'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// class FlutterNotificationView {
//   void showNotification(String title, String body) {
//     flutterLocalNotificationsPlugin.show(
//         0,
//         title,
//         body,
//         NotificationDetails(
//             android: AndroidNotificationDetails(
//                 androidChannel.id, androidChannel.name,
//                 importance: Importance.max,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher')));
//   }
//
//   Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print(
//         'A bg message just showed up :  ${message.messageId} ${message.notification!.title}');
//     showNotification(
//         message.notification!.title ?? '', message.notification!.body ?? '');
//   }
//
//   FlutterNotificationView() {
//     _setupAlert();
//   }
//
//   void _setupAlert() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
// }
// AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
//     'android_channel', // id
//     'High Importance Notifications', // title
//     // 'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
// //
// // class FlutterNotificationView {
// //   void showNotification(String title, String body) {
// //     flutterLocalNotificationsPlugin.show(
// //         0,
// //         title,
// //         body,
// //         NotificationDetails(
// //             android: AndroidNotificationDetails(androidChannel.id, androidChannel.name, androidChannel.description,
// //
// //
// //         importance: Importance.max,
// //         color: Colors.blue,
// //         playSound: true,
// //         icon: '@mipmap/ic_launcher')));
// //   }
//
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('************************************************************************************');
//   print(
//      ' ${message.data!}');
//
//   if(message.data!=null&&message.data.isNotEmpty){
//     print('************************************************************************************');
//     NotificationModel response=NotificationModel.fromJson(message.data);
//
//     print(message.data);
//     print(response.body['en']);
//     flutterLocalNotificationsPlugin.show(1, 'response.title[''en'']', 'response.body[''en'']', NotificationDetails(
//         android: AndroidNotificationDetails(
//             androidChannel.id,androidChannel.name,color:AppColors.primaryColor,playSound: true,
//             enableVibration: true
//         )
//     ));
//   }
//
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();//by ready firebase
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("***************************************************");
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  FirebaseMessaging.onBackgroundMessage((message) async {
    print("Handling background message: ");
    await FlutterNotificationView().firebaseMessagingBackgroundHandler(message);
  });

  await initialServices();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    // String langCode = await AllLanguage.getLanguage();
    //await Translator.load(langCode);

    runApp(ChangeNotifierProvider<AppThemeNotifier>(
      create: (context) => AppThemeNotifier(),
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initFCM() async {

    PushNotificationsManager pushNotificationsManager =
    PushNotificationsManager();
    await pushNotificationsManager.init();
    FirebaseMessaging.onBackgroundMessage((message) async {
      print("Handling background message: ");
      await FlutterNotificationView().firebaseMessagingBackgroundHandler(message);
    });
  }


  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());


    return
      Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
          return Sizer(builder: (context, orientation, deviceType) {
            return GetMaterialApp(
                locale: controller.language,
                //theme:  AppTheme.getThemeFromThemeMode(value.themeMode()),
                translations: MyTranslation(),
                debugShowCheckedModeBanner: false,

                home:  SplashScreen());}

          );
        },
      );
  }
}

class NotificationModel {
  final Map<String, dynamic> title;
  final Map<String, dynamic> body;
  final String icon;
  final dynamic data;
  final String url;

  NotificationModel({
    required this.title,
    required this.body,
    required this.icon,
    required this.data,
    required this.url,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? {},
      body: json['body'] ?? {},
      icon: json['icon'] ?? '',
      data: json['data'],
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'icon': icon,
      'data': data,
      'url': url,
    };
  }
}


