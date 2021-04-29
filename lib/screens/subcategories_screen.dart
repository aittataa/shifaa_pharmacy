import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/classes/sub_categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/screens/product_details.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/divider_line.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

import 'login_screen.dart';

class SubCategoriesScreen extends StatefulWidget {
  static const String id = "SubCategoriesScreen";
  final dynamic controller;
  final Categories category;
  SubCategoriesScreen({this.controller, this.category});
  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  dynamic controller;
  Categories category;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    category = widget.category;
    subIndex = 0;
  }

  int subIndex;
  int subID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("${category.title}", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: BackIconButton(),
        actions: [
          FunctionIconButton(
            icon: Icons.shopping_cart,
            onPressed: () {
              Navigator.pushNamed(context, ShoppingScreen.id);
            },
          ),
          FunctionIconButton(
            icon: Icons.receipt_long,
            onPressed: () {
              Navigator.pushNamed(context, PrescriptionScreen.id);
            },
          ),
          FunctionIconButton(
            icon: Icons.favorite,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(
                    myList: favoriteProductsList.where((product) {
                      return product.isFav == true;
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        final List<SubCategories> myList = Constant.getSubCategories(category.id, controller);
        final bool isNotEmpty = myList.isNotEmpty;
        if (isNotEmpty) {
          subID = myList.first.id;
          return BodyShape(
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    padding: EdgeInsets.all(5),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: myList.length,
                    itemBuilder: (context, index) {
                      SubCategories subCategory = myList[index];
                      subID = subCategory.id;
                      return displaySubCategories(
                        subCategory: subCategory,
                        option: subIndex == index,
                        onTap: () {
                          setState(() {
                            subIndex = index;
                            subID = subCategory.id;
                          });
                        },
                      );
                    },
                  ),
                ),
                DividerLine(value: 10),
                Expanded(
                  child: Obx(() {
                    final ProductsController controller = Get.put(ProductsController());
                    final List<Product> myList = Constant.getProductList(subID, controller);
                    final bool isNotEmpty = myList.isNotEmpty;
                    if (isNotEmpty) {
                      return GridView.builder(
                        padding: EdgeInsets.only(top: 25, right: 5, left: 5),
                        physics: BouncingScrollPhysics(),
                        gridDelegate: Constant.gridDelegate(2),
                        itemCount: myList.length,
                        itemBuilder: (context, index) {
                          Product product = myList[index];
                          bool isFav = isProductFavorite(product);
                          return displayProduct(
                            product: product,
                            isFav: isFav,
                            onTap: () => Get.to(
                              ProductDetails(
                                controller: controller,
                                index: index,
                                myList: myList,
                              ),
                            ),
                            onShopTap: (bool isLiked) async {
                              setState(() {
                                if (isClientLogged) {
                                  onShopProductTap(product, context);
                                } else {
                                  Navigator.popAndPushNamed(context, LoginScreen.id);
                                }
                                return isLiked;
                              });
                            },
                            onFavTap: (bool isLiked) async {
                              setState(() {
                                if (isClientLogged) {
                                  onFavProductTap(product);
                                  isFav = !isFav;
                                } else {
                                  Navigator.popAndPushNamed(context, LoginScreen.id);
                                }
                                return isFav;
                              });
                            },
                          );
                        },
                      );
                    } else {
                      return EmptyBox();
                    }
                  }),
                ),
              ],
            ),
          );
        } else {
          return EmptyBox();
        }
      }),
    );
  }
}
