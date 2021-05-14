import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/contains_controller.dart';
import 'package:shifaa_pharmacy/controllers/orders_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/details_shape.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class ProductDetails extends StatelessWidget {
  static const String id = "ProductDetailsScreen";
  final OrdersController orders = Get.put(OrdersController());
  final ContainsController contains = Get.put(ContainsController());
  final ProductsController products = Get.put(ProductsController());

  final int index;
  final List<Product> myList;
  ProductDetails({this.index, this.myList});

  final state = SharedFunctions.isClientLogged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackIconButton(color: mainColor),
        actions: [
          FunctionIconButton(
            icon: Icons.shopping_cart,
            color: mainColor,
            onPressed: () {
              Get.to(ShoppingScreen());
            },
          ),
          FunctionIconButton(
            icon: Icons.favorite,
            color: mainColor,
            onPressed: () {
              Get.to(FavoriteScreen());
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: PageController(initialPage: index),
        itemCount: myList.length,
        itemBuilder: (context, index) {
          Product product = myList[index];
          bool isFav = SharedFunctions.isProductFavorite(product, products);
          return DetailsShape(
            product: product,
            isFav: isFav,
            onShopTap: (bool isLiked) async {
              if (state) {
                bool status = SharedFunctions.onShopProductTap(product, orders, contains);
                if (!status) {
                  SharedFunctions.snackBar(
                    title: "Something Wrong",
                    message: "Enable To Add This Command",
                  );
                }
              } else {
                Get.offAll(LoginScreen());
              }
              return isLiked;
            },
            onBuyTap: () async {
              if (state) {
                bool status = await SharedFunctions.onShopProductTap(product, orders, contains);
                //print(status);
                if (status) {
                  Get.to(() => ShoppingScreen());
                } else {
                  SharedFunctions.snackBar(
                    title: "Something Wrong",
                    message: "Enable To Add This Command",
                  );
                }
              } else {
                Get.offAll(LoginScreen());
              }
            },
            onFavTap: (bool isLiked) async {
              //if (state) {
              //  onFavProductTap(product);
              //  isFav = !isFav;
              //} else {
              //  Navigator.pushNamed(context, LoginScreen.id);
              //}
              return isFav;
            },
          );
        },
      ),
    );
  }
}
