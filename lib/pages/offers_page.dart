import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';

import '../classes/product.dart';
import '../display_function/display_function.dart';
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
            gridDelegate: SharedFunctions.gridDelegate(2),
            itemCount: myList.length,
            itemBuilder: (context, index) {
              Product product = myList[index];
              bool isFav = SharedFunctions.isProductFavorite(product);
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
                  //if (isClientLogged) {
                  //  SharedFunctions.onShopProductTap(
                  //    product,
                  //    OrdersController(),
                  //    controller,
                  //  );
                  //} else {
                  //  Navigator.popAndPushNamed(context, LoginScreen.id);
                  //}
                  return isLiked;
                },
                onFavTap: (bool isLiked) async {
                  //if (isClientLogged) {
                  //  SharedFunctions.onFavProductTap(product,controller);
                  //  isFav = !isFav;
                  //} else {
                  //Navigator.popAndPushNamed(context, LoginScreen.id);
                  //}
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
