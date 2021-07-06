import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/contains_controller.dart';
import 'package:shifaa_pharmacy/controllers/orders_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/product_shape.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

import '../classes/product.dart';
import '../screens/prescription_screen.dart';
import '../screens/product_details.dart';
import '../screens/shopping_screen.dart';
import '../widget/back_icon.dart';
import '../widget/body_shape.dart';
import '../widget/function_button.dart';

class ProductScreen extends StatelessWidget {
  static const String id = "ProductScreen";
  final OrdersController orders = Get.put(OrdersController());
  final ContainsController contains = Get.put(ContainsController());

  final String title;
  final List<Product> myList;
  ProductScreen({this.title, this.myList});

  final bool state = SharedFunctions.isClientLogged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("$title", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: BackIconButton(),
        actions: [
          FunctionIconButton(
            icon: Icons.shopping_cart,
            onPressed: () {
              Get.to(() => ShoppingScreen());
            },
          ),
          FunctionIconButton(
            icon: Icons.receipt_long,
            onPressed: () {
              Get.to(() => PrescriptionScreen());
            },
          ),
          FunctionIconButton(
            icon: Icons.favorite,
            onPressed: () {
              Get.to(() => FavoriteScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        final ProductsController products = Get.put(ProductsController());
        if (myList.isNotEmpty) {
          return BodyShape(
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              gridDelegate: SharedFunctions.gridDelegate(2),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                Product product = myList[index];
                bool isFav = SharedFunctions.isProductFavorite(product, products);
                return ProductShape(
                  product: product,
                  isFav: isFav,
                  onTap: () {
                    Get.to(() {
                      return ProductDetails(
                        myList: myList,
                        index: index,
                      );
                    });
                  },
                  onShopTap: (bool isLiked) async {
                    if (state) {
                      bool status =
                          await SharedFunctions.onShopProductTap(product, orders, contains);
                      if (!status) {
                        SharedFunctions.snackBar(
                          title: Messages.WRONG_ERROR_TITLE,
                          message: Messages.COMMAND_ERROR_TITLE,
                        );
                      }
                    } else {
                      Get.offAll(() => LoginScreen());
                    }
                    return isLiked;
                  },
                  onFavTap: (bool isLiked) async {
                    if (state) {
                      bool status = await SharedFunctions.onFavProductTap(product, products);
                      isFav = !isFav;
                      if (!status) {
                        SharedFunctions.snackBar(
                          title: Messages.WRONG_ERROR_TITLE,
                          message: Messages.WISH_LIST_ERROR_TITLE,
                        );
                      }
                    } else {
                      Get.offAll(() => LoginScreen());
                    }
                    return isFav;
                  },
                );
              },
            ),
          );
        } else {
          return EmptyBox();
        }
      }),
    );
  }
}
