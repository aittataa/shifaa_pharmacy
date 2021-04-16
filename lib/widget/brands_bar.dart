import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/brand.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/split_title.dart';

class BrandsBar extends StatelessWidget {
  final List<Brand> myBrandList;
  final Function onPressed;
  BrandsBar({this.myBrandList, this.onPressed});
  @override
  Widget build(BuildContext context) {
    if (myBrandList.isNotEmpty) {
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 5,
              ),
              itemCount: myBrandList.length,
              itemBuilder: (context, index) {
                Brand brand = myBrandList[index];
                return displayCategories(
                  item: brand,
                  fit: BoxFit.fill,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          title: brand.title,
                          myList: productsList.where((product) {
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
