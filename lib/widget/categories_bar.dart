import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/display_function/category_shape.dart';
import 'package:shifaa_pharmacy/screens/subcategories_screen.dart';
import 'package:shifaa_pharmacy/widget/split_title.dart';

class CategoriesBar extends StatelessWidget {
  final List<Categories> myList;
  final Function onPressed;
  CategoriesBar({this.myList, this.onPressed});
  @override
  Widget build(BuildContext context) {
    if (myList.isNotEmpty) {
      return Column(
        children: [
          SplitTitle(
            title: Messages.LABEL_CATEGORIES,
            onPressed: onPressed,
          ),
          SizedBox(
            height: screenHeight * 0.25,
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SharedFunctions.gridDelegate(1),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                Categories category = myList[index];
                return CategoryShape(
                  item: category,
                  onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
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
