import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../classes/brand.dart';
import '../classes/categories.dart';
import '../classes/client.dart';
import '../classes/contain.dart';
import '../classes/medicine.dart';
import '../classes/order.dart';
import '../classes/prescription.dart';
import '../classes/product.dart';
import '../classes/sub_categories.dart';

class Constant {
  /// TODO : REST API
  static const String SERVER_URL = "http://192.168.1.40/.shifaa_pharmacy";

  /// TODO : Sign In Client
  static Client signInClient;

  /// TODO : Constant Titles
  static const String appTitle = "Shifaa - شفاء";
  static const String appDesc = "Pharmacy Delivery App";
  static const List<String> listTitles = [
    "Medicines",
    "Categories",
    "$appTitle",
    "Brands",
    "Offers",
  ];
}

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

//bool isAsyncCall = false;

///Is Client Logged
bool get isClientLogged => Constant.signInClient != null;

///Device Resolution
double screenWidth = Get.width;
double screenHeight = Get.height;

///Error Snack Bar
errorSnackBar(BuildContext context, {String title, String message}) {
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
