import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/medicine.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/category_shape.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/split_title.dart';

class MedicineBar extends StatelessWidget {
  final ProductsController controller;
  final myList;
  final Function onPressed;
  MedicineBar({
    this.controller,
    this.myList,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    if (myList.isNotEmpty) {
      return Column(
        children: [
          SplitTitle(
            title: Messages.LABEL_MEDICINES,
            onPressed: onPressed,
          ),
          SizedBox(
            height: screenHeight * 0.2,
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate: SharedFunctions.gridDelegate(1),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                Medicine medicine = myList[index];
                return CategoryShape(
                  item: medicine,
                  fit: BoxFit.contain,
                  onTap: () => {
                    Get.to(
                      () => ProductScreen(
                        title: medicine.title,
                        myList: controller.productsList.where((product) {
                          return product.medicineID == medicine.id;
                        }).toList(),
                      ),
                    ),
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
