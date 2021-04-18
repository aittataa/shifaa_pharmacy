import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/classes/sub_categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/widget/action_button.dart';
import 'package:shifaa_pharmacy/widget/divider_line.dart';

displayProduct({
  Product product,
  bool isFav,
  Function onTap,
  Function onShopTap,
  Function onFavTap,
}) {
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

displayProductDetails({
  Product product,
  bool isFav,
  Function onBuyTap,
  Function onShopTap,
  Function onFavTap,
}) {
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

displayProductsForSliderBar({
  Product product,
  bool state,
  bool isFav,
  Function onTap,
  Function onShopTap,
  Function onFavTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
      margin: EdgeInsets.only(
        top: state ? 15 : 30,
        bottom: state ? 15 : 30,
        left: 2,
        right: 8,
      ),
      decoration: BoxDecoration(
        color: mainColor,
        border: Border.all(color: mainColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          if (state)
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 1,
              blurRadius: 10,
            ),
        ],
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
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${product.name}",
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

displayCategories({
  var item,
  BoxFit fit,
  Function onTap,
}) {
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(fit: fit, image: NetworkImage("${item.picture}")),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
            child: Text(
              "${item.title}",
              softWrap: false,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

displaySubCategories({
  SubCategories subCategory,
  bool option,
  Function onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: option ? mainColor : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        "${subCategory.title}",
        style: TextStyle(
          color: option ? Colors.white : Colors.black26,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

dateShape(DateTime date) => DateFormat("MMM dd, HH:mm:ss").format(date);

displayShippingList({
  Order order,
  Function onTap,
  List<Contain> myContainList,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      children: [
        Text(
          "Order : ",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            "${dateShape(order.dateOrder)}",
            softWrap: false,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "${order.total.toStringAsFixed(2)} DH",
            textAlign: TextAlign.end,
            softWrap: false,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 5),
          child: GestureDetector(
            onTap: order.isValid ? null : onTap,
            child: Image.asset(
              order.isValid ? "images/check.png" : "images/right.png",
              color: mainColor,
              width: 22,
              height: 22,
            ),
          ),
        ),
      ],
    ),
  );
}

displayContain({
  Contain contain,
  bool isValid,
  Function onTap,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "${contain.productName}",
            softWrap: false,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "${contain.productPrice.toStringAsFixed(2)} DH",
          softWrap: false,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 5),
          child: GestureDetector(
            onTap: isValid ? null : onTap,
            child: Image.asset(
              "images/delete.png",
              color: isValid ? Colors.transparent : Colors.red,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

displayPrescriptionList({
  Order order,
  Function onTap,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            "Prescriptions : ",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "${order.total.toInt()} Items",
          softWrap: false,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 5),
          child: GestureDetector(
            onTap: order.isValid ? null : onTap,
            child: Image.asset(
              order.isValid ? "images/check.png" : "images/right.png",
              color: mainColor,
              width: 22,
              height: 22,
            ),
          ),
        ),
      ],
    ),
  );
}

displayPrescription({
  Prescription prescription,
  bool isValid,
  Function onTap,
  Function onLongPress,
}) {
  return GestureDetector(
    onLongPress: onLongPress,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${prescription.description}",
              softWrap: false,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "${dateShape(prescription.date)}",
            softWrap: false,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 5),
            child: GestureDetector(
              onTap: isValid ? null : onTap,
              child: Image.asset(
                "images/delete.png",
                color: isValid ? Colors.transparent : Colors.red,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
