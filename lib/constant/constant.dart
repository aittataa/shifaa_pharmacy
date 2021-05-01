import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../classes/brand.dart';
import '../classes/categories.dart';
import '../classes/client.dart';
import '../classes/contain.dart';
import '../classes/favorite.dart';
import '../classes/medicine.dart';
import '../classes/order.dart';
import '../classes/prescription.dart';
import '../classes/product.dart';
import '../classes/settings.dart';
import '../classes/sub_categories.dart';
import '../provider/contains_provider.dart';
import '../provider/orders_provider.dart';
import '../provider/products_provider.dart';

class Constant {
  static const String SERVER_URL = "http://192.168.1.40/.shifaa_pharmacy";

  static Client signInClient;

  static bool get isClientLogged => Constant.signInClient != null;

  static getFavoriteProductList(controller) {
    return controller.favoriteProductsList.where((product) {
      return product.isFav == true;
    }).toList();
  }

  static getSubCategoryProductList(id, controller) {
    return controller.productsList.where((product) {
      return product.subcategoryID == id;
    }).toList();
  }

  static getSubCategoriesList(id, controller) {
    return controller.subcategoriesList.where((subcategory) {
      return subcategory.categoryID == id;
    }).toList();
  }

  static gridDelegate(int crossAxisCount) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
    );
  }
}

const String URL_SERVER = "http://192.168.1.40/.shifaa_pharmacy";

const String appTitle = "Shifaa - شفاء";
const String appDesc = "Pharmacy Delivery App";
const List<String> listTitles = ["Medicines", "Categories", "$appTitle", "Brands", "Offers"];

///Main Color
const Color mainColor = Color(0xFF0EBE60);
//const Color mainColor = Color(0xFF0FC864);
//const Color mainColor = Color(0xFF01BE6E);
//const Color mainColor = Color(0xFF10E874);
//const Color mainColor = Color(0xFF00FF04);
//const Color mainColor = Color(0xFF01CC7D);
//const Color mainColor = Color(0xFF0EBE60);
//const Color mainColor = Color(0xFF10E874);

///Back Color
const Color backColor = Color(0xFFF0F0F0);

bool isAsyncCall = false;

///Is Client Logged
bool get isClientLogged => Constant.signInClient != null;

///Device Resolution
double screenWidth = Device.screenWidth;
double screenHeight = Device.screenHeight;

///Animation Jump
int pageIndex = 2;
PageController pageController = PageController(initialPage: pageIndex);
void nextPage(index) {
  pageController.jumpToPage(index);
}

///Find Product
findProduct(List<Product> myList, String value) {
  return myList.where((product) {
    return product.name.toLowerCase().contains(value.toLowerCase()) ||
        product.price.toString().toLowerCase().contains(value.toLowerCase());
  }).toList();
}

///Find Category
findCategory(List<dynamic> myList, String value) {
  return myList.where((item) {
    return item.title.toLowerCase().contains(value.toLowerCase());
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
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      insetAnimationDuration: Duration(milliseconds: 1000),
      insetAnimationCurve: Curves.linearToEaseOut,
      title: Text(
        "$appTitle",
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

///Web Launcher
void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw Exception("Couldn't Launch $url");
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
  int id = Constant.signInClient.id;
  listOfOrders = await orderProvider.getNormalOrder(id);
  Order lastOrder;
  if (listOfOrders.isNotEmpty) {
    lastOrder = listOfOrders.first;
    if (!lastOrder.isValid) {
      bool state = await containProvider.addContain(
        Contain(
          orderID: lastOrder.id,
          productID: product.id,
        ),
      );
      if (state) {
        await orderProvider.loadOrders;
      }
    } else {
      bool state = await orderProvider.addOrder(
        Order(
          type: "NORMAL",
          clientID: id,
        ),
      );
      if (state) {
        listOfOrders = await orderProvider.getNormalOrder(id);
        if (listOfOrders.isNotEmpty) {
          bool state = await containProvider.addContain(
            Contain(
              orderID: listOfOrders.first.id,
              productID: product.id,
            ),
          );
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
        clientID: id,
      ),
    );
    if (state) {
      listOfOrders = await orderProvider.getNormalOrder(id);
      if (listOfOrders.isNotEmpty) {
        bool state = await containProvider.addContain(
          Contain(
            orderID: listOfOrders.first.id,
            productID: product.id,
          ),
        );
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
  int clientID = Constant.signInClient.id;
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
        clientID: clientID,
        productID: productID,
      ),
    );
    if (state) {
      await productProvider.loadProducts;
    }
  } else if (product.isFav) {
    bool state = await productProvider.updateFavorite(
      Favorite(
        clientID: clientID,
        productID: productID,
        status: 0,
      ),
    );
    if (state) {
      await productProvider.loadProducts;
    }
  } else {
    bool state = await productProvider.updateFavorite(
      Favorite(
        clientID: clientID,
        productID: productID,
        status: 1,
      ),
    );
    if (state) {
      await productProvider.loadProducts;
    }
  }
}

//enum rememberMode { no }

//Client signInClient;
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
