import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';

import '../classes/product.dart';
import '../constant/constant.dart';
import '../display_function/display_function.dart';
import '../screens/favorite_screen.dart';
import '../screens/login_screen.dart';
import '../screens/prescription_screen.dart';
import '../screens/product_details.dart';
import '../screens/shopping_screen.dart';
import '../widget/back_icon.dart';
import '../widget/body_shape.dart';
import '../widget/function_button.dart';

class ProductScreen extends StatelessWidget {
  static const String id = "ProductScreen";
  final ProductsController controller = Get.put(ProductsController());
  final String title;
  final List<Product> myList;
  ProductScreen({this.title, this.myList});

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
              Get.to(ShoppingScreen());
            },
          ),
          FunctionIconButton(
            icon: Icons.receipt_long,
            onPressed: () {
              Get.to(PrescriptionScreen());
            },
          ),
          FunctionIconButton(
            icon: Icons.favorite,
            onPressed: () {
              Get.to(FavoriteScreen());
            },
          ),
        ],
      ),
      body: BodyShape(
        child: GridView.builder(
          padding: EdgeInsets.all(5),
          physics: BouncingScrollPhysics(),
          gridDelegate: SharedFunctions.gridDelegate(2),
          itemCount: myList.length,
          itemBuilder: (context, index) {
            Product product = myList[index];
            bool isFav = isProductFavorite(product);
            return displayProduct(
              product: product,
              isFav: isFav,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      myList: myList,
                      index: index,
                    ),
                  ),
                );
              },
              onShopTap: (bool isLiked) async {
                if (isClientLogged) {
                  onShopProductTap(product, context);
                } else {
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                }
                return isLiked;
              },
              onFavTap: (bool isLiked) async {
                if (isClientLogged) {
                  onFavProductTap(product);
                  isFav = !isFav;
                } else {
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                }
                return isFav;
              },
            );
          },
        ),
      ),
    );
  }
}
