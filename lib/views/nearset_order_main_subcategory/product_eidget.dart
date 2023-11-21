import 'package:get/get.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_controller.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_model.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/core/locale/locale.controller.dart';

class Product extends StatefulWidget {
  const Product({super.key, required this.model, required this.index});
  final SubCategoriesModel model;
  final int index;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    LocaleController localecontroller = Get.put(LocaleController());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Image.network(
              width: 108,
              height: 75,
              'https://admin.wasiljo.com/${widget.model.imageUrl}'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        localecontroller.language!.languageCode == 'en'
                            ? widget.model.title!.en as String
                            : widget.model.title!.ar as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    Text(
                        localecontroller.language!.languageCode == 'en'
                            ? widget.model.description!.en as String
                            : widget.model.description!.ar as String,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                    Text(
                        widget.model.counter == 0
                            ? '${widget.model.price}JD'.toString()
                            : '${(widget.model.price! * widget.model.counter!).toStringAsFixed(3)}JD',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ]),
              Material(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(15)),
                  height: 30,
                  child: Row(
                    children: [
                      InkWell(
                        child: const Icon(Icons.add,
                            color: AppColors.primaryColor),
                        onTap: () {
                          setState(() {
                            widget.model.counter = (widget.model.counter! + 1);
                            subCategoriesModel.add(widget.model);
                            orderType = '4';
                            print(widget.model.counter);
                          });
                        },
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      Text('${widget.model.counter}'),
                      const SizedBox(
                        width: 9,
                      ),
                      InkWell(
                        child: const Icon(Icons.remove,
                            color: AppColors.primaryColor),
                        onTap: () {
                          setState(() {
                            if (widget.model.counter! > 0) {
                              widget.model.counter =
                                  (widget.model.counter! - 1);
                              subCategoriesModel.remove(widget.model);
                              orderType = '4';
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
