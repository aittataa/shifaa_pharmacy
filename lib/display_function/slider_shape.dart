import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/widget/action_button.dart';

class SliderShape extends StatelessWidget {
  final Product product;
  final bool state;
  final bool isFav;
  final Function onTap;
  final Function onShopTap;
  final Function onFavTap;

  const SliderShape({
    this.product,
    this.state,
    this.isFav,
    this.onTap,
    this.onShopTap,
    this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
        margin: EdgeInsets.fromLTRB(2, 5, 8, state ? 5 : 50),
        decoration: BoxDecoration(
          color: mainColor,
          border: Border.all(color: mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: NetworkImage("${product.picture}")),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ActionButton(
                            onTap: onShopTap,
                            absorbing: !product.status,
                            iconBuilder: (isLiked) {
                              return Icon(
                                product.status ? Icons.shopping_cart : Icons.remove_shopping_cart,
                                color: product.status ? Colors.white : Colors.red,
                                size: 40,
                              );
                            },
                          ),
                          ActionButton(
                            isLiked: isFav,
                            onTap: onFavTap,
                            iconBuilder: (isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.red : Colors.white,
                                size: 40,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${product.name}",
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
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
