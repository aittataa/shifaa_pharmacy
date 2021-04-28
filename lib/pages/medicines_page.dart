import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/medicine.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/controllers/categories_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class MedicinesPage extends StatelessWidget {
  // final CategoriesController categoriesController = Get.put(CategoriesController());
  final CategoriesController controller;
  const MedicinesPage({this.controller});

  //bool isNotEmpty = true;
  //List<Medicine> myList = [];
  //TextEditingController controller = TextEditingController();
  @override
  //void initState() {
  //  super.initState();
  //  //myList = medicinesList;
  //  //isNotEmpty = myList.isNotEmpty;
  //}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Medicine> myList = controller.medicinesList;
      bool isNotEmpty = myList.isNotEmpty;
      if (isNotEmpty) {
        return BodyShape(
          //controller: controller,
          //onPressed: () {
          //  setState(() {
          //    controller.clear();
          //    myList = medicinesList;
          //  });
          //},
          //onChanged: (value) {
          //  setState(() {
          //    myList = findCategory(medicinesList, value);
          //  });
          //},
          child: GridView.builder(
            padding: EdgeInsets.all(5),
            physics: BouncingScrollPhysics(),
            gridDelegate: Constant.gridDelegate(3),
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
                          return product.medicineTitle == medicine.title;
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
