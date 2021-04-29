import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/controllers/categories_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/pages/brands_page.dart';
import 'package:shifaa_pharmacy/pages/categories_page.dart';
import 'package:shifaa_pharmacy/pages/home_page.dart';
import 'package:shifaa_pharmacy/pages/medicines_page.dart';
import 'package:shifaa_pharmacy/pages/offers_page.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/bottom_navigation.dart';
import 'package:shifaa_pharmacy/widget/drawer_navigation.dart';
import 'package:shifaa_pharmacy/widget/floating_button.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';
import 'package:shifaa_pharmacy/widget/menu_button.dart';

class InitialScreen extends StatefulWidget {
  static const String id = "InitialScreen";
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  final CategoriesController categoriesController = Get.put(CategoriesController());
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => isWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "${listTitles[pageIndex]}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: MenuButtonBuilder(),
          actions: [
            FunctionIconButton(
              icon: Icons.shopping_cart,
              onPressed: () {
                Navigator.pushNamed(context, ShoppingScreen.id);
              },
            ),
            FunctionIconButton(
              icon: Icons.receipt_long,
              onPressed: () {
                Navigator.pushNamed(context, PrescriptionScreen.id);
              },
            ),
            FunctionIconButton(
              icon: Icons.favorite,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(
                      myList: favoriteProductsList.where((product) {
                        return product.isFav == true;
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        drawer: DrawerNavigation(),
        body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
              nextPage(pageIndex);
            });
          },
          children: [
            MedicinesPage(
              controller: categoriesController,
            ),
            CategoriesPage(
              controller: categoriesController,
            ),
            HomePage(),
            BrandsPage(
              controller: categoriesController,
            ),
            OffersPage(
              controller: productsController,
            ),
          ],
        ),
        floatingActionButton: ActionFloatingButton(),
        bottomNavigationBar: BottomNavigation(
          index: pageIndex,
          onTap: (index) {
            setState(() {
              pageIndex = index;
              nextPage(pageIndex);
            });
          },
        ),
      ),
    );
  }
}
