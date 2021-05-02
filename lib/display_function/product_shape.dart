import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/widget/action_button.dart';
import 'package:shifaa_pharmacy/widget/divider_line.dart';

class ProductShape extends StatelessWidget {
  final Product product;
  final bool isFav;
  final Function onTap;
  final Function onShopTap;
  final Function onFavTap;
  const ProductShape({
    this.product,
    this.isFav,
    this.onTap,
    this.onShopTap,
    this.onFavTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(image: NetworkImage("${product.picture}")),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ActionButton(
                          onTap: onShopTap,
                          absorbing: !product.status,
                          size: 30,
                          iconBuilder: (isLiked) {
                            return Icon(
                              product.status ? Icons.shopping_cart : Icons.remove_shopping_cart,
                              color: product.status ? Colors.white : Colors.red,
                              size: 30,
                            );
                          },
                        ),
                        ActionButton(
                          isLiked: isFav,
                          onTap: onFavTap,
                          size: 30,
                          iconBuilder: (isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.white,
                              size: 30,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
              child: Column(
                children: [
                  Text(
                    "${product.name}",
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DividerLine(value: screenWidth * 0.1),
                  Text(
                    "${product.price.toStringAsFixed(2)} DH",
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
