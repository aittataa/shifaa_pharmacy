import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
import 'package:shifaa_pharmacy/constant/constant.dart';

class DataBaseProvider extends ChangeNotifier {
  static Uri _api = Uri.parse("$URL_SERVER/api.php");

  static const String _FROM_APP = "FROM_APP";
  static const String _GET_ALL_PRODUCT = "GET_ALL_PRODUCT";
  static const String _GET_MEDICINE_CATEGORIES = "GET_MEDICINE_CATEGORIES";
  static const String _GET_CATEGORIES = "GET_CATEGORIES";
  static const String _GET_SUB_CATEGORIES = "GET_SUB_CATEGORIES";
  static const String _GET_BRANDS = "GET_BRANDS";

  static get getAllProduct async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_ALL_PRODUCT;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Product.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static get getMedicineCategories async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_MEDICINE_CATEGORIES;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Medicine.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static get getCategories async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_CATEGORIES;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Categories.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static get getSubCategories async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_SUB_CATEGORIES;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => SubCategories.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static get getAllBrands async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_BRANDS;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Brand.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static const String _GET_ALL_CLIENTS = "GET_ALL_CLIENTS";
  static const String _GET_CLIENT_BY_ID = "GET_CLIENT_BY_ID";
  static const String _GET_CLIENT_BY_INFO = "GET_CLIENT_BY_INFO";
  static const String _ADD_CLIENT = "ADD_CLIENT";
  static const String _UPDATE_CLIENT_INFO = "UPDATE_CLIENT_INFO";
  static const String _UPDATE_CLIENT_ADDRESS = "UPDATE_CLIENT_ADDRESS";

  static get getAllClients async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_ALL_CLIENTS;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Client.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static getClientByID(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_CLIENT_BY_ID;
    action["id"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return Client.fromJson(map.first);
    } else {
      throw Exception("No Data Found");
    }
  }

  static getClientByInfo(Client client) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_CLIENT_BY_INFO;
    action["email"] = client.email;
    action["password"] = client.password;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return Client.fromJson(map.first);
    } else {
      throw Exception("No Data Found");
    }
  }

  static addNewClient(Client client) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _ADD_CLIENT;
    action["full_name"] = client.fullname;
    action["email"] = client.email;
    action["password"] = client.password;
    action["phone"] = client.phone;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static updateClientInfo(Client client) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _UPDATE_CLIENT_INFO;
    action["id_client"] = client.id.toString();
    action["full_name"] = client.fullname;
    action["password"] = client.password;
    action["phone"] = client.phone;
    action["picture"] = client.picture;
    action["profile"] = client.profile;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static updateClientAddress(Client client) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _UPDATE_CLIENT_ADDRESS;
    action["id_client"] = client.id.toString();
    action["address"] = client.address;
    action["zip_code"] = client.zipCode.toString();
    action["city"] = client.city;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static const String _GET_NORMAL_ORDER = "GET_NORMAL_ORDER";
  static const String _GET_PRESCRIPTION_ORDER = "GET_PRESCRIPTION_ORDER";
  static const String _GET_SHOPPING_LIST = "GET_SHOPPING_LIST";
  static const String _GET_PRESCRIPTION_LIST = "GET_PRESCRIPTION_LIST";
  static const String _ADD_ORDER = "ADD_ORDER";
  static const String _UPDATE_ORDER = "UPDATE_ORDER";

  static getNormalOrder(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_NORMAL_ORDER;
    action["id_client"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Order.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static getShoppingList(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_SHOPPING_LIST;
    action["id_client"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Order.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static getPrescriptionOrder(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_PRESCRIPTION_ORDER;
    action["id_client"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Order.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static getPrescriptionList(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_PRESCRIPTION_LIST;
    action["id_client"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Order.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static addOrder(Order order) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _ADD_ORDER;
    action["order_type"] = order.type;
    action["client_id"] = order.client_id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static updateOrder(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _UPDATE_ORDER;
    action["id_order"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static const String _GET_CONTAIN = "GET_CONTAIN";
  static const String _ADD_CONTAIN = "ADD_CONTAIN";
  static const String _UPDATE_CONTAIN = "UPDATE_CONTAIN";

  static getContain(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_CONTAIN;
    action["id_client"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Contain.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static addContain(Contain contain) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _ADD_CONTAIN;
    action["order_id"] = contain.order_id.toString();
    action["product_id"] = contain.product_id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static updateContain(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _UPDATE_CONTAIN;
    action["id_contain"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static const String _GET_PRESCRIPTION = "GET_PRESCRIPTION";
  static const String _ADD_PRESCRIPTION = "ADD_PRESCRIPTION";
  static const String _UPDATE_PRESCRIPTION = "UPDATE_PRESCRIPTION";

  static getPrescription(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_PRESCRIPTION;
    action["id_client"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Prescription.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static addPrescription(Prescription prescription) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _ADD_PRESCRIPTION;
    action["image_file"] = prescription.file;
    action["image_name"] = prescription.picture;
    action["description"] = prescription.description;
    action["order_id"] = prescription.order_id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static updatePrescription(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _UPDATE_PRESCRIPTION;
    action["id_prescription"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static const String _GET_FAVORITE = "GET_FAVORITE";
  static const String _ADD_FAVORITE = "ADD_FAVORITE";
  static const String _UPDATE_FAVORITE = "UPDATE_FAVORITE";

  static getFavorite(int id) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_FAVORITE;
    action["id_client"] = id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var myList = json.decode(response.body);
      return List.generate(myList.length, (index) => Product.fromJson(myList[index]));
    } else {
      throw Exception("No Data Found");
    }
  }

  static addFavorite(Favorite favorite) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _ADD_FAVORITE;
    action["client_id"] = favorite.client_id.toString();
    action["product_id"] = favorite.product_id.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static updateFavorite(Favorite favorite) async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _UPDATE_FAVORITE;
    action["client_id"] = favorite.client_id.toString();
    action["product_id"] = favorite.product_id.toString();
    action["favorite_status"] = favorite.status.toString();
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return map.isNotEmpty;
    } else {
      throw Exception("No Data Found");
    }
  }

  static const String _GET_SETTINGS = "GET_SETTINGS";

  static get getSettings async {
    var action = Map<String, dynamic>();
    action["from"] = _FROM_APP;
    action["action"] = _GET_SETTINGS;
    var response = await http.post(_api, body: action);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return Settings.fromJson(map.first);
    } else {
      throw Exception("No Data Found");
    }
  }
}
