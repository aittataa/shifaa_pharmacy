import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/widget/action_button.dart';

class DetailsShape extends StatelessWidget {
  final Product product;
  final bool isFav;
  final Function onBuyTap;
  final Function onShopTap;
  final Function onFavTap;
  const DetailsShape({
    this.product,
    this.isFav,
    this.onBuyTap,
    this.onShopTap,
    this.onFavTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        product.dose == null
                            ? "${product.name}"
                            : "${product.name} \n ${product.dose}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: mainColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subtitle: Text(
                        product.mainIngredient == null
                            ? "${product.brandTitle}"
                            : "${product.mainIngredient}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: mainColor),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage("${product.picture}"),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${product.price.toStringAsFixed(2)} DH",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        if (product.subcategoryTitle != null || product.medicineTitle != null)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product.medicineTitle == null
                                        ? "${product.subcategoryTitle}"
                                        : "${product.medicineTitle}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (product.quantity != 0 && product.dosageType != null)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    "Quantity",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${product.quantity} ${product.dosageType}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Html(
                    data: product.description == null ? "" : "${product.description}",
                    style: {
                      "body": Style(
                        fontSize: FontSize(12),
                        fontWeight: FontWeight.bold,
                      )
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            color: mainColor,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ActionButton(
                    onTap: onShopTap,
                    absorbing: !product.status,
                    iconBuilder: (isLiked) {
                      return Icon(
                        product.status ? Icons.shopping_cart : Icons.remove_shopping_cart,
                        color: product.status ? Colors.white : Colors.red,
                        size: 36,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: AbsorbPointer(
                    absorbing: !product.status,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: onBuyTap,
                        child: Text(
                          product.status ? "Buy Now" : "Out Of Stack",
                          style: TextStyle(
                            color: product.status ? mainColor : Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ActionButton(
                    isLiked: isFav,
                    onTap: onFavTap,
                    iconBuilder: (isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.red : Colors.white,
                        size: 36,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
