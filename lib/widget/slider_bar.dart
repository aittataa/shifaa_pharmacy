import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/product_details.dart';

class SliderBar extends StatelessWidget {
  final int slideIndex;
  final List<Product> myList;
  final Function onPageChanged;
  SliderBar({this.slideIndex, this.myList, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    if (myList.isNotEmpty) {
      return SizedBox(
        height: screenWidth * 0.75,
        child: PageView.builder(
          onPageChanged: onPageChanged,
          controller: PageController(viewportFraction: 0.95, initialPage: slideIndex),
          physics: BouncingScrollPhysics(),
          itemCount: myList.length,
          itemBuilder: (context, index) {
            Product product = myList[index];
            bool state = slideIndex == index;
            bool isFav = isProductFavorite(product);
            return displayProductsForSliderBar(
              product: product,
              state: state,
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
      );
    } else {
      return SizedBox();
    }
  }
}
