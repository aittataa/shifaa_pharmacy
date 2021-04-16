import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
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
            title: "Categories",
            onPressed: onPressed,
          ),
          SizedBox(
            height: screenHeight * 0.25,
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
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
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
