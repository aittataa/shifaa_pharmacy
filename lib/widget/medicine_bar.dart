import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/medicine.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/split_title.dart';

class MedicineBar extends StatelessWidget {
  final List<dynamic> myList;
  final Function onPressed;
  MedicineBar({
    this.myList,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    if (myList.isNotEmpty) {
      return Column(
        children: [
          SplitTitle(
            title: "Medicine",
            onPressed: onPressed,
          ),
          SizedBox(
            height: screenHeight * 0.175,
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
                Medicine medicine = myList[index];
                return displayCategories(
                  item: medicine,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          title: medicine.title,
                          myList: productsList.where((product) {
                            return product.medicineID == medicine.id;
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
