import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/medicine.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/categories_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/category_shape.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class MedicinesPage extends StatelessWidget {
  final CategoriesController categoriesController;
  final ProductsController productsController;
  const MedicinesPage({this.categoriesController, this.productsController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Medicine> myList = categoriesController.medicinesList;
      bool isNotEmpty = myList.isNotEmpty;
      if (isNotEmpty) {
        return BodyShape(
          child: GridView.builder(
            padding: EdgeInsets.all(5),
            physics: BouncingScrollPhysics(),
            gridDelegate: SharedFunctions.gridDelegate(3),
            itemCount: myList.length,
            itemBuilder: (context, index) {
              Medicine medicine = myList[index];
              return CategoryShape(
                item: medicine,
                onTap: () {
                  Get.to(
                    ProductScreen(
                      title: medicine.title,
                      myList: productsList.where((product) {
                        return product.medicineTitle == medicine.title;
                      }).toList(),
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
