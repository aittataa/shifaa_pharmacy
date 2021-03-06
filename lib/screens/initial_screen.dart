import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/categories_controller.dart';
import 'package:shifaa_pharmacy/controllers/clients_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/pages/brands_page.dart';
import 'package:shifaa_pharmacy/pages/categories_page.dart';
import 'package:shifaa_pharmacy/pages/home_page.dart';
import 'package:shifaa_pharmacy/pages/medicines_page.dart';
import 'package:shifaa_pharmacy/pages/offers_page.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
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
  final ClientsController clientsController = Get.put(ClientsController());
  final CategoriesController categoriesController = Get.put(CategoriesController());
  final ProductsController productsController = Get.put(ProductsController());
  @override
  void initState() {
    super.initState();
    Constant.pageController = PageController(initialPage: Constant.pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SharedFunctions.isWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            Constant.listTitles[Constant.pageIndex],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: MenuButtonBuilder(),
          actions: [
            FunctionIconButton(
              icon: Icons.shopping_cart,
              onPressed: () async {
                //print("hello world");
                //print(Constant.signInClient.id);
                productsController.loadProducts;
                //print(productsController.favoriteProductsList.toList().length);
                //Get.to(() => ShoppingScreen());
              },
            ),
            FunctionIconButton(
              icon: Icons.receipt_long,
              onPressed: () {
                Get.to(PrescriptionScreen());
              },
            ),
            FunctionIconButton(
              icon: Icons.favorite,
              onPressed: () {
                Get.to(FavoriteScreen());
              },
            ),
          ],
        ),
        drawer: DrawerNavigation(
          controller: clientsController,
        ),
        body: PageView(
          controller: Constant.pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() => SharedFunctions.nextPage(index));
          },
          children: [
            MedicinesPage(
              categoriesController: categoriesController,
              productsController: productsController,
            ),
            CategoriesPage(
              controller: categoriesController,
            ),
            HomePage(
              categoriesController: categoriesController,
              productsController: productsController,
            ),
            BrandsPage(
              categoriesController: categoriesController,
              productsController: productsController,
            ),
            OffersPage(
              controller: productsController,
            ),
          ],
        ),
        floatingActionButton: ActionFloatingButton(),
        bottomNavigationBar: BottomNavigation(
          index: Constant.pageIndex,
          onTap: (index) {
            setState(() => SharedFunctions.nextPage(index));
          },
        ),
      ),
    );
  }
}
