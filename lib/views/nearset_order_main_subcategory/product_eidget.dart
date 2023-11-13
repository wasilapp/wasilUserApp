import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:userwasil/views/nearset_order_main_subcategory/main_sub_model.dart';

import '../../config/custom_package.dart';
import '../../core/locale/locale.controller.dart';

class Product extends StatefulWidget {
  const Product({super.key, required this.model});
 final  MainSubcategoryModel model;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {


      LocaleController Localecontroller = Get.put(LocaleController());

      return Column(mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(

            child: ListTile(
              leading: Image.network(
                  width: 108,
                  height: 75,
                  'https://news.wasiljo.com/${widget.model.imageUrl}'),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Localecontroller.language=='en'?widget.model.title!.en as String:widget.model.title!.ar as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        Text(Localecontroller.language=='en'?widget.model.description!.en as String:widget.model.description!.ar as String,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )),
                        Text(widget.model.counter==0?'${widget.model.price}JD'.toString():
                        '${(widget.model.price! * widget.model.counter!)!.toStringAsFixed(3)}JD',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )),
                      ]),

                  Material(elevation: 5,
                    child: Container(decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(15)
                    ),height: 30,
                      child: Row(
                        children: [
                          InkWell(child: Icon(Icons.add,color: AppColors.primaryColor),
                            onTap: () {

                              setState(() {

                                widget.model.counter=    (widget.model.counter!+1)!;

                                print(    widget.model.counter);
                              });
                            },),
                          const SizedBox(width: 9,),
                          Text('${widget.model.counter}'),
                          const SizedBox(width: 9,),
                          InkWell(child: Icon(Icons.remove,color: AppColors.primaryColor),
                            onTap: () {
                              setState(() {
                                if(widget.model.counter!>0) {
                                  widget.model.counter =
                                  (widget.model.counter! - 1)!;
                                } });
                            },),
                        ],
                      ),
                    ),
                  ),

                ],
              ),


            ),
          ),

          const Divider(
            color: AppColors.borderColor,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );


  }
}
