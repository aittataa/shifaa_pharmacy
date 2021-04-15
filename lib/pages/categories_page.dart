import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/categories_provider.dart';
import 'package:shifaa_pharmacy/screens/subcategories_screen.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool isNotEmpty;
  List<Categories> myList = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    myList = categoriesList;
    isNotEmpty = myList.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, categoryProvider, child) {
        categoryProvider.loadCategories;
        if (isNotEmpty) {
          return BodyShape(
            controller: controller,
            onPressed: () {
              setState(() {
                controller.clear();
                myList = categoriesList;
              });
            },
            onChanged: (value) {
              setState(() {
                myList = categoriesList.where((category) {
                  return category.title.toLowerCase().contains(value.toLowerCase());
                }).toList();
              });
            },
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
                          category: category,
                          myList: subcategoriesList.where((subcategory) {
                            return subcategory.category_id == category.id;
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
      },
    );
  }
}
