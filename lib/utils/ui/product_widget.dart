import 'dart:developer';

import 'package:get/get.dart';
import 'package:userwasil/core/locale/locale.controller.dart';
import 'package:userwasil/config/custom_package.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_controller.dart';
import 'package:userwasil/views/subcategory_shop/subcategories_view.dart';

class ProductWidget extends StatefulWidget {
  final model;

  const ProductWidget({super.key, required this.model});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    LocaleController localecontroller = Get.put(LocaleController());
    SubCategoriesController controller = Get.put(SubCategoriesController());

    final SubCategoriesController subCategoriesController = Get.find();

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          color: AppColors.backgroundColor,
          child: ListTile(
            leading: Image.network(
                'https://news.wasiljo.com/${widget.model.imageUrl}'),
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
                              color: Colors.black)),
                      Row(
                        children: [
                          Text(
                              widget.model.counter == 0
                                  ? '${widget.model.price}JD'.toString()
                                  : '${(widget.model.price! * widget.model.counter!).toStringAsFixed(3)}JD',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
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
                          onTap: () {
                            setState(() {
                              widget.model.counter =
                                  (widget.model.counter! + 1);
                              subCategoriesController.getTotalPriceInCart2();
                            });
                          },
                          child: const Icon(Icons.add,
                              color: AppColors.primaryColor),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Text('${widget.model.counter}'),
                        const SizedBox(
                          width: 9,
                        ),
                        InkWell(
                          onTap: () {
                            subCategoriesController.updateCounter(
                                widget.model.id, widget.model.counter);
                            subCategoriesController.getTotalPriceInCart2();
                            setState(
                              () {
                                if (widget.model.counter! - 1 > 0) {
                                  widget.model.counter =
                                      (widget.model.counter! - 1);
                                  log('lll');
                                  subCategoriesController.updateCounter(
                                      widget.model.id, widget.model.counter);
                                  subCategoriesController
                                      .getTotalPriceInCart2();
                                  log(subCategoriesController
                                      .getTotalPriceInCart2()
                                      .toString());
                                } else {
                                  log('lll');
                                  widget.model.counter =
                                      (widget.model.counter! - 1);
                                  subCategoriesController.updateCounter(
                                      widget.model.id, widget.model.counter);
                                  subCategoriesController
                                      .getTotalPriceInCart2();
                                  log(subCategoriesController
                                      .getTotalPriceInCart2()
                                      .toString());
                                  if (controller.cartList.isEmpty) {
                                    Get.to(
                                        () => const SubCategoryByShopScreen());
                                  }
                                }
                              },
                            );
                          },
                          child: const Icon(Icons.remove,
                              color: AppColors.primaryColor),
                        ),
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
