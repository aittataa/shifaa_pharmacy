import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    title: title,
                    myList: myList,
                  ),
                ),
              );
            },
          ),
          Container(
            height: screenHeight * 0.3,
            padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 5,
              ),
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
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
