import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:userwasil/core/locale/locale.controller.dart';
import 'package:userwasil/views/orders/order_model.dart';
import 'package:userwasil/views/orders/orders_controller.dart';

import '../../config/custom_package.dart';
import '../../utils/ui/shimmer_widget.dart';
import 'detail_order.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({super.key});

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  OrderController controller =Get.put(OrderController());
  LocaleController controllerLocale =Get.put(LocaleController());
  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        controller.getOrders();
        return;
      },
      child: SafeArea(
        child: Scaffold(

          appBar: AppBar(            iconTheme: IconThemeData(color: Colors.black),elevation: 0,title: Text('orders'.tr,style: TextStyle(color:Color(0xff373636),fontSize: 18,
            fontWeight: FontWeight.w400,)),backgroundColor: AppColors.backgroundColor,),
          body:    SingleChildScrollView(
            child: Obx(() {
      if (controller.isWaiting) {
      return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
      return Container(
      margin:
      EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      child: Shimmer.fromColors(
      baseColor: AppColors.borderColor,
      highlightColor: Colors.grey.shade300,
      child: Container(
      height: 20.h,
      width: 20.w,
      color: Colors.grey,
      )),
      );
      },
      itemCount: 5,
      );
      }
      if (controller.isError) {
      return Center(
      child: Text(controller.statusModel.value.errorMsg!.value),
      );
      }
      return Column(children: [
      ListView.builder(physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
      return buildOrder(controller.orders[index]);
      },
      itemCount: controller.orders.length,
      shrinkWrap: true,
      ),

      ]);
      }),
          ),
      ),
    ));



  }
  buildOrder(OrderModel order){
    return Column(
      children: [
        ListTile(
          trailing: order.status==5?Text(order.total.toString(),style: TextStyle(
            fontSize: 14,color: Color(0xff868889),
            fontWeight: FontWeight.w400,
          )):IconButton(onPressed: () {
controller.getDetailOrders(order.id!);
          Get.to(DetailOrder(id:order.id!));
            }
              ,icon:  Icon(Icons.arrow_forward_ios,color: AppColors.primaryColor,size: 15)),
          // leading: Image.network(order.),
          title:    Text(controllerLocale.language== 'en' ?' s':'${order.statu!.title!.ar}',
              style: TextStyle(color: AppColors.primaryColor,fontSize: 12,fontWeight: FontWeight.w400)),

          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //   Text(controllerLocale.language=='en'?' ${order.shop!.name!.en}':'${order.shop!.name!.ar}',
              // style: TextStyle(color: AppColors.secondaryColor,fontSize: 14,fontWeight: FontWeight.w400)),


                Row(
              children: [
                //Text('Order Time'),
                Text(' ${order.createdAt}',style: TextStyle(
                  fontSize: 12,color: Color(0xff868889),
                  fontWeight: FontWeight.w400,
                )
                )
              ],
            ),
            Row(
              children: [
                Text('Order Id'.tr),
                Text(' ${order.id}'),
              ],
            ),
        SizedBox(height: 5,),
         InkWell(onTap: () {
           print(order.id!);
           controller.cancelOrder(order.id!);
           // controller.getOrders();

         },
           child: Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
                order.statu!.id==1?   Row(
            children: [

              Text("Cancel Order".tr,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
            ],
                   ):Text(''),
                   SizedBox(width: 50,),
                   //     Row(
                   //   children: [
                   //     Icon(Icons.tag_faces_sharp,color: AppColors.primaryColor,),
                   //     Text("Rate".tr,)
                   //   ],
                   // ),
            ],
                   ),
         )
          ]),
        ), Divider(thickness: 3,color: AppColors.borderColor,)
      ],
    );

  }
}
