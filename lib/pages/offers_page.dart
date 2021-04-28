import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/product.dart';
import '../constant/constant.dart';
import '../controllers/products_controller.dart';
import '../display_function/display_function.dart';
import '../screens/login_screen.dart';
import '../screens/product_details.dart';
import '../widget/body_shape.dart';

class OffersPage extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return BodyShape(
      child: Obx(() {
        return GridView.builder(
          padding: EdgeInsets.all(5),
          physics: BouncingScrollPhysics(),
          gridDelegate: Constant.gridDelegate(2),
          itemCount: productsController.productsList.length,
          itemBuilder: (context, index) {
            Product product = productsController.productsList[index];
            bool isFav = isProductFavorite(product);
            return displayProduct(
              product: product,
              isFav: isFav,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      myList: productsController.productsList,
                      initialIndex: index,
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
        );
      }),
    );
  }
}
