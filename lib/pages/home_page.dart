import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/categories_provider.dart';
import 'package:shifaa_pharmacy/provider/products_provider.dart';
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
    return Consumer2<CategoriesProvider, ProductsProvider>(
      builder: (context, categoryProvider, productProvider, child) {
        categoryProvider.loadCategories;
        productProvider.loadProducts;
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
              myMedList: medicinesList,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                  nextPage(pageIndex);
                });
              },
            ),
            ProductBar(
              title: "Latest",
              myList: productsList,
            ),
            CategoriesBar(
              myCatList: categoriesList,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                  nextPage(pageIndex);
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
                  pageIndex = 3;
                  nextPage(pageIndex);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
