import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:userwasil/utils/ui/product_widget.dart';

import '../../../../config/custom_package.dart';
import '../subcategory_shop/subcategories_controller.dart';
import '../subcategory_shop/subcategories_view.dart';
import '../wallet_shop/wallet_by_shop_controller.dart';
import '../wallet_shop/wallet_by_shop_screen.dart';

class AllSubCategoryByShopScreen extends StatefulWidget {
  const AllSubCategoryByShopScreen({super.key});






  @override
  AllSubCategoryByShopScreenState createState() => AllSubCategoryByShopScreenState();

}

class AllSubCategoryByShopScreenState extends State<AllSubCategoryByShopScreen> {


  @override
  Widget build(BuildContext context) {

    SubCategoriesController controller = Get.put(SubCategoriesController());
    WalletShopController controllerWallet = Get.put(WalletShopController());


       final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
    return DefaultTabController(
        length: 2,
        child: SafeArea(child: Scaffold(
            appBar: AppBar(

              backgroundColor: AppColors.backgroundColor,

              bottom:  TabBar(
                indicatorColor: AppColors.primaryColor,
                labelColor:  AppColors.primaryColor,
                unselectedLabelColor:  AppColors.primaryColor,

                tabs: [
                  Tab( icon: UserText(title:"subcategory".tr, fontWeight : FontWeight.w600,textColor:AppColors.primaryColor,),),
                  Tab(icon: UserText(title:"wallet".tr, fontWeight : FontWeight.w600,textColor: AppColors.primaryColor,),),

                ],
              ),
            ),
            body:  RefreshIndicator(
              backgroundColor: Colors.red,
              key: refreshIndicatorKey,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                controller.getProducts(controller.shopId);
                controllerWallet.getProducts(controller.shopId);
                return;
              },child: const TabBarView(
                  children: [
                    SubCategoryByShopScreen(),
                    WalletByShopScreen(),
                   ]),
            )
        )))  ;
  }


}
