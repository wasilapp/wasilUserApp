import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:userwasil/views/category/category_controller.dart';

import '../../../config/custom_package.dart';
import '../../../controller/AuthController_new.dart';
import '../../../model/banner.dart';
import '../../../services/Network.dart';
import '../../../utils/helper/InternetUtils.dart';
import '../../old/api/api_util.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../old/detail/order_detail.dart';
import '../../old/models/MyResponse.dart';
import 'components/address_widget.dart';
import '../../category/category.dart';
import 'components/drawer.dart';
import 'package:http/http.dart'as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getToken();
    getBanner();
    fcm();
    onMessage();
    Get.lazyPut(() => CategoryController());
    super.initState();
  }
  List banners=[];int _numPages = 3;
  PageController? _pageController;
  int _currentPage = 0;
  Timer? timerAnimation;
  getBanner()async{
    var response =await http.get(Uri.parse('https://news.wasiljo.com/public/api/v1/user/banners'));




    if (response.statusCode == 200) {
      List result = json.decode(response.body)['data']['banners'];
      print('start for');

      for (int index = 0; index < result.length; index++) {
        setState(() {
          banners.add(result[index]['url']);
        });
      }

      print(banners);
      return;
    }


    else {
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: AppColors.primaryColor,
        width: 250,
        child: DrawerWidget(),
      ),
      appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          actionsIconTheme: const IconThemeData(color: Colors.black),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 20,
          //     ),
          //     child: InkWell(
          //         onTap: () {
          //           UserNavigator.of(context).push(const OrderDetail());
          //         },
          //         child: const Icon(Icons.shopping_bag)),
          //   ),
          // ]

      ),
      body: Column(
        children: [
          const AddressWidget(),
          banners.length==0?  Padding(
            padding: Spacing.all(1.0),
            child: Image.asset(
              'assets/images/img1.png',
              fit: BoxFit.cover,
              height: 140,
              width: double.infinity,
            ),
          ):   SizedBox(
            height:150,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  'https://news.wasiljo.com/${banners[index]}',
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: banners.length,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: AppColors.primaryColor)),
              // control: const SwiperControl(color: Colors.black),
            ),
          ),
          // Padding(
          //   padding: Spacing.all(1.0),
          //   child: Image.asset(
          //     'assets/images/img1.png',
          //     fit: BoxFit.cover,
          //     height: 140,
          //     width: double.infinity,
          //   ),
          // ),
          // _bannersWidget(),
          const SizedBox(
            height: 50,
          ),
          const CategoryWidget(),
          const Spacer(),
          InkWell(
            onTap: () {
              FirestoreServices().test();
            },
            child: Container(
                width: 390,
                height: 74,
                decoration: const BoxDecoration(color: Color(0xff15cb95))),
          )
        ],
      ),
    );
  }

  onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  getToken() {
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
  _bannersWidget() {
    if (banners!.length == 0) return Container();

    if (_pageController == null) {
      _pageController = PageController(initialPage: 0);
      _numPages = banners!.length;
      int? x= 0;
      timerAnimation = Timer.periodic(Duration(seconds: 4), (Timer timer) {
        if (_currentPage < _numPages - 1 && x ==0) {
          _currentPage++;
        } else if (_currentPage > 0 ) {
          _currentPage--;
          x=_currentPage;
        }

        if (_pageController!.hasClients) {
          _pageController!.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        }
      });
    }

    List<Widget> list = [];
    for (AdBanner banner in banners!) {
      list.add(
        Padding(
          padding: Spacing.all(15.0),
          child: Image.network(
            TextUtils.getImageUrl(banner.url),
            fit: BoxFit.cover,
            height: 40,
          ),
        ),
      );
    }

    return Container(
      height: 166,
      child: PageView(
        pageSnapping: true,
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: list,
      ),
    );
  }
}class AdBanner {
  int id;
  String url;

  AdBanner(this.id, this.url);

  static AdBanner fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());
    String url = jsonObject['url'].toString();

    return AdBanner(id, url);
  }

  static List<AdBanner> getListFromJson(List<dynamic> jsonArray) {
    List<AdBanner> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(AdBanner.fromJson(jsonArray[i]));
    }
    return list;
  }
}
class AdBannerController {
  //------------------------ Get all categories -----------------------------------------//
  static Future<MyResponse<List<AdBanner>>> getAllBanner() async {
    //Getting User Api Token

    String url ='https://news.wasiljo.com/public/api/v1/user-boy/banners';
    Map<String, String> headers =
    ApiUtil.getHeader(requestType: RequestType.Get, );

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<AdBanner>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      MyResponse<List<AdBanner>> myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        List<AdBanner> list =
        AdBanner.getListFromJson(json.decode(response.body!));
        myResponse.success = true;
        myResponse.data = list;
      } else {
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<AdBanner>>();
    }
  }
}

