import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:share/share.dart';
import 'package:shifaa_pharmacy/classes/brand.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/classes/favorite.dart';
import 'package:shifaa_pharmacy/classes/medicine.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/classes/settings.dart';
import 'package:shifaa_pharmacy/classes/sub_categories.dart';
import 'package:shifaa_pharmacy/provider/contains_provider.dart';
import 'package:shifaa_pharmacy/provider/orders_provider.dart';
import 'package:shifaa_pharmacy/provider/products_provider.dart';
import 'package:url_launcher/url_launcher.dart';

//const String URL_SERVER = "http://onlinewallpaper.online/aittataa/shifaa_pharmacy";
const String URL_SERVER = "http://192.168.1.33/.shifaa_pharmacy";

const String appTitle = "Shifaa - شفاء";
const String appDesc = "Pharmacy Delivery App";
const List<String> listTitles = ["Medicines", "Categories", "$appTitle", "Brands", "Offers"];

///Main Color
const Color mainColor = Color(0xFF0FC864);
//const Color mainColor = Color(0xFF00FF04);
//const Color mainColor = Color(0xFF01BE6E);
//const Color mainColor = Color(0xFF01CC7D);
//const Color mainColor = Color(0xFF0EBE60);
//const Color mainColor = Color(0xFF10E874);

///Back Color
const Color backColor = Color(0xFFF0F0F0);

bool isAsyncCall = false;

///Is Client Logged
bool get isClientLogged => signInClient != null;

///Device Resolution
double screenWidth = Device.screenWidth;
double screenHeight = Device.screenHeight;

///Animation Jump
int pageIndex = 2;
PageController pageController = PageController(initialPage: pageIndex);
void nextPage(index) {
  pageController.jumpToPage(index);
}

//TextEditingController searchController = TextEditingController();
///Find Product
findProduct(List<Product> myList, String value) {
  return myList.where((product) {
    return product.name.toLowerCase().contains(value.toLowerCase()) ||
        product.price.toString().toLowerCase().contains(value.toLowerCase());
  }).toList();
}

///Error Snack Bar
errorSnackBar(BuildContext context, {String title, String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.red,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1500),
      content: ListTile(
        leading: Icon(Icons.cancel, color: Colors.red.shade900, size: 36),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(message, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    ),
  );
}

///Exit Function
Future<bool> isWillPop(context) {
  return showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
        "$appTitle",
        style: TextStyle(
          color: mainColor,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
      content: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          "Are You Sure You Want To Exit ?",
          style: TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
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
          //onPressed: () => Navigator.of(context).pop(true),
          onPressed: () => exit(0),
        ),
      ],
    ),
  );
}

///Web Launcher
void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("Could not launch $url");
  }
}

///share App
void shareApp(BuildContext context, {Settings settings}) {
  final RenderBox box = context.findRenderObject();
  final String subject = settings.website;
  Share.share(
    subject,
    subject: appTitle,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}

///onShopProductTap
void onShopProductTap(Product product, context) async {
  OrdersProvider orderProvider = OrdersProvider();
  ContainsProvider containProvider = ContainsProvider();
  int id = signInClient.id;
  listOfOrders = await orderProvider.getNormalOrder(id);

  Order lastOrder;
  if (listOfOrders.isNotEmpty) {
    lastOrder = listOfOrders.first;
    if (!lastOrder.isValid) {
      bool state = await containProvider.addContain(Contain(
        order_id: lastOrder.id,
        product_id: product.id,
      ));
      if (state) {
        await orderProvider.loadOrders;
      }
    } else {
      bool state = await orderProvider.addOrder(
        Order(
          type: "NORMAL",
          client_id: id,
        ),
      );
      if (state) {
        listOfOrders = await orderProvider.getNormalOrder(id);
        if (listOfOrders.isNotEmpty) {
          bool state = await containProvider.addContain(Contain(
            order_id: listOfOrders.first.id,
            product_id: product.id,
          ));
          if (state) {
            await orderProvider.loadOrders;
          }
        }
      }
    }
  } else {
    bool state = await orderProvider.addOrder(
      Order(
        type: "NORMAL",
        client_id: id,
      ),
    );
    if (state) {
      listOfOrders = await orderProvider.getNormalOrder(id);
      if (listOfOrders.isNotEmpty) {
        bool state = await containProvider.addContain(Contain(
          order_id: listOfOrders.first.id,
          product_id: product.id,
        ));
        if (state) {
          await orderProvider.loadOrders;
        }
      }
    }
  }
}

///is Product in Favorite List
bool isProductFavorite(Product product) {
  var myProduct = favoriteProductsList.where((productFav) {
    return productFav.isFav == true && productFav.id == product.id;
  }).toList();
  return myProduct.isNotEmpty;
}

///onFavProductTap
void onFavProductTap(Product product) async {
  ProductsProvider productProvider = ProductsProvider();
  int clientID = signInClient.id;
  int productID = product.id;
  bool isFav = favoriteProductsList
      .where((productFav) {
        return productFav.id == product.id;
      })
      .toList()
      .isNotEmpty;

  if (isFav == false) {
    bool state = await productProvider.addFavorite(
      Favorite(
        client_id: clientID,
        product_id: productID,
      ),
    );
    if (state) {
      await productProvider.loadProducts;
    }
  } else if (product.isFav) {
    bool state = await productProvider.updateFavorite(
      Favorite(
        client_id: clientID,
        product_id: productID,
        status: 0,
      ),
    );
    if (state) {
      await productProvider.loadProducts;
    }
  } else {
    bool state = await productProvider.updateFavorite(
      Favorite(
        client_id: clientID,
        product_id: productID,
        status: 1,
      ),
    );
    if (state) {
      await productProvider.loadProducts;
    }
  }
}

enum rememberMode { no }

Settings appSettings;

Client signInClient;
List<Client> myClientsList = [];

List<Product> productsList = [];
List<Product> favoriteProductsList = [];

List<Medicine> medicinesList = [];
List<Categories> categoriesList = [];
List<SubCategories> subcategoriesList = [];
List<Brand> brandsList = [];

List<Order> listOfOrders = [];
List<Order> myShoppingList = [];
List<Contain> containList = [];

List<Order> listOfPrescriptions = [];
List<Order> myPrescriptionList = [];
List<Prescription> prescriptionList = [];
