import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/pages/brands_page.dart';
import 'package:shifaa_pharmacy/pages/categories_page.dart';
import 'package:shifaa_pharmacy/pages/home_page.dart';
import 'package:shifaa_pharmacy/pages/medicines_page.dart';
import 'package:shifaa_pharmacy/pages/offers_page.dart';
import 'package:shifaa_pharmacy/provider/categories_provider.dart';
import 'package:shifaa_pharmacy/provider/contains_provider.dart';
import 'package:shifaa_pharmacy/provider/orders_provider.dart';
import 'package:shifaa_pharmacy/provider/prescriptions_provider.dart';
import 'package:shifaa_pharmacy/provider/products_provider.dart';
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
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<CategoriesProvider, ProductsProvider, OrdersProvider, ContainsProvider,
        PrescriptionsProvider>(
      builder: (context, categoryProvider, productProvider, orderProvider, containProvider,
          prescriptionProvider, child) {
        categoryProvider.loadCategories;
        productProvider.loadProducts;
        orderProvider.loadOrders;
        containProvider.loadContains;
        prescriptionProvider.loadPrescriptions;
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
                MedicinesPage(),
                CategoriesPage(),
                HomePage(),
                BrandsPage(),
                OffersPage(),
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
      },
    );
  }
}
