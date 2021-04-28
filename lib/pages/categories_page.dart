import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/controllers/categories_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/subcategories_screen.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class CategoriesPage extends StatelessWidget {
  final CategoriesController controller;
  const CategoriesPage({this.controller});
  //bool isNotEmpty;
  //List<Categories> myList = [];
  //TextEditingController controller = TextEditingController();
  //@override
  //void initState() {
  //  super.initState();
  //  myList = categoriesList;
  //  isNotEmpty = myList.isNotEmpty;
  //}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Categories> myList = controller.categoriesList;
      bool isNotEmpty = myList.isNotEmpty;
      if (isNotEmpty) {
        return BodyShape(
          //controller: controller,
          //onPressed: () {
          //  setState(() {
          //    controller.clear();
          //    myList = categoriesList;
          //  });
          //},
          //onChanged: (value) {
          //  setState(() {
          //    myList = findCategory(categoriesList, value);
          //  });
          //},
          child: GridView.builder(
            padding: EdgeInsets.all(5),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: myList.length,
            itemBuilder: (context, index) {
              Categories category = myList[index];
              return displayCategories(
                item: category,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubCategoriesScreen(
                        title: category.title,
                        myList: subcategoriesList.where((subcategory) {
                          return subcategory.categoryID == category.id;
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
