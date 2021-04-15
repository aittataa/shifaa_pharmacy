import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/medicine.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/split_title.dart';

class MedicineBar extends StatelessWidget {
  final List<Medicine> myMedList;
  final Function onPressed;
  MedicineBar({this.myMedList, this.onPressed});
  @override
  Widget build(BuildContext context) {
    if (myMedList.isNotEmpty) {
      return Column(
        children: [
          SplitTitle(title: "Medicine", onPressed: onPressed),
          Container(
            height: screenHeight * 0.175,
            padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 5,
              ),
              itemCount: myMedList.length,
              itemBuilder: (context, index) {
                Medicine medCategory = myMedList[index];
                List<Product> myList = productsList.where((product) {
                  return product.medicine_category_title == medCategory.title;
                }).toList();
                return displayCategories(
                  item: medCategory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          title: medCategory.title,
                          myList: myList,
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
