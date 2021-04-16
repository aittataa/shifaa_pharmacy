import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/medicine.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/categories_provider.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class MedicinesPage extends StatefulWidget {
  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  bool isNotEmpty;
  List<Medicine> myList = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    myList = medicinesList;
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
                myList = medicinesList;
              });
            },
            onChanged: (value) {
              setState(() {
                myList = findCategory(medicinesList, value);
              });
            },
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
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
      },
    );
  }
}
