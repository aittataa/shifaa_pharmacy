import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/categories_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/widget/brands_bar.dart';
import 'package:shifaa_pharmacy/widget/categories_bar.dart';
import 'package:shifaa_pharmacy/widget/medicine_bar.dart';
import 'package:shifaa_pharmacy/widget/product_bar.dart';
import 'package:shifaa_pharmacy/widget/slider_bar.dart';

class HomePage extends StatefulWidget {
  final CategoriesController categoriesController;
  final ProductsController productsController;
  const HomePage({
    this.categoriesController,
    this.productsController,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductsController productsController;
  CategoriesController categoriesController;
  @override
  void initState() {
    super.initState();
    slideIndex = 0;
    categoriesController = widget.categoriesController;
    productsController = widget.productsController;
  }

  int slideIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SliderBar(
          controller: productsController,
          slideIndex: slideIndex,
          myList: productsController.productsList.where((product) {
            return product.featured == true;
          }).toList(),
          onPageChanged: (index) {
            setState(() => {slideIndex = index});
          },
        ),
        MedicineBar(
          controller: productsController,
          myList: categoriesController.medicinesList,
          onPressed: () {
            setState(() {
              SharedFunctions.nextPage(0);
            });
          },
        ),
        ProductBar(
          controller: productsController,
          title: Messages.TITLE_LATEST,
          myList: productsController.productsList,
        ),
        CategoriesBar(
          myList: categoriesController.categoriesList,
          onPressed: () {
            setState(() {
              SharedFunctions.nextPage(1);
            });
          },
        ),
        ProductBar(
          controller: productsController,
          title: Messages.TITLE_POPULAR,
          myList: productsController.productsList.where((product) => product.isShop > 0).toList()
            ..sort((a, b) => b.isShop.compareTo(a.isShop)),
        ),
        BrandsBar(
          controller: productsController,
          myList: categoriesController.brandsList,
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
