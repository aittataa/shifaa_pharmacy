import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class ProductDetails extends StatelessWidget {
  static const String id = "ProductDetailsScreen";
  final ProductsController controller = Get.put(ProductsController());
  final int index;
  final List<Product> myList;
  ProductDetails({this.index, this.myList});

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
          bool isFav = isProductFavorite(product);
          return displayProductDetails(
            product: product,
            isFav: isFav,
            onShopTap: (bool isLiked) async {
              if (isClientLogged) {
                onShopProductTap(product, context);
              } else {
                Navigator.pushNamed(context, LoginScreen.id);
              }
              return isLiked;
            },
            onBuyTap: () {
              if (isClientLogged) {
                onShopProductTap(product, context);
                Navigator.pushNamed(context, ShoppingScreen.id);
              } else {
                Navigator.pushNamed(context, LoginScreen.id);
              }
            },
            onFavTap: (bool isLiked) async {
              if (isClientLogged) {
                onFavProductTap(product);
                isFav = !isFav;
              } else {
                Navigator.pushNamed(context, LoginScreen.id);
              }
              return isFav;
            },
          );
        },
      ),
    );
  }
}
