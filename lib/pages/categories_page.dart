import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/categories_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/subcategories_screen.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class CategoriesPage extends StatelessWidget {
  final CategoriesController controller;
  const CategoriesPage({this.controller});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Categories> myList = controller.categoriesList;
      bool isNotEmpty = myList.isNotEmpty;
      if (isNotEmpty) {
        return BodyShape(
          child: GridView.builder(
            padding: EdgeInsets.all(5),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SharedFunctions.gridDelegate(3),
            itemCount: myList.length,
            itemBuilder: (context, index) {
              Categories category = myList[index];
              return displayCategories(
                item: category,
                onTap: () {
                  Get.to(SubCategoriesScreen(category: category));
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
