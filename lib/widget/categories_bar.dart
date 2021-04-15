import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/classes/sub_categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/subcategories_screen.dart';
import 'package:shifaa_pharmacy/widget/split_title.dart';

class CategoriesBar extends StatelessWidget {
  final List<Categories> myCatList;
  final Function onPressed;
  CategoriesBar({this.myCatList, this.onPressed});
  @override
  Widget build(BuildContext context) {
    if (myCatList.isNotEmpty) {
      return Column(
        children: [
          SplitTitle(title: "Categories", onPressed: onPressed),
          Container(
            height: screenHeight * 0.25,
            padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 5,
              ),
              itemCount: myCatList.length,
              itemBuilder: (context, index) {
                Categories category = myCatList[index];
                List<SubCategories> myList = subcategoriesList.where((subcategory) {
                  return subcategory.category_id == category.id;
                }).toList();
                return displayCategories(
                  item: category,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCategoriesScreen(
                          myList: myList,
                          category: category,
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
