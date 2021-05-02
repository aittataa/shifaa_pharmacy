import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/display_function/product_shape.dart';
import 'package:shifaa_pharmacy/screens/product_details.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/split_title.dart';

class ProductBar extends StatelessWidget {
  final String title;
  final List<Product> myList;
  ProductBar({this.title, this.myList});

  @override
  Widget build(BuildContext context) {
    if (myList.isNotEmpty) {
      return Column(
        children: [
          SplitTitle(
            title: title,
            onPressed: () => Get.to(() => ProductScreen(title: title, myList: myList)),
          ),
          SizedBox(
            height: screenHeight * 0.3,
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SharedFunctions.gridDelegate(1),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                Product product = myList[index];
                bool isFav = SharedFunctions.isProductFavorite(product);
                return ProductShape(
                  product: product,
                  isFav: isFav,
                  onTap: () => Get.to(() => ProductDetails(index: index, myList: myList)),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
