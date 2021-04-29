import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/product.dart';
import '../constant/constant.dart';
import '../display_function/display_function.dart';
import '../screens/login_screen.dart';
import '../screens/product_details.dart';
import '../widget/body_shape.dart';
import '../widget/empty_box.dart';

class OffersPage extends StatelessWidget {
  final controller;
  const OffersPage({this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Product> myList = controller.productsList;
      bool isNotEmpty = myList.isNotEmpty;
      if (isNotEmpty) {
        return BodyShape(
          child: GridView.builder(
            padding: EdgeInsets.all(5),
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
                    myList: myList,
                    index: index,
                  ),
                ),
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
        );
      } else {
        return EmptyBox();
      }
    });
  }
}
