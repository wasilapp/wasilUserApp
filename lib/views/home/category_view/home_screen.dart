

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../config/custom_package.dart';
import '../../old/detail/order_detail.dart';
import 'components/address_widget.dart';
import '../../category/category.dart';
import 'components/drawer.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    getToken();
    fcm();
    onMessage();
    // initFCM();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log('lllllllllllllllll');
    //   print(message.data);
    //   RemoteNotification notification = message.notification!;
    //   AndroidNotification android = message.notification!.android!;
    //   if (notification != null && android != null) {
    //     FlutterNotificationView()
    //         .showNotification('kkkkk', 'k');
    //   }
    // });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('------------------------------------------------------');
    //   RemoteNotification notification = message.notification!;
    //
    //   AndroidNotification android = message.notification!.android!;
    //   print(message.notification);
    //   print('------------------------------------------------------');
    //   if (notification != null && android != null) {
    //     NotificationModel response=NotificationModel.fromJson(message.data);
    //
    //       print(message.notification);
    //       print(response.body['en']);
    //       flutterLocalNotificationsPlugin.show(message.hashCode, response.title['en'], response.body['en'], NotificationDetails(
    //           android: AndroidNotificationDetails(
    //               androidChannel.id,androidChannel.name,color:AppColors.primaryColor,playSound: true,
    //               enableVibration: true
    //           )
    //       ));
    //     FlutterNotificationView()
    //         .showNotification(notification.title!, notification.body!);
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const Drawer(
        backgroundColor: AppColors.primaryColor,
        width: 250,
        child: DrawerWidget(),
      ),
      appBar: AppBar(backgroundColor: AppColors.backgroundColor,actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0, actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          child: InkWell(
              onTap: () {
                UserNavigator.of(context).push( const OrderDetail());
              },
              child: const Icon(Icons.shopping_bag)),
        ),
      ]),
      body: Column(
        children: [

          AddressWidget(),

          Padding(
            padding: Spacing.all(1.0),
            child: Image.asset(
              'assets/images/img1.png',
              fit: BoxFit.cover,
              height: 140,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 50,),
         const CategoryWidget(),
          const Spacer(),
          InkWell(
            onTap: () {
              FirestoreServices().test();
            },
            child: Container(
                width: 390,
                height: 74,
                decoration: const BoxDecoration(
                    color: Color(0xff15cb95))
            ),
          )
        ],
      ),
    ));
  }
  onMessage(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
  getToken(){
    FirebaseMessaging.instance.getToken().then((value) => print(value));
  }
  fcm() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }
}
