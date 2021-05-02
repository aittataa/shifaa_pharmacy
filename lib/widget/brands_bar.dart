import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/brand.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/category_shape.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/split_title.dart';

class BrandsBar extends StatelessWidget {
  final ProductsController controller;
  final List<Brand> myList;
  final Function onPressed;
  BrandsBar({
    this.controller,
    this.myList,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    if (myList.isNotEmpty) {
      return Column(
        children: [
          SplitTitle(
            title: "Brands",
            onPressed: onPressed,
          ),
          SizedBox(
            height: screenHeight * 0.2,
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SharedFunctions.gridDelegate(1),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                Brand brand = myList[index];
                return CategoryShape(
                  item: brand,
                  fit: BoxFit.fill,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          title: brand.title,
                          myList: controller.productsList.where((product) {
                            return product.brandID == brand.id;
                          }).toList(),
                        ),
                      ),
                    );
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
