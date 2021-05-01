import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/widget/brands_bar.dart';
import 'package:shifaa_pharmacy/widget/categories_bar.dart';
import 'package:shifaa_pharmacy/widget/medicine_bar.dart';
import 'package:shifaa_pharmacy/widget/product_bar.dart';
import 'package:shifaa_pharmacy/widget/slider_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    slideIndex = 0;
  }

  int slideIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SliderBar(
          slideIndex: slideIndex,
          myList: productsList.where((product) {
            return product.featured == true;
          }).toList(),
          onPageChanged: (index) {
            setState(() => {slideIndex = index});
          },
        ),
        MedicineBar(
          myList: medicinesList,
          onPressed: () {
            setState(() {
              SharedFunctions.nextPage(0);
            });
          },
        ),
        ProductBar(
          title: "Latest",
          myList: productsList,
        ),
        CategoriesBar(
          myList: categoriesList,
          onPressed: () {
            setState(() {
              SharedFunctions.nextPage(1);
            });
          },
        ),
        ProductBar(
          title: "Popular",
          myList: productsList.where((product) => product.isShop > 0).toList()
            ..sort((a, b) => b.isShop.compareTo(a.isShop)),
        ),
        BrandsBar(
          myBrandList: brandsList,
          onPressed: () {
            setState(() {
              SharedFunctions.nextPage(3);
            });
          },
        ),
      ],
    );
  }
}
