import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class OrdersProvider extends ChangeNotifier {
  get loadOrders async {
    isClientLogged;
    if (isClientLogged) {
      int id = Constant.signInClient.id;
      listOfOrders = await DataBaseProvider.getNormalOrder(id);
      myShoppingList = await DataBaseProvider.getShoppingList(id);
      listOfPrescriptions = await DataBaseProvider.getPrescriptionOrder(id);
      myPrescriptionList = await DataBaseProvider.getPrescriptionList(id);
    } else {
      listOfOrders = [];
      myShoppingList = [];
      listOfPrescriptions = [];
      myPrescriptionList = [];
    }
    notifyListeners();
  }

  getNormalOrder(int id) async => await DataBaseProvider.getNormalOrder(id);
  getPrescriptionOrder(int id) async => await DataBaseProvider.getPrescriptionOrder(id);

  addOrder(Order order) async {
    bool state = await DataBaseProvider.addOrder(order);
    loadOrders;
    notifyListeners();
    return state;
  }

  updateOrder(int id) async {
    bool state = await DataBaseProvider.updateOrder(id);
    loadOrders;
    notifyListeners();
    return state;
  }
}
