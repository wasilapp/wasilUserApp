import 'package:get/get.dart';

import '../../config/custom_package.dart';
import '../../core/locale/locale.controller.dart';
import 'orders_controller.dart';

class DetailOrder extends StatelessWidget {
  const DetailOrder({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller =Get.put(OrderController());
    LocaleController controllerLocale =Get.put(LocaleController());
    return SafeArea(
      child: Scaffold( appBar: AppBar(            iconTheme: IconThemeData(color: Colors.black),elevation: 0,
        // title: Text('checkOut'.tr,style: TextStyle(color:Color(0xff373636),fontSize: 18,
        // fontWeight: FontWeight.w400,)),
        backgroundColor: AppColors.backgroundColor,),
        body: Column(
          children: [
            Image.asset('assets/images/Rectangle 303.png'),
            SizedBox(height: 2.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 1.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              //   Icon(Icons.location_on_outlined,color: Color(0xffA6A6A6),)
              // ,
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                       '${controller.myOrders!.type==0?"Home":"Work"} '+'(${controller.myOrders!.address!.name.toString()}) ',
                    overflow: TextOverflow.ellipsis,maxLines: 1,
                       style: TextStyle(
                          overflow: TextOverflow.ellipsis,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,color: Colors.black
                        )
                    ),
                    Text(
                        "${controller.myOrders!.address!.city.toString()}, ${controller.myOrders!.address!.city.toString()}, Building, ${controller.myOrders!.address!.buildingNumber.toString()}, ${controller.myOrders!.address!.apartmentNum.toString()}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,color: Color(0xffA6A6A6)
                        )
                    ),
                    Text(
                        "Mobile: ${controller.myOrders!.user!.mobile.toString()}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,color: Color(0xffA6A6A6)
                        )
                    ),
                  ],
                )
              ],),
            ),
            SizedBox(height: 2.h,),
            Container(
                width: 390,
                height: 5,
                decoration: BoxDecoration(
                    color: Color(0xfff2f2f2))
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 1.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon(Icons.timelapse,color: Color(0xffA6A6A6),)
                  // ,
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("order Date".tr),
                          Text('${controller.myOrders!.id.toString()}'),
                          Text(': ${controller.myOrders!.createdAt!}'
                              ,   style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,color: Color(0xffA6A6A6)
                              )  ),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        children: [
                          Text("payment method".tr),
                          Text(': ${controller.myOrders!.orderPayment!.paymentType==2?'Cash':'wallet'}',   style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,color: Color(0xffA6A6A6)
                          )
                          ),
                        ],
                      ),



                    ],
                  )
                ],),
            ),
            SizedBox(height: 2.h,),
           Container(
          width: 390,
          height: 5,
          decoration: BoxDecoration(
          color: Color(0xfff2f2f2))
    ),
    SizedBox(height: 2.h,),
            ListView.builder(itemBuilder: (context, index) {
              return
                  ListTile(
                    leading:
                    Image.network('https://news.wasiljo.com/${controller.myOrders!.carts![index].subCategory!.imageUrl}',width: 20.w,
                      height: 20.h,),
                   title:                               Text(controllerLocale.language=='en'?'${controller.myOrders!.carts![index].subCategory!.title!.en}':'${controller.myOrders!.carts![index].subCategory!.title!.ar}')
                      ,
                   subtitle:    Column(
                        children: [
                          Row(
                            children: [
                              Text("amount".tr),
                              Text(': ${controller.myOrders!.carts![index].subCategory!.quantity!}'+'${controllerLocale.language=='en'?'${controller.myOrders!.carts![index].subCategory!.quantity!}':
    '${controller.myOrders!.carts![index].subCategory!.title!.ar}'}'),
                            ],
                          ),  Row(
                            children: [
                              Text("price".tr),
                              Text(': ${controller.myOrders!.carts![index].subCategory!.price!}'
                              ),
                            ],
                          ),
                        ],
                      )
                  );
            },shrinkWrap: true,itemCount: controller.myOrders!.carts!.length,)
           , Container(
                width: 390,
                height: 5,
                decoration: BoxDecoration(
                    color: Color(0xfff2f2f2))
            ),
            SizedBox(height: 2.h,),
            Spacer(),
            controller.myOrders!.status==1? InkWell(
              onTap: () {
                controller.cancelOrder(controller.myOrders!.id!.toInt());
                controller.getDetailOrders(controller.myOrders!.id!.toInt());
              },
              child: Container(width: double.infinity,alignment: Alignment.bottomCenter,height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,

                ),
                child: Center(child: Text('Cancel Order')),
              ),
            ):
                Text('')

          ],
        ),
      ),
    );
  }
}
