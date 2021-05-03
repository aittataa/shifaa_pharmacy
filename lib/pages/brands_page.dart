import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/brand.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/categories_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/category_shape.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class BrandsPage extends StatelessWidget {
  final CategoriesController categoriesController;
  final ProductsController productsController;
  const BrandsPage({this.categoriesController, this.productsController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Brand> myList = categoriesController.brandsList;
      bool isNotEmpty = myList.isNotEmpty;
      if (isNotEmpty) {
        return BodyShape(
          child: GridView.builder(
            padding: EdgeInsets.all(5),
            physics: BouncingScrollPhysics(),
            gridDelegate: SharedFunctions.gridDelegate(3),
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
                        myList: productsController.productsList.where((product) {
                          return product.brandTitle == brand.title;
                        }).toList(),
                      ),
                    ),
                  );
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
