import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/classes/favorite.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/classes/settings.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
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

  static nextPage(index) {
    Constant.pageIndex = index;
    Constant.pageController.jumpToPage(index);
  }

  static nextScreen(ClientsController controller) async {
    final session = await SharedPreferences.getInstance();
    int id = session.getInt("id");
    if (id != null) {
      Constant.signInClient = await controller.getClientByID(id);
      bool state = session.getBool("state");
      if (state == false) {
        return LoginScreen(state: true);
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

  ///Date Shape
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

  ///onShopProductTap
  static onShopProductTap(
    Product product,
    OrdersController orders,
    ContainsController contains,
  ) async {
    int id = Constant.signInClient.id;
    List<Order> listOfOrders = await orders.getNormalOrder(id);
    Order lastOrder;
    if (listOfOrders.isNotEmpty) {
      lastOrder = listOfOrders.first;
      if (!lastOrder.isValid) {
        return await contains.addContain(
          Contain(orderID: lastOrder.id, productID: product.id),
        );
      } else {
        bool state = await orders.addOrder(
          Order(type: "NORMAL", clientID: id),
        );
        if (state) {
          listOfOrders = await orders.getNormalOrder(id);
          if (listOfOrders.isNotEmpty) {
            return await contains.addContain(
              Contain(orderID: listOfOrders.first.id, productID: product.id),
            );
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
          return await contains.addContain(
            Contain(orderID: listOfOrders.first.id, productID: product.id),
          );
        }
      }
    }
  }

  ///is Product in Favorite List
  static bool isProductFavorite(Product product, ProductsController controller) {
    return controller.favoriteProductsList
        .where((favorite) {
          return favorite.productID == product.id;
          // && favorite.status == 1;
        })
        .toList()
        .isNotEmpty;
  }

  ///onFavProductTap
  static onFavProductTap(Product product, ProductsController controller) async {
    int clientID = Constant.signInClient.id;
    int productID = product.id;
    bool isFav = controller.favoriteProductsList
        .where((productFav) {
          return productFav.id == product.id;
        })
        .toList()
        .isNotEmpty;

    if (isFav == false) {
      return await controller.addFavorite(
        Favorite(clientID: clientID, productID: productID),
      );
    }
    /*
    else if (product.isFav) {
      return await controller.updateFavorite(
        Favorite(clientID: clientID, productID: productID, status: 0),
      );
    } else {
      return await controller.updateFavorite(
        Favorite(clientID: clientID, productID: productID, status: 1),
      );
    }
    */
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
      subject: Messages.APP_TITLE,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  ///Exit Function
  static Future<bool> isWillPop(context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        insetAnimationDuration: Constant.durationCupertinoAlertDialog,
        insetAnimationCurve: Constant.curve,
        title: Text(
          Messages.APP_TITLE,
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        content: Text(
          "Are You Sure You Want To Exit ?",
          style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 15),
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

  ///For GRidView
  static gridDelegate(int crossAxisCount) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      childAspectRatio: 1,
    );
  }

  ///Error Snack Bar
  static snackBar({String title, String message}) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      titleText: Text(title, style: TextStyle(fontWeight: FontWeight.w900)),
      messageText: Text(message, style: TextStyle(fontWeight: FontWeight.bold)),
      icon: Icon(Icons.error, color: Colors.red.shade900, size: 36),
      margin: EdgeInsets.all(10),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
