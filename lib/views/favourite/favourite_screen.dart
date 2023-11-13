
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../core/constant/colors.dart';
import '../../providers/darktheme.dart';
import '../../services/AppLocalizations.dart';
import '../../config/font.dart';
import '../../utils/helper/size.dart';
import '../../utils/theme/theme.dart';
import '../driver/drivers_screen.dart';

class GasServices extends StatefulWidget {
  const GasServices({Key? key}) : super(key: key);

  @override
  State<GasServices> createState() => _GasServicesState();
}

class _GasServicesState extends State<GasServices> with SingleTickerProviderStateMixin{
  //ThemeData
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with 3 tabs
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Dispose TabController when not needed to prevent memory leaks
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child){
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar:  AppBar(            iconTheme: IconThemeData(color: Colors.black),elevation: 0,
              // title: Text("Update Profile".tr,style: TextStyle(color:Color(0xff373636),fontSize: 18,
              //   fontWeight: FontWeight.w400,)),
              backgroundColor: AppColors.backgroundColor,

            ),

            body: Column(
              children: [


              ],
            ),



          ),
        );
      },

    );

  }
}
