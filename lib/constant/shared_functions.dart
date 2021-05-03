import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/classes/favorite.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/classes/settings.dart';
import 'package:shifaa_pharmacy/controllers/clients_controller.dart';
import 'package:shifaa_pharmacy/controllers/contains_controller.dart';
import 'package:shifaa_pharmacy/controllers/orders_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/screens/initial_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';

class SharedFunctions {
  static bool get isClientLogged => Constant.signInClient != null;

  static int pageIndex = 2;
  static PageController pageController = PageController(initialPage: pageIndex);
  static nextPage(index) {
    pageIndex = index;
    pageController.jumpToPage(index);
  }

  static nextScreen(ClientsController controller) async {
    final session = await SharedPreferences.getInstance();
    int id = session.getInt("id");
    if (id != null) {
      Constant.signInClient = await controller.getClientByID(id);
      bool state = session.getBool("state");
      if (state == false) {
        return LoginScreen(
          state: true,
        );
      } else {
        return InitialScreen();
      }
    } else {
      bool skip = session.getBool("skip");
      if (skip == true) {
        return InitialScreen();
      } else {
        return LoginScreen();
      }
    }
  }

  ///Find Product By Value
  static dateShape(DateTime date) => DateFormat("MMM dd, HH:mm:ss").format(date);

  ///Find Product By Value
  // static findProduct(List<Product> myList, String value) {
  //   return myList.where((product) {
  //     return product.name.toLowerCase().contains(value.toLowerCase()) ||
  //         product.price.toString().toLowerCase().contains(value.toLowerCase());
  //   }).toList();
  // }

  ///Find Category By Value
  // static findCategory(List<dynamic> myList, String value) {
  //   return myList.where((item) {
  //     return item.title.toLowerCase().contains(value.toLowerCase());
  //   }).toList();
  // }

  ///is Product in Favorite List
  static bool isProductFavorite(Product product) {
    var myProduct = favoriteProductsList.where((productFav) {
      return productFav.isFav == true && productFav.id == product.id;
    }).toList();
    return myProduct.isNotEmpty;
  }

  ///onShopProductTap
  static onShopProductTap(
    Product product,
    OrdersController orders,
    ContainsController contains,
  ) async {
    int id = Constant.signInClient.id;
    listOfOrders = await orders.getNormalOrder(id);
    Order lastOrder;
    if (listOfOrders.isNotEmpty) {
      lastOrder = listOfOrders.first;
      if (!lastOrder.isValid) {
        bool state = await contains.addContain(
          Contain(
            orderID: lastOrder.id,
            productID: product.id,
          ),
        );
        print(state);
      } else {
        bool state = await orders.addOrder(
          Order(type: "NORMAL", clientID: id),
        );
        if (state) {
          listOfOrders = await orders.getNormalOrder(id);
          if (listOfOrders.isNotEmpty) {
            bool state = await contains.addContain(
              Contain(
                orderID: listOfOrders.first.id,
                productID: product.id,
              ),
            );
            print(state);
          }
        }
      }
    } else {
      bool state = await orders.addOrder(
        Order(type: "NORMAL", clientID: id),
      );
      if (state) {
        listOfOrders = await orders.getNormalOrder(id);
        if (listOfOrders.isNotEmpty) {
          bool state = await contains.addContain(
            Contain(
              orderID: listOfOrders.first.id,
              productID: product.id,
            ),
          );
          print(state);
        }
      }
    }
  }

  ///onFavProductTap
  static onFavProductTap(Product product, ProductsController controller) async {
    int clientID = Constant.signInClient.id;
    int productID = product.id;
    bool isFav = favoriteProductsList
        .where((productFav) {
          return productFav.id == product.id;
        })
        .toList()
        .isNotEmpty;

    if (isFav == false) {
      bool state = await controller.addFavorite(
        Favorite(clientID: clientID, productID: productID),
      );
      print(state);
    } else if (product.isFav) {
      bool state = await controller.updateFavorite(
        Favorite(clientID: clientID, productID: productID, status: 0),
      );
      print(state);
    } else {
      bool state = await controller.updateFavorite(
        Favorite(clientID: clientID, productID: productID, status: 1),
      );
      print(state);
    }
  }

  ///Web Launcher
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception("Couldn't Launch $url");
    }
  }

  ///share App
  static shareApp(BuildContext context, {Settings settings}) {
    final RenderBox box = context.findRenderObject();
    final String subject = settings.website;
    Share.share(
      subject,
      subject: Constant.appTitle,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  ///Exit Function
  static Future<bool> isWillPop(context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        insetAnimationDuration: Duration(milliseconds: 1000),
        insetAnimationCurve: Curves.linearToEaseOut,
        title: Text(
          "${Constant.appTitle}",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        content: Text(
          "Are You Sure You Want To Exit ?",
          style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text("No"),
            textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            child: Text("Yes"),
            textStyle: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  static gridDelegate(int crossAxisCount) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      childAspectRatio: 1,
    );
  }
}
